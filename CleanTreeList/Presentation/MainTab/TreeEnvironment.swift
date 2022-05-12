//
//  TreeEnvironment.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 10/05/2022.
//

import Foundation
import Combine
import Network
import SwiftUI

enum NetworkStatus {
    case requstInProgress, dataLoadedFromWS, dataLoadedFromCD, networkFail
}

class TreeEnvironment: ObservableObject {
    var treeListApiUseCase = TreeListApiUseCase(
        treeListRemoteRepository: TreesRemoteRepositoryImpl(
            remoteDataSource: TreeAPIlmpl(),
            localDataSource: TreeLocalImpl()
        )
    )
    
    var treeListCDUseCase = TreeListCDUseCase(
        treeListCDRepository: TreesCDRepositoryImpl(
            treeCDDataSource: TreeCDImpl()
        )
    )
    
    @Published var geolocatedTrees: [GeolocatedTree] = []
    @Published var isLoadingPage = false
    private var startIndex = 0
    
    // Network Check
    private var cancellables = Set<AnyCancellable>()
    private let monitorQueue = DispatchQueue(label: "monitor")
    @Published var networkStatus: NetworkStatus = .requstInProgress
    @Published var internetConnexionIsOk: Bool = true {
        didSet {
            Task{
                if(internetConnexionIsOk) {
                    await getTrees()
                }else{
                    await loadCDGeolocatedTrees()
                }
            }
        }
    }
    
    
    init() {
        initializeNewtorwMonitor()
        Task {
            await loadCDGeolocatedTrees()
        }
    }
    
    // MARK: - Initializers
    
    func initializeNewtorwMonitor() {
        NWPathMonitor()
            .publisher(queue: monitorQueue)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                DispatchQueue.main.async {
                    if status == .satisfied {
                        withAnimation {
                            self?.internetConnexionIsOk = true
                        }
                    }else{
                        withAnimation {
                            self?.internetConnexionIsOk = false
                        }
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func loadCDGeolocatedTrees() async {
        self.startIndex = 0
        
        let result = await treeListCDUseCase.loadLocalTrees()
        
        switch result {
        case .success(let geolocatedTrees):
            DispatchQueue.main.async {
                if(geolocatedTrees.isEmpty){
                    self.networkStatus = .networkFail
                }else{
                    self.geolocatedTrees = geolocatedTrees
                    self.networkStatus = .dataLoadedFromCD
                }
            }
        case .failure:
            self.networkStatus = .networkFail
            break
        }
    }
    
    func getTrees() async {
        
        guard !isLoadingPage else {
            return
        }
        
        isLoadingPage = true
        let result = await treeListApiUseCase.getTreeList(startIndex: startIndex)
        switch result {
        case .success(let geolocatedTrees):
            DispatchQueue.main.async {
                if self.startIndex == 0 {
                    self.geolocatedTrees = geolocatedTrees.sorted { $0.tree.name! < $1.tree.name! }
                } else {
                    var unSortedGeolocatedTree = geolocatedTrees
                    unSortedGeolocatedTree.append(contentsOf: self.geolocatedTrees)
                    self.geolocatedTrees = unSortedGeolocatedTree.sorted { $0.tree.name! < $1.tree.name! }
                }
                self.networkStatus = .dataLoadedFromWS
                self.startIndex += Int(OpenDataAPI.nbrRowPerRequest) ?? 0
                self.isLoadingPage = false
            }
            
            // Store in CoreData only the 20 first
            if self.startIndex == 0 {
                await self.updateDataBase(geolocatedTrees: geolocatedTrees)
            }
            
        case .failure:
            DispatchQueue.main.async {
                self.isLoadingPage = false
                self.networkStatus = .networkFail
            }
        }
    }
    
    func getMoreTreesIfNeeded(currentTree tree: GeolocatedTree?) async {
        guard let tree = tree else {
            await getTrees()
            return
        }
        
        // Get the endIndex of the geolocatedTrees Array less 5
        let thresholdIndex = geolocatedTrees.index(geolocatedTrees.endIndex, offsetBy: -5)
        
        // Search the currentTree Index and check if it's EndIndex less 5 (To anticipate the end of the list to load more trees)
        if geolocatedTrees.firstIndex(where: {$0.id == tree.id}) == thresholdIndex {
            await getTrees()
        }
    }
    
    func updateDataBase(geolocatedTrees: [GeolocatedTree]) async {
        do {
            try await treeListCDUseCase.clearDataBase()
        } catch {
            print("DataBase cannot be cleared")
        }
        
        do {
            try await treeListCDUseCase.saveGeolocatedTreeListInCoreDataWith(geolocatedTreeList: geolocatedTrees)
        } catch {
            print("Data connot be inserted in DataBase")
        }
    }
}

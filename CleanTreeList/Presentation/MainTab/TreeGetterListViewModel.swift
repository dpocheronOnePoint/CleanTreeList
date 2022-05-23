//
//  TreeGetterListViewModel.swift
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

// FeedbackNotification to improve UX experience --> Only work on RealDevice
let feedback = UINotificationFeedbackGenerator()

class TreeGetterListViewModel: ObservableObject {
    private var treeListApiUseCase = TreeListApiUseCase(
        treeListRemoteRepository: TreesRemoteRepositoryImpl(
            remoteDataSource: TreeAPIlmpl(),
            localDataSource: TreeLocalImpl()
        )
    )
    
    private var treeListCDUseCase = TreeListCDUseCase(
        treeListCDRepository: TreesCDRepositoryImpl(
            treeCDDataSource: TreeCDImpl()
        )
    )
    
    @Published var geolocatedTrees: [GeolocatedTree] = []
    @Published var connexionAlreadyGoBack = false
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
                    // To prevent connexion to 4G and after connexion to Wifi --> Double call
                    if(!connexionAlreadyGoBack){
                        setConnexionAlreadyGoBack(status: true)
                        await getTrees()
                    }
                }else{
                    setConnexionAlreadyGoBack(status: false)
                    if(geolocatedTrees.isEmpty){
                        await loadCDGeolocatedTrees()
                    }
                }
            }
        }
    }
    
    
    init() {
        initializeNewtorwMonitor()
    }
    
    // MARK: - Initializers
    
   private func initializeNewtorwMonitor() {
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
    
    private func loadCDGeolocatedTrees() async {
        self.startIndex = 0
        
        let result = await treeListCDUseCase.loadLocalTrees()
        
        switch result {
        case .success(let geolocatedTrees):
            DispatchQueue.main.async {
                if(geolocatedTrees.isEmpty){
                    self.networkStatus = .networkFail
                }else{
                    self.animateUpdatedList(geolocatedTrees: geolocatedTrees, networkStatus: .dataLoadedFromCD)
                }
            }
        case .failure:
            self.networkStatus = .networkFail
            break
        }
    }
    
    private func animateUpdatedList(geolocatedTrees: [GeolocatedTree], networkStatus: NetworkStatus) {
        withAnimation(.linear(duration: 0.2)){
            self.geolocatedTrees = []
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.linear(duration: 0.2)){
                self.geolocatedTrees = geolocatedTrees
            }
            self.networkStatus = networkStatus
            feedback.notificationOccurred(.success)
        }
    }
    
    func getTrees() async {
        
        guard !isLoadingPage else {
            return
        }
        
        DispatchQueue.main.async {
            self.isLoadingPage = true
        }
        let result = await treeListApiUseCase.getTreeList(startIndex: startIndex)
        switch result {
        case .success(let geolocatedTrees):
            DispatchQueue.main.async {
                if self.startIndex == 0 {
                    self.animateUpdatedList(geolocatedTrees: geolocatedTrees.sorted { $0.tree.name! < $1.tree.name! }, networkStatus: .dataLoadedFromWS)
                } else {
                    var unSortedGeolocatedTree = geolocatedTrees
                    unSortedGeolocatedTree.append(contentsOf: self.geolocatedTrees)
                    self.geolocatedTrees = unSortedGeolocatedTree.sorted { $0.tree.name! < $1.tree.name! }
                }
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
    
    private func updateDataBase(geolocatedTrees: [GeolocatedTree]) async {
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
    
    // MARK: - Utils
    
    // Just a function to externalise Main Thread process to call from didSet switcher
    private func setConnexionAlreadyGoBack(status: Bool) {
        DispatchQueue.main.async {
            self.connexionAlreadyGoBack = status
        }
    }
}
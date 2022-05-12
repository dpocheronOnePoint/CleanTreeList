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
    @Published var geolocatedTreesFromCD: [GeolocatedTree] = []
    @Published var isLoadingPage = false
    @Published var wsError = false
    private var startIndex = 0
    
    // Network Check
    private var cancellables = Set<AnyCancellable>()
    private let monitorQueue = DispatchQueue(label: "monitor")
    @Published var networkStatusIsOK: Bool = true
    
    
    init() {
        initializeNewtorwMonitor()
        //        loadCDGeolocatedTrees()
    }
    
    // MARK: - Initializers
    
    func initializeNewtorwMonitor() {
        NWPathMonitor()
            .publisher(queue: monitorQueue)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                DispatchQueue.main.async {
                    if status == .satisfied {
                        withAnimation() {
                            self?.networkStatusIsOK = true
                        }
                    }else{
                        withAnimation() {
                            self?.networkStatusIsOK = false
                        }
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func loadCDGeolocatedTrees() async {
        let result = await treeListCDUseCase.loadLocalTrees()
        
        switch result {
        case .success(let geolocatedTrees):
            DispatchQueue.main.async {
                self.geolocatedTreesFromCD = geolocatedTrees
            }
        case .failure:
            break
        }
    }
    
    func getTrees() async {
        
        guard !isLoadingPage else {
            return
        }
        
        isLoadingPage = true
        wsError = false
        let result = await treeListApiUseCase.getTreeList(startIndex: startIndex)
        switch result {
        case .success(let geolocatedTrees):
            DispatchQueue.main.async {
                if self.startIndex == 0 {
                    self.geolocatedTrees = geolocatedTrees
                } else {
                    self.geolocatedTrees.append(contentsOf: geolocatedTrees)
                }
                self.startIndex += Int(OpenDataAPI.nbrRowPerRequest) ?? 0
                self.isLoadingPage = false
                self.wsError = false
            }
        case .failure:
            DispatchQueue.main.async {
                self.isLoadingPage = false
                self.wsError = true
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
}

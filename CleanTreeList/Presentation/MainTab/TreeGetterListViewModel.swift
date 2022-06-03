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
import Resolver

enum NetworkStatus {
    case requstInProgress, dataLoadedFromWS, dataLoadedFromLocalDataBase, networkFail
}

protocol TreeGetterListViewProtocol {
    func getTrees() async
    func getMoreTreesIfNeeded(currentTree tree: GeolocatedTree?) async
}

class TreeGetterListViewModel: ObservableObject, TreeGetterListViewProtocol {

    @Injected var treeUseCase: TreeUseCase
    
    @Published var geolocatedTrees: [GeolocatedTree] = []
    @Published var isLoadingPage = false
    var startIndex = 0
    
    // Network Check
    private var cancellables = Set<AnyCancellable>()
    private let monitorQueue = DispatchQueue(label: "monitor")
    @Published var networkStatus: NetworkStatus = .requstInProgress
    @Published var internetConnexionIsOk: Bool = true {
        didSet {
            Task{
                self.startIndex = 0
                await getTrees()
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
    
    
    // MARK: - Remote Methods
    func getTrees() async {
        
        guard !isLoadingPage else {
            return
        }
        
        DispatchQueue.main.async {
            self.isLoadingPage = true
        }
        let result = await treeUseCase.getTreeList(startIndex: startIndex, withConnexion: internetConnexionIsOk)
        switch result {
        case .success(let geolocatedTrees):
            DispatchQueue.main.async {
                if self.startIndex == 0 {
                    self.animateUpdatedList(geolocatedTrees: geolocatedTrees.sorted { $0.tree.name! < $1.tree.name! }, networkStatus: .dataLoadedFromWS)
                } else {
                    var unSortedGeolocatedTree = self.geolocatedTrees
                    unSortedGeolocatedTree.append(contentsOf: geolocatedTrees)
                    self.geolocatedTrees = unSortedGeolocatedTree.sorted { $0.tree.name ?? "" < $1.tree.name ?? "" }
                }
                self.startIndex += Int(OpenDataAPI.nbrRowPerRequest) ?? 0
                self.isLoadingPage = false
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
            return
        }
        
        // Get the endIndex of the geolocatedTrees Array less 5
        let thresholdIndex = geolocatedTrees.index(geolocatedTrees.endIndex, offsetBy: -5)
        
        // Search the currentTree Index and check if it's EndIndex less 5 (To anticipate the end of the list to load more trees)
        if geolocatedTrees.firstIndex(where: {$0.id == tree.id}) == thresholdIndex {
            await getTrees()
        }
    }
    
    // MARK: - Animation Method
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
    
}

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

fileprivate enum DatabaseMethod {
    case CDMethod, RealmMethod
}

enum NetworkStatus {
    case requstInProgress, dataLoadedFromWS, dataLoadedFromLocalDataBase, networkFail
}

// FeedbackNotification to improve UX experience --> Only work on RealDevice
let feedback = UINotificationFeedbackGenerator()

protocol TreeGetterListViewProtocol {
    func getTrees() async
}

class TreeGetterListViewModel: ObservableObject, TreeGetterListViewProtocol {
    
    private var dataBaseMethod: DatabaseMethod = .RealmMethod
    
    // --> Il faut avoir qu'un seul Usecase
    // Il faut injecter les UseCase depuis un fichier UseCase+Injection
    
    // Remote UseCase
    var treeListApiUseCase = TreeListApiUseCase(
        treeListRemoteRepository: TreesRemoteRepositoryImpl()
    )
    
    // CD UseCase
    private var treeListCDUseCase = TreeListCDUseCase(
        treeListCDRepository: TreesCDRepositoryImpl(
            treeCDDataSource: TreeCDImpl()
        )
    )
    
    // Realm UseCase
    private var treeListRealmUseCase = TreeListRealmUseCase(
        treeListRealmRepository: TreeRealmRepositoryImpl(
            treeRealmDataSource: TreeRealmImpl()
        )
    )
    
    @Published var geolocatedTrees: [GeolocatedTree] = []
    @Published var connexionAlreadyGoBack = false
    @Published var isLoadingPage = false
    var startIndex = 0
    
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
                        self.startIndex = 0
                        
                        switch dataBaseMethod {
                        case .CDMethod:
                            await loadCDGeolocatedTrees()
                        case .RealmMethod:
                            await loadRealmGeolocatedTrees()
                        }
                        
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
    
    
    // MARK: - Remote Methods
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
                await self.updateCDDataBase(geolocatedTrees: geolocatedTrees)
                await self.updateRealmDataBase(geolocatedTrees: geolocatedTrees)
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
    
    
    // MARK: - CD Methods
    private func loadCDGeolocatedTrees() async {
        
        let result = await treeListCDUseCase.loadLocalTrees()
        
        switch result {
        case .success(let geolocatedTrees):
            DispatchQueue.main.async {
                if(geolocatedTrees.isEmpty){
                    self.networkStatus = .networkFail
                }else{
                    self.animateUpdatedList(geolocatedTrees: geolocatedTrees, networkStatus: .dataLoadedFromLocalDataBase)
                }
            }
        case .failure:
            self.networkStatus = .networkFail
            break
        }
    }
    
    private func updateCDDataBase(geolocatedTrees: [GeolocatedTree]) async {
        // Clear Database
        do {
            try await treeListCDUseCase.clearDataBase()
        } catch {
            print("DataBase cannot be cleared")
        }
        
        // Insert new GeolocatedTree Objects
        do {
            try await treeListCDUseCase.saveGeolocatedTreeListInCoreDataWith(geolocatedTreeList: geolocatedTrees)
        } catch {
            print("Data connot be inserted in DataBase")
        }
    }
    
    
    // MARK: - Realm Methods
    private func loadRealmGeolocatedTrees() async {
        let result = await treeListRealmUseCase.loadLocalTrees()
        
        switch result {
        case .success(let geolocatedTrees):
            DispatchQueue.main.async {
                if(geolocatedTrees.isEmpty){
                    self.networkStatus = .networkFail
                }else{
                    self.animateUpdatedList(geolocatedTrees: geolocatedTrees, networkStatus: .dataLoadedFromLocalDataBase)
                }
            }
        case .failure:
            self.networkStatus = .networkFail
            break
        }
    }
    
    private func updateRealmDataBase(geolocatedTrees: [GeolocatedTree]) async {
        
        // Clear Database
        do {
            try await treeListRealmUseCase.clearDataBase()
        } catch {
            print("Realm Database cannot be deleted")
        }
        
        // Insert new GeolocatedTree Objects
        do {
            try await treeListRealmUseCase.saveGeolocatedTreeInRealmwiWith(geolocatedTreeList: geolocatedTrees)
        } catch {
            print("Data cannot be inserted in realm")
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
    
    // MARK: - Utils
    
    // Just a function to externalise Main Thread process to call from didSet switcher
    private func setConnexionAlreadyGoBack(status: Bool) {
        DispatchQueue.main.async {
            self.connexionAlreadyGoBack = status
        }
    }
}

//
//  TreeEnvironment.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 10/05/2022.
//

import Foundation

class TreeEnvironment: ObservableObject {
    var getTreeListUseCase = GetTreeListUseCase(treeListRepository: TreeRepositoryImpl(dataSource: TreeAPIlmpl()))
    @Published var geolocatedTrees: [GeolocatedTree] = []
    @Published var isLoadingPage = false
    private var startIndex = 0
    
//    init() {
//        loadLocalTrees()
//    }
    
    func loadLocalTrees() {
        let result = getTreeListUseCase.loadLocalTrees()
        switch result {
        case .success(let geolocatedTrees):
            DispatchQueue.main.async {
                self.geolocatedTrees = geolocatedTrees
            }
        case .failure:
            // Error from DB
            break
        }
    }
    
    func getTrees() async {
        
        guard !isLoadingPage else {
            return
        }
        
        isLoadingPage = true
        let result = await getTreeListUseCase.execute(startIndex: startIndex)
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
            }
        case .failure:
            DispatchQueue.main.async {
                self.geolocatedTrees = []
                self.isLoadingPage = false
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

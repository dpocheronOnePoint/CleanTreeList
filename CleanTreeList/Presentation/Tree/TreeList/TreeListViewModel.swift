//
//  TreeListViewMode.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

class TreeListViewModel: ObservableObject {
    
    var getTreeListUseCase = GetTreeListUseCase(treeListRepository: TreeRepositoryImpl(dataSource: TreeAPIlmpl()))
    @Published var geolocatedTrees: [GeolocatedTree] = []
    @Published var errorMessage: String = ""
    @Published var hasError: Bool = false
    
    func getTrees() async {
        errorMessage = ""
        let result = await getTreeListUseCase.execute() 
        switch result {
        case .success(let geolocatedTrees):
            DispatchQueue.main.async {
                self.geolocatedTrees = geolocatedTrees
            }
        case .failure(let error):
            DispatchQueue.main.async {
                self.geolocatedTrees = []
                self.errorMessage = error.localizedDescription
                self.hasError = true
            }
        }
    }
}

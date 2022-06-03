//
//  TreeListViewModel.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import Foundation

protocol TreeListViewModelProtocol {
    func filterTreeResult(searchText: String, allGeolocatedTrees: [GeolocatedTree])
}

class TreeListViewModel: ObservableObject {
    @Published var isSearchingProcess: Bool = false
    @Published var geolocatedTrees: [GeolocatedTree] = []
    
    func filterTreeResult(searchText: String, allGeolocatedTrees: [GeolocatedTree]) {
        geolocatedTrees = allGeolocatedTrees.filter {
            $0.tree.name != nil && $0.tree.name!.contains(searchText)
        }
        isSearchingProcess = true
    }

    func cancelSearchProcess() {
        isSearchingProcess = false
    }
}

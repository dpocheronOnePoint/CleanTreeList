//
//  TreeListViewModel.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import Foundation
import Moya
import Combine

protocol TreeListViewModelProtocol {
    func filterTreeResult(searchText: String, allGeolocatedTrees: [GeolocatedTree])
    func cancelSearchProcess()
    
    // #### MoyaExemple ####
//    func getTreeListWithMoya(startIndew: Int) -> [RecordData]
}

class TreeListViewModel: ObservableObject {
    @Published var isSearchingProcess: Bool = false
    @Published var geolocatedTrees: [GeolocatedTree] = []
    
    var cancellable: AnyCancellable?
    
    func filterTreeResult(searchText: String, allGeolocatedTrees: [GeolocatedTree]) {
        geolocatedTrees = allGeolocatedTrees.filter {
            $0.tree.name != nil && $0.tree.name!.contains(searchText)
        }
        isSearchingProcess = true
    }

    func cancelSearchProcess() {
        isSearchingProcess = false
    }
    
    // #### MoyaExemple ####
//    func getTreeListWithMoya(startIndew: Int) -> [RecordData] {
//        let provider = MoyaProvider<TreeMoyaProvider>()
//        cancellable = provider.requestPublisher(.search)
//            .sink(receiveCompletion: { completion in
//                guard case let .failure(error) = completion else { return }
//
//                print(error)
//            }, receiveValue: { response in
//                guard let data = try? response.mapJSON() else {
//                    return
//                }
//                print("data: ", data)
//            })
//        return []
//    }
}

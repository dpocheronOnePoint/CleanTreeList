//
//  TreeListCDUseCase.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 11/05/2022.
//

import Foundation
import CoreData

enum UseCaseCDError: Error {
    case fetchingError
}

protocol TreeListCDUseCaseProtocol {
    func loadLocalTrees() async -> Result<[GeolocatedTree], UseCaseCDError>
}

struct TreeListCDUseCase: TreeListCDUseCaseProtocol {
    
    var treeListCDRepository: TreeListCDRepository
    
    func loadLocalTrees() async -> Result<[GeolocatedTree], UseCaseCDError> {
        do {
            let cdGeolocatedTrees = try await treeListCDRepository.loadLocalTrees()
            
            let geolocatedTrees: [GeolocatedTree] = cdGeolocatedTrees.map({ item in
                GeolocatedTree(
                    tree: item.tree.ToDomain(),
                    lng: item.lng,
                    lat: item.lat
                )
            })
            
            return .success(geolocatedTrees)
        } catch {
            return .failure(.fetchingError)
        }
    }
    
    
}

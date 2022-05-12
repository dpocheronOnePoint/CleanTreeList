//
//  TreeCDRepositoryImpl.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 11/05/2022.
//

import Foundation

struct TreesCDRepositoryImpl: TreeListCDRepository {
    var treeCDDataSource: TreeCDDataSource
    
    func loadLocalTrees() async throws -> [CDGeolocatedTree] {
        let cdGeolocatedTrees = try await treeCDDataSource.loadLocalTrees()
        return cdGeolocatedTrees
    }
}

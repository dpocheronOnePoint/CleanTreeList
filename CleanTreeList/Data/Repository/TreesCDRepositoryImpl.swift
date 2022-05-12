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
    
    func clearDataBase() async throws {
        try await treeCDDataSource.clearDataBase()
    }
    
    func saveGeolocatedTreeListInCoreDataWith(geolocatedTreeList: [GeolocatedTree]) async throws {
        try  await treeCDDataSource.saveGeolocatedTreeListInCoreDataWith(geolocatedTreeList: geolocatedTreeList)
    }
}

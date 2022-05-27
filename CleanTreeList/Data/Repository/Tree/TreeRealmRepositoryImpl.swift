//
//  TreeRealmRepositoryImpl.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 23/05/2022.
//

import Foundation
import RealmSwift
import Resolver

struct TreeRealmRepositoryImpl: TreeListRealmRepository {
    @Injected var treeRealmDataSource: TreeRealmDataSource
    
    func loadLocalTrees() async throws -> Results<RealmGeolocatedTree> {
        let realmGeolocatedtrees = try await treeRealmDataSource.loadLocalTrees()
        return realmGeolocatedtrees
    }
    
    func clearDataBase() async throws {
        try await treeRealmDataSource.clearDataBase()
    }
    
    func saveGeolocatedTreeInRealmwiWith(geolocatedTreeList: [GeolocatedTree]) async throws {
        try await treeRealmDataSource.saveGeolocatedTreeInRealmwiWith(geolocatedTreeList: geolocatedTreeList)
    }
    
    
}

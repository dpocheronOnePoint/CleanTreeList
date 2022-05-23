//
//  TreeRealmRepositoryImpl.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 23/05/2022.
//

import Foundation

struct TreeRealmRepositoryImpl: TreeListRealmRepository {
    var treeRealmDataSource: TreeRealmDataSource
    
    func saveGeolocatedTreeInRealmwiWith(geolocatedTreeList: [GeolocatedTree]) async throws {
        try await treeRealmDataSource.saveGeolocatedTreeInRealmwiWith(geolocatedTreeList: geolocatedTreeList)
    }
    
    
}

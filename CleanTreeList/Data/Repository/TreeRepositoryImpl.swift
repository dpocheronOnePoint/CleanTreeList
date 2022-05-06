//
//  TreeRepositoryImpl.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

struct TreeRepositoryImpl: TreeListRepository {

    var dataSource: TreeDataSource
    
    func getTreeList(startRow: Int) async throws -> [GeolocatedTree] {
        let trees = try await dataSource.getTreeList(startRow: startRow)
        return trees
    }
    
    func getTreeListWithApiManager(startRow: Int) async throws -> [GeolocatedTree] {
        let trees = try await dataSource.getTreeListWithApiManager(startRow: startRow)
        return trees
    }
    
    func getTreeListFromLocal() async throws -> [GeolocatedTree] {
        let trees = try await dataSource.getTreeListFromLocal()
        return trees
    }
}

//
//  TreeRepositoryImpl.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

struct TreeRepositoryImpl: TreeListRepository {

    var dataSource: TreeDataSource
    
    func getTreeList(startIndex: Int) async throws -> [GeolocatedTree] {
        let trees = try await dataSource.getTreeList(startIndex: startIndex)
        return trees
    }
    
    func getTreeListWithApiManager(startIndex: Int) async throws -> [GeolocatedTree] {
        let trees = try await dataSource.getTreeListWithApiManager(startIndex: startIndex)
        return trees
    }
    
    func getTreeListFromLocal() async throws -> [GeolocatedTree] {
        let trees = try await dataSource.getTreeListFromLocal()
        return trees
    }
}

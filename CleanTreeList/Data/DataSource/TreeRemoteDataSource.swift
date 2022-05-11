//
//  TreeDataSource.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

protocol TreeRemoteDataSource {
    func getTreeList(startIndex: Int) async throws -> [GeolocatedTree]
    func getTreeListWithApiManager(startIndex: Int) async throws -> [GeolocatedTree]
}

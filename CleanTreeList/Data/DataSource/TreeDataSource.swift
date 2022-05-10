//
//  TreeDataSource.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

protocol TreeDataSource {
    func getTreeList(startIndex: Int) async throws -> [GeolocatedTree]
    func getTreeListWithApiManager(startIndex: Int) async throws -> [GeolocatedTree]
    func getTreeListFromLocal() async throws -> [GeolocatedTree]
}

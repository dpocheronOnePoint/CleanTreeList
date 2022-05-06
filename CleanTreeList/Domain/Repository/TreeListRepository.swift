//
//  TreeListRepository.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

protocol TreeListRepository {
    func getTreeList(startRow: Int) async throws -> [GeolocatedTree]
    func getTreeListWithApiManager(startRow: Int) async throws -> [GeolocatedTree]
    func getTreeListFromLocal() async throws -> [GeolocatedTree]
}

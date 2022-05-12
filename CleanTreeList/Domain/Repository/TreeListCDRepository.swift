//
//  TreeListCDRepository.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 12/05/2022.
//

import Foundation

protocol TreeListCDRepository {
    func loadLocalTrees() async throws -> [CDGeolocatedTree]
    func clearDataBase() async throws
    func saveGeolocatedTreeListInCoreDataWith(geolocatedTreeList: [GeolocatedTree]) async throws
}

//
//  TreeCDDataSource.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 11/05/2022.
//

import Foundation

protocol TreeCDDataSource {
    func loadLocalTrees() async throws -> [CDGeolocatedTree]
    func clearDataBase() async throws
    func saveGeolocatedTreeListInCoreDataWith(geolocatedTreeList: [GeolocatedTree]) throws
}

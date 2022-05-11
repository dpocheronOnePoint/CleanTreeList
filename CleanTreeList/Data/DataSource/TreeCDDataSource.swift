//
//  TreeCDDataSource.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 11/05/2022.
//

import Foundation

protocol TreeDBDataSource {
    func loadLocalTrees() throws -> [CDGeolocatedTree]
    func clearDataBase() async throws
    func saveGeolocatedTreeListInCoreDataWith(geolocatedTreeList: [GeolocatedTree]) throws
}

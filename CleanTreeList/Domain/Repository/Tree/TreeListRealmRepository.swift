//
//  TreeRealmRepository.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 23/05/2022.
//

import Foundation
import RealmSwift

protocol TreeListRealmRepository {
    func loadLocalTrees() async throws -> Results<RealmGeolocatedTree>
    func clearDataBase() async throws
    func saveGeolocatedTreeInRealmwiWith(geolocatedTreeList: [GeolocatedTree]) async throws
}

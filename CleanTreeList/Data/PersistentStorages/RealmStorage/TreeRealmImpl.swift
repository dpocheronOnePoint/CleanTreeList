//
//  TreeRealmImpl.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 23/05/2022.
//

import Foundation
import RealmSwift

enum RealmError: Error {
    case fetchingError
}

struct TreeRealmImpl: TreeRealmDataSource {
    func saveGeolocatedTreeInRealmwiWith(geolocatedTreeList: [GeolocatedTree]) async throws {
        if let localRealm = RealmManager().localrealm {
            do {
                try localRealm.write {
                    for geolocatedTree in geolocatedTreeList {
                        localRealm.add(geolocatedTree.toRealm())
                    }
                }
            } catch {
                print("Error")
            }
        }
    }
    
    
}

//
//  TreeRealmImpl.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 23/05/2022.
//

import Foundation
import RealmSwift

enum RealmError: Error {
    case loadingRealmError, fetchingError, deletingError ,insertingError
}

struct TreeRealmImpl: TreeRealmDataSource {
    func loadLocalTrees() async throws -> Results<RealmGeolocatedTree> {
        guard let localRealm = RealmManager().localrealm else {
            throw RealmError.loadingRealmError
        }
        
        let geolocatedTreesList = localRealm.objects(RealmGeolocatedTree.self)
        
        return geolocatedTreesList
    }
    
    func clearDataBase() async throws {
        if let localRealm = RealmManager().localrealm {
            do {
                try localRealm.write {
                    let allRegisterGeolocatedTree = localRealm.objects(RealmGeolocatedTree.self)
                    localRealm.delete(allRegisterGeolocatedTree)
                }
            } catch {
                throw RealmError.deletingError
            }
        }
    }
    
    func saveGeolocatedTreeInRealmwiWith(geolocatedTreeList: [GeolocatedTree]) async throws {
        if let localRealm = RealmManager().localrealm {
            do {
                try localRealm.write {
                    for geolocatedTree in geolocatedTreeList {
                        
                        let realmGeolocatedTree = geolocatedTree.ToRealm()
                        
                        localRealm.add(realmGeolocatedTree)
                    }
                }
            } catch {
                throw RealmError.insertingError
            }
        }
    }
    
    
}

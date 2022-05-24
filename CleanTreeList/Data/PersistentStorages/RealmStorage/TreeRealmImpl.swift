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
                        
                        #warning("Need to add protocol")
                        
                        let realmTree = RealmTree(value: [
                            "name": geolocatedTree.tree.name ?? "",
                            "species": geolocatedTree.tree.species ?? "",
                            "address": geolocatedTree.tree.address,
                            "address2": geolocatedTree.tree.address2 ?? "",
                            "height": geolocatedTree.tree.height,
                            "circumference": geolocatedTree.tree.circumference
                        ])
                        
                        let realmGeolocatedTree = RealmGeolocatedTree(value: [
                            "tree": realmTree,
                            "lat": geolocatedTree.lat,
                            "lng": geolocatedTree.lng
                        ])
                        
                        localRealm.add(realmGeolocatedTree)
                    }
                }
            } catch {
                throw RealmError.insertingError
            }
        }
    }
    
    
}

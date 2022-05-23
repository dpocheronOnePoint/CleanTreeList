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
                        print("Tree is inserted")
                        
                        let realmTrees = localRealm.objects(RealmGeolocatedTree.self)
                        let lastrealm = realmTrees.last
                        print(realmTrees.count)
                        print(lastrealm)
                    }
                }
            } catch {
                print("Error")
            }
        }
    }
    
    
}

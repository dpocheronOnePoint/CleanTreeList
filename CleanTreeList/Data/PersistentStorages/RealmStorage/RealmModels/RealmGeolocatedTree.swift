//
//  RealmGeolocatedTree.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 23/05/2022.
//

import Foundation
import RealmSwift

final class RealmGeolocatedTree: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var tree = RealmTree()
    
    @Persisted var lat: Double = 0.0
    
    @Persisted var lng: Double = 0.0
}

extension GeolocatedTree: DomainToRealm {
    func toRealm() -> RealmGeolocatedTree {
        let realmGeolocatedTree = RealmGeolocatedTree(value: [
            "tree": tree.toRealm(),
            "lat": lat,
            "lng": lng
        ])
        return realmGeolocatedTree
    }
}

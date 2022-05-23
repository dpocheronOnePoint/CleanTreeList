//
//  RealmGeolocatedTree.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 23/05/2022.
//

import Foundation
import RealmSwift

final class RealmGeolocatedTree: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var tree: RealmTree?
    
    @Persisted var lat: Double
    
    @Persisted var lng: Double
}

//extension GeolocatedTree: DomainToRealm {
//    func toRealm() -> RealmGeolocatedTree {
//        let realmGeolocatedTree = RealmGeolocatedTree(value: [
//            "tree": tree.toRealm(),
//            "lat": lat,
//            "lng": lng
//        ])
//        return realmGeolocatedTree
//    }
//}

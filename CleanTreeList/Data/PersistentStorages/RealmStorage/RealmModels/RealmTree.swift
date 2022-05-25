//
//  RealmTree.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 23/05/2022.
//

import Foundation
import RealmSwift

class RealmTree: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var name: String?
    
    @Persisted var species: String?
    
    @Persisted var address: String
    
    @Persisted var address2: String?
    
    @Persisted var height: Int16
    
    @Persisted var circumference: Int16
}

extension Tree: DomainToRealm {
    func ToRealm() -> RealmTree {
        let realmTree = RealmTree(value: [
            "name": name ?? "",
            "species": species ?? "",
            "address": address,
            "address2": address2 ?? "",
            "height": height,
            "circumference": circumference
        ])
        
        return realmTree
    }
}

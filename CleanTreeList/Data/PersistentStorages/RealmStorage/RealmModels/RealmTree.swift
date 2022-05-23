//
//  RealmTree.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 23/05/2022.
//

import Foundation
import RealmSwift

final class RealmTree: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var name: String = ""
    
    @Persisted var species: String = ""
    
    @Persisted var address: String = ""
    
    @Persisted var address2: String = ""
    
    @Persisted var height: Int16 = 0
    
    @Persisted var circumference: Int16 = 0
    
}

extension Tree: DomainToRealm {
    func toRealm() -> RealmTree {
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

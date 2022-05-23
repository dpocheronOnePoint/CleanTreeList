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

//
//  TreeLocalImpl.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 11/05/2022.
//

import Foundation

struct TreeLocalImpl: TreeLocalDataSource {
    
    func getTreeListFromLocal() async throws -> [RecordData] {
        
        // Map result to Records Object and return it
        let result: Records = try Bundle.main.decode(Records.self, from: "trees.json")
        return result.records
    }
}

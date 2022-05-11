//
//  TreeLocalImpl.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 11/05/2022.
//

import Foundation

struct TreeLocalImpl: TreeLocalDataSource {
    
    func getTreeListFromLocal() async throws -> [GeolocatedTree] {
        
        // Map result to Records Object
        let result: Records = try Bundle.main.decode(Records.self, from: "trees.json")
        
        // Convert Records Object to GeolocatedAPI Array and return it
        return result.records.map({ item in
            GeolocatedTree(
                tree: item.fields.ToDomain(),
                lng: item.geometry.coordinates[0],
                lat: item.geometry.coordinates[1]
            )
        })
    }
}

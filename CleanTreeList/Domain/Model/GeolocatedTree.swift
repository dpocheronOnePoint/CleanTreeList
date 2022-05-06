//
//  GeolocatedTree.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

struct GeolocatedTree: Codable, Identifiable {
    let tree: Tree
    let lng, lat: Double
    var id: Int {
        tree.id
    }
}

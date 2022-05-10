//
//  GeolocatedTree.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

struct GeolocatedTree: Codable, Identifiable {
    var id = UUID()
    let tree: Tree
    let lng, lat: Double
    var treeId: Int {
        tree.id
    }
}

extension GeolocatedTree {
    static let geolocatedTreeSampleData = GeolocatedTree(tree: Tree.treeSampleData, lng: 10.0, lat: 20.0)
}

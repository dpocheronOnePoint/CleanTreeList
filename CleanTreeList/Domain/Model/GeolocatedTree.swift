//
//  GeolocatedTree.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation
import MapKit

struct GeolocatedTree: Codable, Identifiable {
    var id = UUID()
    let tree: Tree
    let lng, lat: Double
    
    // Computed Property
    var location: CLLocationCoordinate2D {
      CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
}

extension CDGeolocatedTree: DataToDomain {
    func ToDomain() -> GeolocatedTree {
        GeolocatedTree(
            tree: tree.ToDomain(),
            lng: lng,
            lat: lat
        )
    }
}
extension GeolocatedTree {
    static let geolocatedTreeSampleData = GeolocatedTree(tree: Tree.treeSampleData, lng: 10.0, lat: 20.0)
}

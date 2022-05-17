//
//  TreeItem.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 17/05/2022.
//

import Foundation
import MapKit

final class TreeItem: NSObject, MKAnnotation {
    let id = UUID()
    let geolocatedTree: GeolocatedTree
    let coordinate: CLLocationCoordinate2D
    var image: UIImage {
        return #imageLiteral(resourceName: "treeAnnocation")
    }
    
    init(coordinate: CLLocationCoordinate2D, geolocatedTree: GeolocatedTree) {
        self.coordinate = coordinate
        self.geolocatedTree = geolocatedTree
    }
}

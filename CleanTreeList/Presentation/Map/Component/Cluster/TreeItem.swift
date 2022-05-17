//
//  TreeItem.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 17/05/2022.
//

import Foundation
import MapKit

final class TreeItem: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    var image: UIImage {
        return #imageLiteral(resourceName: "annotation")
    }
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}

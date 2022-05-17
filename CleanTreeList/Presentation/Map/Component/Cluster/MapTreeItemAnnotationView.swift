//
//  MapTreeItemAnnotationView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 17/05/2022.
//

import MapKit

final class MapTreeItemAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        didSet {
            guard let mapItem = annotation as? TreeItem else {
                return
            }
            
            // Line necessary to activate Clustering !
            clusteringIdentifier = "MapItem"
            
            image = mapItem.image
        }
    }
}

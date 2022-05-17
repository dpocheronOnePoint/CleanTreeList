//
//  ClusterTreeAnnotationView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 17/05/2022.
//

import UIKit
import MapKit

final class ClusterTreeAnnotationView: MKAnnotationView {
    
    override var annotation: MKAnnotation? {
        didSet {
            
            guard let cluster = annotation as? MKClusterAnnotation else { return }
            displayPriority = .defaultHigh
            
            let rect = CGRect(x: 0, y: 0, width: 40, height: 40)
            image = UIGraphicsImageRenderer.image(for: cluster.memberAnnotations, in: rect)
        }
    }
}

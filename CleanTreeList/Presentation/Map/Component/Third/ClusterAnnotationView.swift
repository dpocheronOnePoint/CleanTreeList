//
//  ClusterAnnotationView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 16/05/2022.
//
//
//import UIKit
//import MapKit
//
//final class ClusterAnnotationView: MKAnnotationView {
//
//    override var annotation: MKAnnotation? {
//        didSet {
//
//            guard let cluster = annotation as? MKClusterAnnotation else { return }
//            print("Here !! ")
//            displayPriority = .defaultHigh
//
//            let rect = CGRect(x: 0, y: 0, width: 40, height: 40)
//            image = UIGraphicsImageRenderer.image(for: cluster.memberAnnotations, in: rect)
//        }
//    }
//}

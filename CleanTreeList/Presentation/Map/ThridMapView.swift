//
//  ThridMapView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 16/05/2022.
//

//import SwiftUI
//import MapKit
//
//struct ThridMapView: View {
//    var body: some View {
//        SecondMapViewRepresentable()
//    }
//}
//
//struct ThridMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThridMapView()
//    }
//}
//
//struct SecondMapViewRepresentable: UIViewRepresentable {
//    typealias UIViewType = MKMapView
//    
//    let region: MKCoordinateRegion = {
//        var mapCoordinates = CLLocationCoordinate2D(latitude: 40.0166, longitude: -105.2817)
//        var mapZoomLevel = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//        var mapRegion = MKCoordinateRegion(center: mapCoordinates, span: mapZoomLevel)
//        
//        return mapRegion
//    }()
//    
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        
//        mapView.register(
//            MapItemAnnotationView.self,
//            forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
//        mapView.register(
//            ClusterAnnotationView.self,
//            forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
//        
//        mapView.setRegion(region, animated: true)
//        
//        for randCoordinate in makeRandomCoordinates(in: region) {
//            let annotation = MapItem(coordinate: randCoordinate)
//            mapView.addAnnotation(annotation)
//        }
//        
//        return mapView
//    }
//    
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        
//    }
//}

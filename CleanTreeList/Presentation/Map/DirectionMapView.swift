//
//  SecondMapView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 16/05/2022.
//

import SwiftUI
import MapKit

struct DirectionMapView: View {
    var body: some View {
        ZStack {
            DirectionMapViewRepresentable()
        }
    }
}

struct DirectionMapView_Previews: PreviewProvider {
    static var previews: some View {
        DirectionMapView()
    }
}

struct DirectionMapViewRepresentable: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    let region: MKCoordinateRegion = {
        var mapCoordinates = CLLocationCoordinate2D(latitude: 40.71, longitude: -74)
        var mapZoomLevel = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        var mapRegion = MKCoordinateRegion(center: mapCoordinates, span: mapZoomLevel)
        
        return mapRegion
    }()
    
    let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.71, longitude: -74))
    let p1Point: MKPointAnnotation = {
        let point = MKPointAnnotation()
        point.title = "NewYork"
        point.coordinate = CLLocationCoordinate2D(latitude: 40.71, longitude: -74)
        return point
    }()
    
    let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.36, longitude: -71.05))
    
    let p2Point: MKPointAnnotation = {
        let point = MKPointAnnotation()
        point.title = "Destination"
        point.coordinate = CLLocationCoordinate2D(latitude: 42.36, longitude: -71.05)
        return point
    }()
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: true)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else {
                return
            }
            
            mapView.addAnnotations([p1Point, p2Point])
            
            mapView.addOverlay(route.polyline)
            
            mapView.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                animated: true)
        }
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .blue
            renderer.lineWidth = 5
            return renderer
        }
    }
}

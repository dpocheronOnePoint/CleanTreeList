//
//  ForthMapView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 17/05/2022.
//

import SwiftUI
import MapKit

struct ClusterMapView: View {
    @EnvironmentObject var treeEnvironment: TreeEnvironment
    
    var body: some View {
        ClusterMapViewRepresentable(treeList: $treeEnvironment.geolocatedTrees)
    }
}

struct ForthMapView_Previews: PreviewProvider {
    static var previews: some View {
        ClusterMapView()
    }
}

 // Interesting link
 // https://thomas-sivilay.github.io/morningswiftui.github.io/swiftui/2019/07/31/build-mapview-app-with-swiftui.html

struct ClusterMapViewRepresentable: UIViewRepresentable {
    
    @Binding var treeList: [GeolocatedTree]
    
    typealias UIViewType = MKMapView
    
    let region: MKCoordinateRegion = {
        var mapCoordinates = CLLocationCoordinate2D(latitude: 48.856614, longitude: 2.3522219)
        var mapZoomLevel = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
        var mapRegion = MKCoordinateRegion(center: mapCoordinates, span: mapZoomLevel)
        
        return mapRegion
    }()
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        mapView.register(
            MapTreeItemAnnotationView.self,
            forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        mapView.register(
            ClusterTreeAnnotationView.self,
            forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        
        mapView.setRegion(region, animated: true)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        updateAnnotations(from: uiView)
    }
    
    private func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        let newAnnotations = treeList.map { TreeItem(coordinate: $0.location) }
      mapView.addAnnotations(newAnnotations)
    }
}

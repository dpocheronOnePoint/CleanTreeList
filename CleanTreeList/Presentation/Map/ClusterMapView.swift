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
    @StateObject var mapViewModel = MapViewModel()
    
    var body: some View {
        ZStack {
            ClusterMapViewRepresentable(mapViewModel: mapViewModel)
            
            BlankBlurView(backgroundColor: Color.gray, backgroundOpacity: 0.5)
                .onTapGesture {
                    mapViewModel.deselectTree()
                }
                .opacity(mapViewModel.showTreeDetail ? 1.0 : 0.0)
            
            MapTreeDetailsView(geolocatedTree: mapViewModel.selectedTree)
                .opacity(mapViewModel.showTreeDetail ? 1.0 : 0.0)
        }
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
    @EnvironmentObject var treeEnvironment: TreeEnvironment
    @StateObject var mapViewModel: MapViewModel
    
    typealias UIViewType = MKMapView
    
    let region: MKCoordinateRegion = {
        var mapCoordinates = CLLocationCoordinate2D(latitude: 48.856614, longitude: 2.3522219)
        var mapZoomLevel = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
        var mapRegion = MKCoordinateRegion(center: mapCoordinates, span: mapZoomLevel)
        
        return mapRegion
    }()
    
    // Function to set the map coordinator --> MapView delegate method
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        mapView.delegate = context.coordinator
        
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
        let newAnnotations = treeEnvironment.geolocatedTrees.map { TreeItem(coordinate: $0.location, geolocatedTree: $0) }
        mapView.addAnnotations(newAnnotations)
    }
    
    // MARK: - MapViewCoordinator
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        var parent: ClusterMapViewRepresentable
        
        init(parent: ClusterMapViewRepresentable) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let treeItem = view.annotation as? TreeItem else {
                return print("Click on cluster pin")
            }

            if let findedTree = mapView.annotations.first(where: { ($0 as? TreeItem)?.id == treeItem.id }) {
                if let findedTree = findedTree as? TreeItem {
                    parent.mapViewModel.selectedTree = findedTree.geolocatedTree
                    withAnimation() {
                        parent.mapViewModel.showTreeDetail = true
                    }
                }
            }
        }
    }
}

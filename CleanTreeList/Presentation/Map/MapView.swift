//
//  MapView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 10/05/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var treeEnvironment: TreeEnvironment
    
    @StateObject var mapViewModel = MapViewModel()
    
    @State private var region: MKCoordinateRegion = {
        var mapCoordinates = CLLocationCoordinate2D(latitude: 48.856614, longitude: 2.3522219)
        var mapZoomLevel = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
        var mapRegion = MKCoordinateRegion(center: mapCoordinates, span: mapZoomLevel)
        
        return mapRegion
    }()
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: treeEnvironment.geolocatedTrees, annotationContent: { item in
                MapAnnotation(coordinate: item.location) {
                    MapAnnotationView()
                        .onTapGesture {
                            mapViewModel.selectTree(geolocatedTree: item)
                        }
                }
            })

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

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(TreeEnvironment())
    }
}

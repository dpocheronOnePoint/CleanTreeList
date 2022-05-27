//
//  MapViewModel.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import Foundation
import SwiftUI

protocol MapViewModelProtocol {
    func selectTree(geolocatedTree: GeolocatedTree)
    func deselectTree()
}

class MapViewModel: ObservableObject, MapViewModelProtocol {
    @Published var showTreeDetail: Bool = false
    @Published var selectedTree: GeolocatedTree = GeolocatedTree.geolocatedTreeSampleData
    
    func selectTree(geolocatedTree: GeolocatedTree) {
        selectedTree = geolocatedTree
        withAnimation() {
            showTreeDetail = true
        }
    }
    
    func deselectTree() {
        withAnimation() {
            showTreeDetail = false
        }
    }
}

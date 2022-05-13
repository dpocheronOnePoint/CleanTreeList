//
//  MapViewModel.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import Foundation
import SwiftUI

class MapViewModel: ObservableObject {
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

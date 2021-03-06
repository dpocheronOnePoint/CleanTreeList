//
//  MainTabView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 10/05/2022.
//

import SwiftUI

struct MainTabView: View {
    private let isClusterMapView: Bool = true
    
    var body: some View {
        
        TabView {
            
            // MARK: - Users Item
            UsersView()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Utilisateurs")
                }
            
            // MARK: - TreeList Item
            TreeListView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Liste")
                }
            
            // MARK: - Map Item
            if(isClusterMapView) {
                ClusterMapView()
                    .tabItem {
                        Image(systemName: "map.fill")
                        Text("Carte")
                    }
            } else {
                MapView()
                    .tabItem {
                        Image(systemName: "map.fill")
                        Text("Carte")
                    }
            }
            
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

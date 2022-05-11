//
//  MainTabView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 10/05/2022.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var treeEnvironment = TreeEnvironment()
    
    var body: some View {
        if treeEnvironment.geolocatedTrees.count > 0 {
            
            TabView {
                TreeListView()
                    .tabItem {
                        Image(systemName: "square.grid.2x2")
                        Text("Liste")
                    }
                
                MapView()
                    .tabItem {
                        Image(systemName: "map.fill")
                        Text("Carte")
                    }
            }
            .environmentObject(treeEnvironment)
            
        }else if(treeEnvironment.wsError){
            
            Text("Une erreur est survenue")
            
        } else {
            
            ProgressView()
                .task {
                    await treeEnvironment.getTrees()
                }
            
        }
        
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

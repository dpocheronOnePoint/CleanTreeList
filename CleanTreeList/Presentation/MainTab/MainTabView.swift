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
        if(treeEnvironment.networkStatus == .requstInProgress){
            ProgressView()
        }else if (treeEnvironment.networkStatus == .networkFail){
            ErrorView()
                .environmentObject(treeEnvironment)
        }else{
            TabView {
                UsersView()
                    .tabItem {
                        Image(systemName: "person.circle.fill")
                        Text("Utilisateurs")
                    }
                
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
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

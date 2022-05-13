//
//  TreeListComponentView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 09/05/2022.
//

import SwiftUI

struct TreeListComponentView: View {
    @EnvironmentObject var treeEnvironment: TreeEnvironment
    
    @StateObject var treeListViewModel = TreeListViewModel()
    
    @State private var searchText: String = ""
    
    var body: some View {
        
        // If SearchProcess --> display filter list from TreeListViewModel
        // Else --> Display all tree from TreeEnvironment
        
        List(treeListViewModel.isSearchingProcess ? treeListViewModel.geolocatedTrees : treeEnvironment.geolocatedTrees) { geolocatedTree in
            TreeItemView(geolocatedTree: geolocatedTree)
                .task {
                    if(treeEnvironment.internetConnexionIsOk) {
                        await treeEnvironment.getMoreTreesIfNeeded(currentTree: geolocatedTree)
                    }
                }
        } //: LIST
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "searchPlaceholder")
        
        .onChange(of: searchText) { _ in
            if(searchText.isEmpty) {
                treeListViewModel.cancelSearchProcess()
            }else{
                treeListViewModel.filterTreeResult(searchText: searchText, allGeolocatedTrees: treeEnvironment.geolocatedTrees)
            }
        }
        .overlay {
            if !treeEnvironment.internetConnexionIsOk {
                ConnectionStatusView()
                    .transition(.move(edge: .bottom))
            }
        }
    }
}

struct TreeListComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TreeListComponentView()
            .environmentObject(TreeEnvironment())
    }
}

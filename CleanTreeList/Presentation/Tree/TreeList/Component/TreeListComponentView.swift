//
//  TreeListComponentView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 09/05/2022.
//

import SwiftUI
import Resolver

struct TreeListComponentView: View {
    @InjectedObject var treeGetterListViewModel: TreeGetterListViewModel
    
    @InjectedObject var treeListViewModel: TreeListViewModel
    
    @State private var searchText: String = ""
    
    var body: some View {
        
        // If SearchProcess --> display filter list from TreeListViewModel
        // Else --> Display all tree from TreeGetterListViewModel
        
        List(treeListViewModel.isSearchingProcess ? treeListViewModel.geolocatedTrees : treeGetterListViewModel.geolocatedTrees) { geolocatedTree in
            TreeItemView(geolocatedTree: geolocatedTree)
                .task {
                    if(treeGetterListViewModel.internetConnexionIsOk) {
                        await treeGetterListViewModel.getMoreTreesIfNeeded(currentTree: geolocatedTree)
                    }
                }
        } //: LIST
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "searchPlaceholder")
        
        .onChange(of: searchText) { _ in
            if(searchText.isEmpty) {
                treeListViewModel.cancelSearchProcess()
            }else{
                // #### MoyaExemple ####
//                let TestData = treeListViewModel.getTreeListWithMoya(startIndew: 0)
                treeListViewModel.filterTreeResult(searchText: searchText, allGeolocatedTrees: treeGetterListViewModel.geolocatedTrees)
            }
        }
        .overlay {
            if !treeGetterListViewModel.internetConnexionIsOk {
                ConnectionStatusView()
                    .transition(.move(edge: .bottom))
            }
        }
    }
}

struct TreeListComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TreeListComponentView()
    }
}

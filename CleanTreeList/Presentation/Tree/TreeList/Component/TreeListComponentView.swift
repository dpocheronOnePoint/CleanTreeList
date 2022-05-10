//
//  TreeListComponentView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 09/05/2022.
//

import SwiftUI

struct TreeListComponentView: View {
    @StateObject var treeListViewModel: TreeListViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(treeListViewModel.geolocatedTrees) { geolocatedTree in
                    TreeItemView(geolocatedTree: geolocatedTree)
                        .task {
                           await treeListViewModel.getMoreTreesIfNeeded(currentTree: geolocatedTree)
                        }
                } //: LOOP
            } //: LAZYVSTACK
        } //: SCROLL
        .navigationTitle("Tree List")
        .task {
            await treeListViewModel.getTrees()
        }
    }
}

struct TreeListComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TreeListComponentView(treeListViewModel: TreeListViewModel())
    }
}

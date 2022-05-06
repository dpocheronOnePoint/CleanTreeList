//
//  TreeListView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import SwiftUI

struct TreeListView: View {
    @StateObject var treeListViewModel = TreeListViewModel()
    
    fileprivate func listRow(_ geolocatedTree: GeolocatedTree) -> some View {
        HStack {
            Text(geolocatedTree.tree.name ?? "")
        } //: HSTACK
    }
    
    fileprivate func TodoList() -> some View {
        List {
            ForEach(treeListViewModel.geolocatedTrees) { geolocatedTree in
                listRow(geolocatedTree)
            } //: LOOP
        }
        .navigationTitle("Tree List")
        .task {
            await treeListViewModel.getTrees()
        }
        .alert("Error", isPresented: $treeListViewModel.hasError) {
            
        } message: {
            Text(treeListViewModel.errorMessage)
        }
    }
    
    var body: some View {
        TodoList()
    }
}

struct TreeListView_Previews: PreviewProvider {
    static var previews: some View {
        TreeListView()
    }
}

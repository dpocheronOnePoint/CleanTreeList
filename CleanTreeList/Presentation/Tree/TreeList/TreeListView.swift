//
//  TreeListView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import SwiftUI
import Resolver

struct TreeListView: View {
    
    @ObservedObject var treeGetterListViewModel: TreeGetterListViewModel = Resolver.resolve()
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView{
            switch treeGetterListViewModel.networkStatus {
                
            case .requstInProgress:
                ProgressView()
                
            case .networkFail:
                ErrorView()
                
            case .dataLoadedFromLocalDataBase, .dataLoadedFromWS:
                TreeListComponentView()
                    .navigationTitle("treeListTitle")
                
            }
        } //: NAVIGATION
        
    }
}

struct TreeListView_Previews: PreviewProvider {
    static var previews: some View {
        TreeListView()
    }
}

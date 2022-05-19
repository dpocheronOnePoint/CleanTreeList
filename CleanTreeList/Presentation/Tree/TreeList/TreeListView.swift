//
//  TreeListView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import SwiftUI

struct TreeListView: View {

    @EnvironmentObject var treeEnvironment: TreeEnvironment
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView{
            if(treeEnvironment.networkStatus == .requstInProgress){
                ProgressView()
            }else if (treeEnvironment.networkStatus == .networkFail){
                ErrorView()
                    .environmentObject(treeEnvironment)
            }else{
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

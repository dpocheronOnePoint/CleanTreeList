//
//  TreeListView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import SwiftUI

struct TreeListView: View {
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView{
            TreeListComponentView()
                .navigationTitle("treeListTitle")
        } //: NAVIGATION
        
    }
}

struct TreeListView_Previews: PreviewProvider {
    static var previews: some View {
        TreeListView()
    }
}

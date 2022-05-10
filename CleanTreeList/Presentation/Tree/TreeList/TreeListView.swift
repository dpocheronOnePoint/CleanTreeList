//
//  TreeListView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import SwiftUI

struct TreeListView: View {
    @StateObject var treeListViewModel = TreeListViewModel()
    
    var body: some View {
        TreeListComponentView(treeListViewModel: treeListViewModel)
    }
}

struct TreeListView_Previews: PreviewProvider {
    static var previews: some View {
        TreeListView()
    }
}

//
//  TreeListComponentView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 09/05/2022.
//

import SwiftUI

struct TreeListComponentView: View {
    @EnvironmentObject var treeEnvironment: TreeEnvironment
    
    var body: some View {
        NavigationView{
                List {
                    ForEach(treeEnvironment.geolocatedTrees) { geolocatedTree in
                        TreeItemView(geolocatedTree: geolocatedTree)
                            .task {
                                await treeEnvironment.getMoreTreesIfNeeded(currentTree: geolocatedTree)
                            }
                    } //: LOOP
                } //: LIST
            .navigationTitle("Tree List")
        } //: NAVIGATION
    }
}

struct TreeListComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TreeListComponentView()
    }
}

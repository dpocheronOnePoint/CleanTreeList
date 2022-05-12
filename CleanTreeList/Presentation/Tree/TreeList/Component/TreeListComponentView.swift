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
            VStack (alignment: .center, spacing: 10) {
                List(treeEnvironment.geolocatedTrees) { geolocatedTree in
                    TreeItemView(geolocatedTree: geolocatedTree)
                        .task {
                            if(treeEnvironment.internetConnexionIsOk) {
                                await treeEnvironment.getMoreTreesIfNeeded(currentTree: geolocatedTree)
                            }
                        }
                } //: LIST
            } // VSTACK
            .navigationTitle("Tree List")
        } //: NAVIGATION
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

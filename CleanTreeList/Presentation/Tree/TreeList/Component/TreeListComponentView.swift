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
                List {
                    ForEach(treeEnvironment.networkStatusIsOK ? treeEnvironment.geolocatedTrees : treeEnvironment.geolocatedTreesFromCD) { geolocatedTree in
                        TreeItemView(geolocatedTree: geolocatedTree)
                            .task {
                                if(treeEnvironment.networkStatusIsOK){
                                    await treeEnvironment.getMoreTreesIfNeeded(currentTree: geolocatedTree)
                                }
                            }
                    } //: LOOP
                } //: LIST
            } // VSTACK
            .navigationTitle("Tree List")
        } //: NAVIGATION
        .overlay {
            if !treeEnvironment.networkStatusIsOK {
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

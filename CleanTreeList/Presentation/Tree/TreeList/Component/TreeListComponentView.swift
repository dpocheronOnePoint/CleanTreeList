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
                    ForEach(treeEnvironment.geolocatedTrees) { geolocatedTree in
                        TreeItemView(geolocatedTree: geolocatedTree)
                    } //: LOOP
                } //: LIST
            } // VSTACK
            .navigationTitle("Tree List")
        } //: NAVIGATION
        .overlay {
            if treeEnvironment.networkStatus == .dataLoadedFromCD {
                ConnectionStatusView(text: "From DB")
                    .transition(.move(edge: .bottom))
            }else{
                ConnectionStatusView(text: "From WS")
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

//
//  TreeItemView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 09/05/2022.
//

import SwiftUI

struct TreeItemView: View {
    let geolocatedTree: GeolocatedTree
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(geolocatedTree.tree.name ?? "")
                    .font(.title2)
                    .fontWeight(.bold)
                Text(geolocatedTree.tree.address)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                if (geolocatedTree.tree.address2 != nil && geolocatedTree.tree.address2!.count > 0) {
                    Text(geolocatedTree.tree.address2!)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            } // VSTACK
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .imageScale(.medium)
                            .foregroundColor(.secondary)
                        Text( "\(geolocatedTree.tree.height)m de hauteur")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    } //: HSTACK
                
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .imageScale(.medium)
                            .foregroundColor(.secondary)
                        Text("\(geolocatedTree.tree.circumference)cm de circonférence")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    } //: HSTACK
            } //: VSTACK
        } //: HSTACK
        .padding()
    }
}

struct TreeItemView_Previews: PreviewProvider {
    static var previews: some View {
        TreeItemView(geolocatedTree: GeolocatedTree.geolocatedTreeSampleData)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

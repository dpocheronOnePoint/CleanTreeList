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
                    .lineLimit(2)
            } // VSTACK
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "info.circle.fill")
                        .imageScale(.medium)
                        .foregroundColor(.secondary)
                    
                    Text(
                        formattedMultipleStringWithInt(
                            localizeString: "tree heigh",
                            integer: geolocatedTree.tree.height
                        )
                    )
                    .font(.caption)
                    .foregroundColor(.secondary)
                } //: HSTACK
                
                HStack {
                    Image(systemName: "info.circle.fill")
                        .imageScale(.medium)
                        .foregroundColor(.secondary)
                    Text(
                        formattedMultipleStringWithInt(
                            localizeString: "tree circumference",
                            integer: geolocatedTree.tree.circumference
                        )
                    )
                        .font(.caption)
                        .foregroundColor(.secondary)
                } //: HSTACK
            } //: VSTACK
            .frame(width: 180)
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

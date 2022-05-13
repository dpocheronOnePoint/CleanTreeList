//
//  MapTreeDetailsView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import SwiftUI

struct MapTreeDetailsView: View {
    // MARK: - Porperties
    let geolocatedTree: GeolocatedTree
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text(geolocatedTree.tree.name ?? "")
                .font(.title2)
                .fontWeight(.bold)
            
            Text(geolocatedTree.tree.address)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
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
            
            Spacer()
        } // VSTACK
        .frame(width: 300, height: 300, alignment: .center)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 3)
    }
}

// MARK: - Preview
struct MapTreeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MapTreeDetailsView(geolocatedTree: GeolocatedTree.geolocatedTreeSampleData)
            .background(BlankBlurView(backgroundColor: .gray, backgroundOpacity: 0.5))
    }
}

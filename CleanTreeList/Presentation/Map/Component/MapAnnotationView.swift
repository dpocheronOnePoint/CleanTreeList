//
//  MapAnnotationView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import SwiftUI

struct MapAnnotationView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.black.opacity(0.5))
                .frame(width: 40, height: 40, alignment: .center)
            
            Circle()
//                .fill(Color.secondary)
                .stroke(Color.green, lineWidth: 2)
                .frame(width: 40, height: 40, alignment: .center)
            
            Image(systemName: "leaf.fill")
                .foregroundColor(.green)
        }
    }
}

struct MapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        MapAnnotationView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

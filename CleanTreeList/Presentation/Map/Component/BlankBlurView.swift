//
//  BlankBlurView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import SwiftUI

struct BlankBlurView: View {
    // MARK: - PROPERTIES
    var backgroundColor: Color
    var backgroundOpacity: Double
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
        } // VSTACK
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(backgroundColor)
        .opacity(backgroundOpacity)
        .blendMode(.overlay)
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - PREVIEW
struct BlankBlurView_Previews: PreviewProvider {
    static var previews: some View {
        BlankBlurView(backgroundColor: Color.black, backgroundOpacity: 0.3)
            .background(
                MapView()
                    .environmentObject(TreeEnvironment())
            )
    }
}

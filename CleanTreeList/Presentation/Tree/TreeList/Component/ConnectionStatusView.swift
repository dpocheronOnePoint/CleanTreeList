//
//  ConnectionStatusView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 11/05/2022.
//

import SwiftUI

struct ConnectionStatusView: View {
    @EnvironmentObject var treeEnvironment: TreeEnvironment
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack(spacing: 16) {
                Image(systemName: "wifi.slash")
                    .foregroundColor(.red)
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                
                Text("Vous n'êtes pas connecté")
                    .font(.title3)
                    .foregroundColor(.secondary)
            } //: VSTACK
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(
                Color.white
            )
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 5)
            .frame(maxWidth: 640)
        } // VSTACK
        .padding()
    }
}

struct ConnectionStatusView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionStatusView()
            .environmentObject(TreeEnvironment())
            .previewLayout(.sizeThatFits)
    }
}
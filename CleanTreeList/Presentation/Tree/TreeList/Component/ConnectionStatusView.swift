//
//  ConnectionStatusView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 11/05/2022.
//

import SwiftUI
import Resolver

struct ConnectionStatusView: View {
    @ObservedObject var treeEnvironment: TreeEnvironment = Resolver.resolve()
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack(spacing: 16) {
                Image(systemName: "wifi.slash")
                    .foregroundColor(.red)
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
                
                Text("noConnexionMessage")
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
            .previewLayout(.sizeThatFits)
    }
}

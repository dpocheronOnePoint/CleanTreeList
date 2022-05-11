//
//  ErrorView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 10/05/2022.
//

import SwiftUI

struct ErrorView: View {
    @EnvironmentObject var treeEnvironment: TreeEnvironment
    
    var body: some View {
        VStack(spacing: 20){
            
            Spacer()
            
            //MARK: - CENTER
            
            Text("Une erreur est survenue.\nMerci de réessayer ")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            //MARK: - FOOTER
            
            Spacer()
            
            Button(action:{
                Task {
                    await treeEnvironment.getTrees()
                }
            }) {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Rééssayer")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        } //: VStack
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}

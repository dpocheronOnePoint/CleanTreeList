//
//  ErrorView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 10/05/2022.
//

import SwiftUI
import Resolver

struct ErrorView: View {
    @ObservedObject var treeEnvironment: TreeEnvironment = Resolver.resolve()

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
            
            AppButton(wsCallInProgress: .constant(false), systemImage: "arrow.triangle.2.circlepath.circle.fill", buttonTitle: "Réessayer") {
                Task {
                    await treeEnvironment.getTrees()
                }
            }
            
        } //: VStack
        .padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}

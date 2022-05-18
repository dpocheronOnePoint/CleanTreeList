//
//  AppButton.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 17/05/2022.
//

import SwiftUI

struct AppButton: View {
    let systemImage: String
    let buttonTitle: String
    var clicked: (() -> Void)
    
    var body: some View {
        
        Button(action: {
            clicked()
        }, label: {
            Image(systemName: systemImage)
                .imageScale(.large)
            Text(buttonTitle)
                .font(.system(.title3, design: .rounded))
                .fontWeight(.bold)
        })
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
    }
}

struct AppButton_Previews: PreviewProvider {
    static var previews: some View {
        AppButton(systemImage: "arrow.triangle.2.circlepath.circle.fill", buttonTitle: "Réessayer") {
            print("Test")
        }
    }
}

//
//  AppButton.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 17/05/2022.
//

import SwiftUI

struct AppButton: View {
    @Binding var wsCallInProgress: Bool
    let systemImage: String
    let buttonTitle: String
    var clicked: (() -> Void)
    
    var body: some View {
        
        Button(action: {
            clicked()
        }, label: {
            HStack {
                if(wsCallInProgress) {
                    ProgressView()
                        .imageScale(.large)
                        .padding(.horizontal)
                        
                }else{
                    Image(systemName: systemImage)
                        .imageScale(.large)
                    Text(buttonTitle)
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                }
            } //: HSTACK
            .frame(minWidth: 160, minHeight: 30)
        })
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
    }
}

struct AppButton_Previews: PreviewProvider {
    static var previews: some View {
        AppButton(wsCallInProgress: .constant(false), systemImage: "arrow.triangle.2.circlepath.circle.fill", buttonTitle: "Réessayer") {
            print("Test")
        }
    }
}

//
//  LoginView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 20/05/2022.
//

import SwiftUI

struct LoginView: View {
    @AppStorage("userConnected") var userIsConnected: Bool = false
    
    var body: some View {
        AppButton(wsCallInProgress: .constant(false), systemImage: "figure.walk.circle.fill", buttonTitle: "Se connecter") {
            userIsConnected = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

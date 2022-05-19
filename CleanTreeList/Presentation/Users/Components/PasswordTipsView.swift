//
//  PasswordTipsView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 19/05/2022.
//

import SwiftUI

struct PasswordTipsView: View {
    @Binding var lenghtCheck: Bool
    
    var body: some View {
        VStack {
            CheckBox(isActivated: $lenghtCheck, checkoboxTitle: "Votre mot de passe doit contenir 10 caractères")
            CheckBox(isActivated: $lenghtCheck, checkoboxTitle: "Votre mot de passe doit contenir 10 caractères")
        } // VSTACK
    }
}

struct PasswordTipsView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTipsView(lenghtCheck: .constant(true))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

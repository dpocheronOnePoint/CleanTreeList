//
//  PasswordTipsView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 19/05/2022.
//

import SwiftUI

struct PasswordTipsView: View {
    @Binding var checkPassword: CheckPassword
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            CheckBox(isActivated: $checkPassword.lengthIsGood, checkoboxTitle: "password_check_lenght")
            
            CheckBox(isActivated: $checkPassword.hasUppercaseCaracter, checkoboxTitle: "password_check_has_uppercase")
            
            CheckBox(isActivated: $checkPassword.hasDigitCaracter, checkoboxTitle: "password_check_has_digit")
            
            CheckBox(isActivated: $checkPassword.hasSpecialCaracter, checkoboxTitle: "password_check_has_special")
        } // VSTACK
    }
}

struct PasswordTipsView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTipsView(checkPassword: .constant(CheckPassword.falseCheckPassword))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

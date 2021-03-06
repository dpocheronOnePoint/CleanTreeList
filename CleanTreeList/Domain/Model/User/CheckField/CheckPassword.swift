//
//  CheckPassword.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 19/05/2022.
//

import Foundation

struct CheckPassword {
    var lengthIsValid: Bool
    var hasUppercaseCaracter: Bool
    var hasDigitCaracter: Bool
    var hasSpecialCaracter: Bool
    
    var passwordIsValid: Bool {
        if(lengthIsValid && hasUppercaseCaracter && hasDigitCaracter && hasSpecialCaracter) {
            return true
        }else{
            return false
        }
    }
}

extension CheckPassword {
    static let falseCheckPassword = CheckPassword(lengthIsValid: false, hasUppercaseCaracter: false, hasDigitCaracter: false, hasSpecialCaracter: false)
}

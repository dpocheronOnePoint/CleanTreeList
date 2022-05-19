//
//  CheckPostFields.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 19/05/2022.
//

import Foundation

struct CheckPostFields {
    var emailFieldIsValid: Bool
    var nameFieldIsValid: Bool
//    var passwordIsValid: Bool
    
    var postFieldsAreValids: Bool {
        if(emailFieldIsValid && nameFieldIsValid /*&& passwordIsValid*/) {
            return true
        }else{
            return false
        }
    }
}

extension CheckPostFields {
    static let falseCheckPostFields = CheckPostFields(emailFieldIsValid: false, nameFieldIsValid: false)
}

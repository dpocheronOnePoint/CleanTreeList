//
//  CheckPassword.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 19/05/2022.
//

import Foundation

struct CheckPassword {
    var lengthIsGood: Bool
}

extension CheckPassword {
    static let falseCheckPassword = CheckPassword(lengthIsGood: false)
}

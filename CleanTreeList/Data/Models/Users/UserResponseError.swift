//
//  UserResponseError.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 18/05/2022.
//

import Foundation

struct UserResponseError: Decodable {
    let field: String
    let message: String
}

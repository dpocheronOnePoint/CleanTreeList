//
//  User.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 17/05/2022.
//

import Foundation

struct UserPost: Encodable {
    let email: String
    let name: String
    let gender: String
    let status: String
}

struct User: Decodable {
    let id: Int
    let email: String
    let name: String
    let gender: String
    let status: String
}

extension RemoteUser: DataToDomain {
    func ToDomain() -> User {
        User(id: id,
             email: email,
             name: name,
             gender: gender,
             status: status
        )
    }
}

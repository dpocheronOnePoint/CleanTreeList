//
//  UserPost.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 17/05/2022.
//

import Foundation

struct RemoteUserPost: Encodable {
    let email: String
    let name: String
    let gender: String
    let status: String
}

struct RemoteUser: Decodable {
    let id: Int
    let email: String
    let name: String
    let gender: String
    let status: String
}

extension UserPost: DomainToData {
    func ToData() -> RemoteUserPost {
        RemoteUserPost(
            email: email,
            name: name,
            gender: gender,
            status: status
        )
    }
}

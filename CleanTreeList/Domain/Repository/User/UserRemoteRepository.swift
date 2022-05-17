//
//  UserRemoteRepository.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 17/05/2022.
//

import Foundation

protocol UserRemoteRepository {
    func postuser(user: UserPost) async throws -> User
}

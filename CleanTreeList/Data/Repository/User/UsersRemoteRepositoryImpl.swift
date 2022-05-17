//
//  UsersRemoteRepositoryImpl.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 17/05/2022.
//

import Foundation

struct UsersRemoteRepositoryImpl: UserRemoteRepository {
    var usersRemoteDataSource: UsersRemoteDataSource

    func postuser(user: UserPost) async throws -> User {
        let user = try await usersRemoteDataSource.postUser(user: user.ToData())
        return user.ToDomain()
    }
}

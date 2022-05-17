//
//  UsersRemoteDataSource.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import Foundation

protocol UsersRemoteDataSource {
    func postUser(user: RemoteUserPost) async throws -> RemoteUser
}

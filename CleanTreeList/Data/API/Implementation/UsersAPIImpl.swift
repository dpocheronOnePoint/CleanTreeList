//
//  UsersAPIImpl.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import Foundation

// https://gorest.co.in

struct UsersAPIImpl: UsersRemoteDataSource {
    func postUser(user: RemoteUserPost) async throws -> RemoteUser {
        guard let url = URL(string: "\(GorestAPI.baseUrl)") else {
            throw APIServiceError.badUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try JSONEncoder().encode(user)
        
        guard let (data, response) = try? await URLSession.shared.data(for: urlRequest) else {
            throw APIServiceError.requestError
        }
        
        // Check if response.statusCode is 201
        guard let response = response as? HTTPURLResponse, response.statusCode == 201 else {
            throw APIServiceError.statusNotOK
        }
        
        // Decode response to user and return it
        guard let addedUser = try? JSONDecoder().decode(RemoteUser.self, from: data) else {
            throw APIServiceError.decodingError
        }
        
        return addedUser
    }
}

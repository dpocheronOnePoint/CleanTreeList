//
//  UsersAPIImpl.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import Foundation

// https://gorest.co.in

struct UsersRemoteImpl: UsersRemoteDataSource {
    func postUser(user: RemoteUserPost) async throws -> RemoteUser {
        guard let url = URL(string: "\(GorestAPI.baseUrl)") else {
            throw APIServiceError.badUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue(GorestAPI.bearerAuthorization, forHTTPHeaderField: "Authorization")
        urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpBody = try JSONEncoder().encode(user)
        
        guard let (data, response) = try? await URLSession.shared.data(for: urlRequest) else {
            throw APIServiceError.requestError
        }
        
        guard let response = response as? HTTPURLResponse else {
            throw APIServiceError.statusError
        }
        
        // Check if response.statusCode is 201 else throw error
        guard response.statusCode == 201 else {
            
            switch response.statusCode {
                // MARK: - Error 422: Unprocessable Entity
            case 422:
                guard let responseError = try? JSONDecoder().decode([UserResponseError].self, from: data),
                      !responseError.isEmpty else {
                    throw APIServiceError.statusError
                }
                throw APIServiceError.error422(responseError[0])
                
                // MARK: - Other Error Status
            default:
                throw APIServiceError.statusError
            }
            
        }
        
        // Decode response to user and return it
        guard let addedUser = try? JSONDecoder().decode(RemoteUser.self, from: data) else {
            throw APIServiceError.decodingError
        }
        
        return addedUser
    }
}

//
//  UserApiUseCase.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 17/05/2022.
//

import Foundation

protocol UserApiUseCaseProtocol {
    func postUser(user: UserPost) async -> Result<User, UseCaseApiError>
}

struct UserApiUseCase: UserApiUseCaseProtocol {
    var userRemoteRepository: UserRemoteRepository
    
    func postUser(user: UserPost) async -> Result<User, UseCaseApiError> {
        do {
            let user = try await userRemoteRepository.postuser(user: user)
            
            return .success(user)
        } catch (let error) {
            switch error {
            case APIServiceError.decodingError:
                return .failure(.decodingError)
                
            case APIServiceError.error422(let userResponseError):
                let concatErrorString = "\(userResponseError.field) \(userResponseError.message)"
                
                // Replace spaces by "_" to match with localizeString
                let underscroredErrorString = concatErrorString.replacingOccurrences(of: " ", with: "_")
                return .failure(.error422(underscroredErrorString))
                
            default:
                return .failure(.networkError)
            }
        }
    }
}

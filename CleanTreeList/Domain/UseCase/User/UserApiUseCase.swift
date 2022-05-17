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
                
            default:
                return .failure(.networkError)
            }
        }
    }
}

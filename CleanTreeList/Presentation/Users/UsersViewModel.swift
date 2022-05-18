//
//  UsersViewModel.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import Foundation
import SwiftUI

class UsersViewModel: ObservableObject {
    
    var userApiUseCase = UserApiUseCase(userRemoteRepository: UsersRemoteRepositoryImpl(usersRemoteDataSource: UsersAPIImpl()))
    
    @Published var userPost: UserPost = UserPost.starterUserPost
    @Published var femaleIsSelected: Bool = true {
        didSet {
            if femaleIsSelected {
                userPost.gender = "female"
            }else{
                userPost.gender = "male"
            }
        }
    }
    @Published var userIsActive: Bool = false {
        didSet {
            if userIsActive {
                userPost.status = "active"
            }else{
                userPost.status = "inactive"
            }
        }
    }
    @Published var hasError: Bool = false
    @Published var postErrorString: LocalizedStringKey = ""
    
    func postUser() async {
        let result = await userApiUseCase.postUser(user: userPost)
        
        switch result {
        case .success(let user):
            print(user)
        case .failure(let error):
            switch error {
            case .error422(let errorString):
                postErrorString = LocalizedStringKey(errorString)
                hasError = true
            default:
                postErrorString = "Erreur"
            }
        }
    }
}

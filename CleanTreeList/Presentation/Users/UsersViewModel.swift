//
//  UsersViewModel.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import Foundation
import SwiftUI

enum PostRequestStatus {
    case NotCalled, InProgress, Failure, Success
}

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
    @Published var postRequestStatus: PostRequestStatus = .NotCalled {
        didSet {
            if postRequestStatus == .InProgress {
                wsInProgress = true
            }else{
                wsInProgress = false
            }
        }
    }
    @Published var wsInProgress: Bool = false
    
    @Published var postErrorString: LocalizedStringKey = ""
    
    func checkEmail() {
        let emailTest = NSPredicate(format: Regex.selfMatchRule, Regex.emailRegex)
        if(emailTest.evaluate(with: userPost.email) && !userPost.email.isEmpty) {
            
        }else{
            print("Email incorrect")
        }
    }
    
    func postUser() async {
        postRequestStatus = .InProgress
        let result = await userApiUseCase.postUser(user: userPost)
        
        switch result {
        case .success(_):
            postRequestStatus = .Success
        case .failure(let error):
            switch error {
            case .error422(let errorString):
                postErrorString = LocalizedStringKey(errorString)
                postRequestStatus = .Failure
            default:
                postErrorString = "Erreur"
            }
        }
    }
}

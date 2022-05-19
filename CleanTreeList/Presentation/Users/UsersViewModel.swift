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
    
    // Error variables
    @Published var emailLocalizeError: LocalizeError = LocalizeError.undisplayError
    @Published var nameLocalizeError: LocalizeError = LocalizeError.undisplayError
    @Published var postErrorString: LocalizedStringKey = ""
    
    // Passwordtext just to test
    @Published var passwordText: String = ""
    @Published var checkPassword: CheckPassword = CheckPassword.falseCheckPassword
    
    // MARK: - Checks
    func checkEmail() {
        let emailTest = NSPredicate(format: Regex.selfMatchRule, Regex.emailRegex)
        if(emailTest.evaluate(with: userPost.email) && !userPost.email.isEmpty) {
            
            withAnimation(.easeInOut(duration: 0.5)) {
                emailLocalizeError = .undisplayError
            }
        }else{
            withAnimation(.easeInOut(duration: 0.5)) {
                emailLocalizeError = displayLocalizeError(error: "Votre email est incorrect")
            }
        }
    }
    
    func checkPasswordField() {
        checkPassword.lengthIsGood = passwordText.count >= 10
    }
    
    // MARK: - Actions
    func postUser() async {
        withAnimation(.easeInOut(duration: 0.2)) {
            postRequestStatus = .InProgress
        }
        let result = await userApiUseCase.postUser(user: userPost)
        
        switch result {
        case .success(_):
            postRequestStatus = .Success
        case .failure(let error):
            switch error {
            case .error422(let errorString):
                DispatchQueue.main.async {
                    self.postErrorString = LocalizedStringKey(errorString)
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.postRequestStatus = .Failure
                    }
                }
            default:
                postErrorString = "Une erreur est survenue"
            }
        }
    }
    
    // MARK: - Utils
    func displayLocalizeError(error: LocalizedStringKey) -> LocalizeError {
        return LocalizeError(needDisplayError: true, errorString: error)
    }
}

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
    
    private var userApiUseCase = UserApiUseCase(userRemoteRepository: UsersRemoteRepositoryImpl(usersRemoteDataSource: UsersAPIImpl()))
    
    @Published var userPost: UserPost = UserPost.starterUserPost
    @Published var checkPostFields: CheckPostFields = CheckPostFields.falseCheckPostFields
    
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
    @Published var passwordLocalizeError: LocalizeError = LocalizeError.undisplayError
    @Published var postErrorString: LocalizedStringKey = ""
    
    // Passwordtext just to test
    @Published var passwordText: String = ""
    @Published var checkPassword: CheckPassword = CheckPassword.falseCheckPassword
    
    // MARK: - Checks
    func checkEmailUnfocus() {
        let emailTest = NSPredicate(format: Regex.selfMatchRule, Regex.emailRegex)
        if(emailTest.evaluate(with: userPost.email)) {
            
            withAnimation(.easeInOut(duration: 0.5)) {
                emailLocalizeError = .undisplayError
            }
        }else{
            withAnimation(.easeInOut(duration: 0.5)) {
                emailLocalizeError = displayLocalizeError(error: "Votre email est incorrect")
            }
        }
    }
    
    func checkEmailWriteInProcess() {
        let emailTest = NSPredicate(format: Regex.selfMatchRule, Regex.emailRegex)
        if(emailTest.evaluate(with: userPost.email)) {
            
            withAnimation(.easeInOut(duration: 0.5)) {
                emailLocalizeError = .undisplayError
            }
            
            checkPostFields.emailFieldIsValid = true
        }else{
            checkPostFields.emailFieldIsValid = false
        }
    }
    
    func checkNameUnFocus() {
        if(userPost.name.count >= 3) {
            nameLocalizeError = displayLocalizeError(error: "Votre nom doit contenir au moins 3 caractères")
        }else{
            nameLocalizeError = LocalizeError.undisplayError
        }
    }
    
    func checkNameWriteProgess() {
        if(userPost.name.count < 3) {
            checkPostFields.nameFieldIsValid = false
        }else{
            nameLocalizeError = LocalizeError.undisplayError
            checkPostFields.nameFieldIsValid = true
        }
    }
    
    func checkPasswordUnfocus() {
        if(checkPassword.passwordIsValid){
            passwordLocalizeError = LocalizeError.undisplayError
        }else{
            passwordLocalizeError = displayLocalizeError(error: "Votre mot de passe est incorrect")
        }
    }
    
    func checkPasswordInWriteProcess() {
        // Check password length
        checkPassword.lengthIsValid = passwordText.count >= 10
        
        // Check password contains capital character
        let uppercaseTest = NSPredicate(format: Regex.selfMatchRule, Regex.uppercaseRegex)
        checkPassword.hasUppercaseCaracter = uppercaseTest.evaluate(with: passwordText)
        
        // Check password contain digit character
        let digitTest = NSPredicate(format: Regex.selfMatchRule, Regex.digitRegex)
        checkPassword.hasDigitCaracter = digitTest.evaluate(with: passwordText)
        
        // Check password contain special character
        let specialTest = NSPredicate(format: Regex.selfMatchRule, Regex.specialRegex)
        checkPassword.hasSpecialCaracter = specialTest.evaluate(with: passwordText)
        
        if(checkPassword.passwordIsValid) {
            passwordLocalizeError = LocalizeError.undisplayError
        }
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
                displayApiError(error: errorString)
            default:
                displayApiError(error: "Une erreur est survenue")
            }
        }
    }
    
    // MARK: - Utils
    private func displayLocalizeError(error: LocalizedStringKey) -> LocalizeError {
        return LocalizeError(needDisplayError: true, errorString: error)
    }
    
    private func displayApiError(error: String) {
        DispatchQueue.main.async {
            self.postErrorString = LocalizedStringKey(error)
            withAnimation(.easeInOut(duration: 0.5)) {
                self.postRequestStatus = .Failure
            }
        }
    }
    
}

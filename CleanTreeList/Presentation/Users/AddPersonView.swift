//
//  AddPersonView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import SwiftUI
import Resolver

// Interesting link to get focusField
// https://stackoverflow.com/questions/56491386/how-to-hide-keyboard-when-using-swiftui

struct AddPersonView: View {
    
    // MARK: - Properties
    //    @Environment(\.dismiss) var dismissView
    @InjectedObject private var usersViewModel: UsersViewModel
    
    // MARK: - Body
    var body: some View {
        NavigationView{
            ScrollView {
                VStack (spacing: 30) {
                    
                    Spacer()
                    
                    // Email Field
                    FormTextField(
                        placeholder: "Email",
                        localizeError: usersViewModel.emailLocalizeError,
                        text: $usersViewModel.userPost.email,
                        unEditingChangedAction: usersViewModel.checkEmailUnfocus
                    )
                    .isHidden(usersViewModel.passwordWriteInProgress)
                    .onChange(of: usersViewModel.userPost.email) {emailText in
                        usersViewModel.checkEmailWriteInProcess()
                    }
                    
                    // Name Field
                    FormTextField(
                        placeholder: "Nom",
                        localizeError: LocalizeError.undisplayError,
                        text: $usersViewModel.userPost.name,
                        unEditingChangedAction: usersViewModel.checkNameUnFocus
                    )
                    .isHidden(usersViewModel.passwordWriteInProgress)
                    .onChange(of: usersViewModel.userPost.name) { name in
                        usersViewModel.checkNameWriteProgess()
                    }
                    
                    VStack {
                        
                        FormTextField(
                            placeholder: "Mot de passe",
                            localizeError: usersViewModel.passwordLocalizeError,
                            text: $usersViewModel.passwordText,
                            editingChangedAction: usersViewModel.setPasswordWriteInProgress,
                            unEditingChangedAction: usersViewModel.setPasswordWriteInProgress
                        )
                        .onChange(of: usersViewModel.passwordText) {passwordText in
                            usersViewModel.checkPasswordInWriteProcess()
                        }
                    } //: VSTACK
                    
                    HStack(spacing: 30) {
                        SexeSelector(
                            sexeSelection: $usersViewModel.femaleIsSelected,
                            sexeTitle: "Femme"
                        )
                        
                        SexeSelector(
                            sexeSelection: $usersViewModel.femaleIsSelected.not,
                            sexeTitle: "Homme"
                        )
                    } //: HSTACK
                    .isHidden(usersViewModel.passwordWriteInProgress)
                    
                    CheckBox(isActivated: $usersViewModel.userIsActive, checkoboxTitle: "Utilisateur actif")
                        .isHidden(usersViewModel.passwordWriteInProgress)
                    
                    if usersViewModel.postRequestStatus == .Failure {
                        Text(usersViewModel.postErrorString)
                            .font(.footnote)
                            .foregroundColor(.red)
                            .padding()
                            .isHidden(usersViewModel.passwordWriteInProgress)
                    }
                    
                    AppButton(wsCallInProgress: $usersViewModel.wsInProgress, systemImage: "person.crop.circle.fill.badge.plus", buttonTitle: "Ajouter") {
                        Task {
                            await usersViewModel.postUser()
                        }
                    }
                    .animation(.none, value: usersViewModel.wsInProgress)
                    .isHidden(usersViewModel.passwordWriteInProgress)
                    .disabled(!usersViewModel.checkPostFields.postFieldsAreValids)
                    .opacity(usersViewModel.checkPostFields.postFieldsAreValids ? 1.0 : 0.5)
                    
                    PasswordTipsView(checkPassword: $usersViewModel.checkPassword)
                        .isHidden(!usersViewModel.passwordWriteInProgress)
                    
                    Spacer()
                    
                } // VSTACK
            } // SCROLL
            .navigationTitle("Ajouter un utilisateur")
            .navigationBarTitleDisplayMode(.inline)
            .onTapGesture {
                self.hideKeyboard()
            }
        }//: NAVIGATION
    }
}

// MARK: - Preview
struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView()
    }
}

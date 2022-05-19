//
//  AddPersonView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import SwiftUI

// Interesting link to get focusField
// https://stackoverflow.com/questions/56491386/how-to-hide-keyboard-when-using-swiftui

struct AddPersonView: View {
    
    // MARK: - Properties
    
    //    @Environment(\.dismiss) var dismissView
    @StateObject private var usersViewModel = UsersViewModel()
    
    @State private var passwordWriteInProgress = false
    
    // MARK: - Functions
    private func setPasswordWriteInProgress() {
        withAnimation(.easeInOut(duration: 0.2)){
            passwordWriteInProgress.toggle()
            if(!passwordWriteInProgress){
                usersViewModel.checkPasswordUnfocus()
            }
        }
    }
    
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
                    .isHidden(passwordWriteInProgress)
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
                    .isHidden(passwordWriteInProgress)
                    .onChange(of: usersViewModel.userPost.name) { name in
                        usersViewModel.checkNameWriteProgess()
                    }
                    
                    VStack {
                        
                        FormTextField(
                            placeholder: "Mot de passe",
                            localizeError: usersViewModel.passwordLocalizeError,
                            text: $usersViewModel.passwordText,
                            editingChangedAction: setPasswordWriteInProgress,
                            unEditingChangedAction: setPasswordWriteInProgress
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
                    .isHidden(passwordWriteInProgress)
                    
                    CheckBox(isActivated: $usersViewModel.userIsActive, checkoboxTitle: "Utilisateur actif")
                        .isHidden(passwordWriteInProgress)
                    
                    if usersViewModel.postRequestStatus == .Failure {
                        Text(usersViewModel.postErrorString)
                            .font(.footnote)
                            .foregroundColor(.red)
                            .padding()
                            .isHidden(passwordWriteInProgress)
                    }
                    
                    AppButton(wsCallInProgress: $usersViewModel.wsInProgress, systemImage: "person.crop.circle.fill.badge.plus", buttonTitle: "Ajouter") {
                        Task {
                            await usersViewModel.postUser()
                        }
                    }
                    .animation(.none, value: usersViewModel.wsInProgress)
                    .isHidden(passwordWriteInProgress)
                    .disabled(!usersViewModel.checkPostFields.postFieldsAreValids)
                    .opacity(usersViewModel.checkPostFields.postFieldsAreValids ? 1.0 : 0.5)
                    
                    PasswordTipsView(checkPassword: $usersViewModel.checkPassword)
                        .isHidden(!passwordWriteInProgress)
                    
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

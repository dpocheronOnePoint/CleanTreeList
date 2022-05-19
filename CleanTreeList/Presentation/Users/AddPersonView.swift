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
        }
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack (spacing: 30) {
                
                Spacer()
                
                // Email Field
                FormTextField(
                    placeholder: "Email",
                    localizeError: usersViewModel.emailLocalizeError,
                    text: $usersViewModel.userPost.email,
                    unEditingChangedAction: usersViewModel.checkEmail
                )
                .isHidden(passwordWriteInProgress)
                
                // Name Field
                FormTextField(
                    placeholder: "Nom",
                    localizeError: usersViewModel.nameLocalizeError,
                    text: $usersViewModel.userPost.name
                )
                .isHidden(passwordWriteInProgress)
                
                VStack {
                    Text("! Juste pour tester, pas necessaire pour ajouter un user !")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    FormTextField(
                        placeholder: "Mot de passe",
                        localizeError: usersViewModel.nameLocalizeError,
                        text: $usersViewModel.passwordText,
                        editingChangedAction: setPasswordWriteInProgress,
                        unEditingChangedAction: setPasswordWriteInProgress
                    )
                    .onChange(of: usersViewModel.passwordText) {passwordText in
                        usersViewModel.checkPasswordField()
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
                
                PasswordTipsView(lenghtCheck: $usersViewModel.checkPassword.lengthIsGood)
                    .isHidden(!passwordWriteInProgress)
                
                Spacer()
                
            } // VSTACK
        } // SCROLL
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}

// MARK: - Preview
struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView()
    }
}

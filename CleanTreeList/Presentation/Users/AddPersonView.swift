//
//  AddPersonView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import SwiftUI

struct AddPersonView: View {
    //    @Environment(\.dismiss) var dismissView
    @StateObject var usersViewModel = UsersViewModel()
    
    var body: some View {
        VStack (spacing: 30) {
            FormTextField(
                placeholder: "Email",
                text: $usersViewModel.userPost.email,
                unEditingChangedAction: usersViewModel.checkEmail
            )
            
            FormTextField(placeholder: "Nom", text: $usersViewModel.userPost.name)
            
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
            CheckBox(isActivated: $usersViewModel.userIsActive, checkoboxTitle: "Utilisateur actif")
            
            if usersViewModel.postRequestStatus == .Failure {
                Text(usersViewModel.postErrorString)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .padding()
            }
            
            AppButton(wsCallInProgress: $usersViewModel.wsInProgress, systemImage: "person.crop.circle.fill.badge.plus", buttonTitle: "Ajouter") {
                Task {
                    await usersViewModel.postUser()
                }
            }
            
        } // VSTACK
    }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView()
    }
}

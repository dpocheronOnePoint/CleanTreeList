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
            FormTextField(placeholder: "Email", text: $usersViewModel.email)
            
            FormTextField(placeholder: "Nom", text: $usersViewModel.name)
            
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
            
        } // VSTACK
    }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView()
    }
}

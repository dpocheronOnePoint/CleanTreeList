//
//  UsersView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import SwiftUI

struct UsersView: View {
    @State private var presentAddPersonView = false
    
    var body: some View {
        NavigationView {
            Text("Les utilisateurs")
                .navigationTitle("usersListTitle")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                  ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 16) {
                      // LIST
                      Button(action: {
                          self.presentAddPersonView = true
                      }) {
                        Image(systemName: "person.crop.circle.fill.badge.plus")
                          .font(.title2)
                      }
                    } //: HSTACK
                  } //: BUTTONS
                } //: TOOLBAR
                .sheet(isPresented: $presentAddPersonView) {
                    AddPersonView()
                }
        } //: NAVIGATION
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}

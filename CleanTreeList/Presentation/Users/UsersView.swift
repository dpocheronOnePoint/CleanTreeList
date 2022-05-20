//
//  UsersView.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import SwiftUI

struct UsersView: View {
    @AppStorage("userConnected") var userIsConnected: Bool = true
    
    @State private var presentAddPersonView = false
    @State private var presentDisconnectAlert = false
    
    var body: some View {
        NavigationView {
            AppButton(wsCallInProgress: .constant(false), systemImage: "figure.walk.circle.fill", buttonTitle: "Se déconnecter") {
                presentDisconnectAlert = true
            }
            .navigationTitle("usersListTitle")
            .navigationBarTitleDisplayMode(.inline)
            
            // MARK: - Disconnect alert
            .alert(isPresented: $presentDisconnectAlert){
                Alert(
                    title: Text("disconnect_alert_title"),
                    message: Text("disconnect_alert_description"),
                    primaryButton: .destructive(Text("disconnect_alert_button"), action: {
                        userIsConnected = false
                    }),
                    secondaryButton: .default(Text("cancel_button_title"), action: {
                        
                    })
                )
            }
            
            // MARK: - NavigationBar Button
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.presentAddPersonView = true
                    }) {
                        Image(systemName: "person.crop.circle.fill.badge.plus")
                            .font(.title2)
                    }
                } //: BUTTONS
            } //: TOOLBAR
            
            // MARK: - Present AddPersonView
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

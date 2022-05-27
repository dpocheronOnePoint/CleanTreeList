//
//  CleanTreeListApp.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 03/05/2022.
//

import SwiftUI

@main
struct CleanTreeListApp: App {
    @AppStorage("userConnected") var userIsConnected: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//            if(userIsConnected) {
//                MainTabView()
//            } else {
//                LoginView()
//            }
        }
    }
}

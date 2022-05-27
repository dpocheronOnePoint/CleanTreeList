//
//  ContentView$.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 27/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showLogin = false
    
    var body: some View {
        VStack {
                Text("Welcome!")
                    .font(.title)
         
                Spacer().frame(height: 20)
         
                Button(action: {
                    showLogin = true
                }, label: {
                    Text("Login")
                })
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

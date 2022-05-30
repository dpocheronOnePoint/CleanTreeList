//
//  ContentView$.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 27/05/2022.
//

import SwiftUI

class UITestingBootcampViewModel: ObservableObject {
    let placeholderText: String = "Add your name..."
    @Published var textfieldText: String = ""
    @Published var currentUserSignedIn: Bool = false
    
    func signUpButtonPressed() {
        guard !textfieldText.isEmpty else { return }
        currentUserSignedIn = true
    }
}

struct UITestingBootcampView: View {
    @StateObject private var vm = UITestingBootcampViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            ZStack {
                if vm.currentUserSignedIn {
                    SignedInHomeView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .trailing))
                }
                
                if !vm.currentUserSignedIn {
                    signUpLayer
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .leading))
                }
            }
        }
    }
}

struct UITestingBootcampView_Previews: PreviewProvider {
    static var previews: some View {
        UITestingBootcampView()
    }
}

extension UITestingBootcampView {
    private var signUpLayer: some View {
        VStack {
            TextField(vm.placeholderText, text: $vm.textfieldText)
                .font(.headline)
                .padding()
                .background(.white)
                .cornerRadius(10)
            
            Button(action: {
                withAnimation(.spring()) {
                    vm.signUpButtonPressed()
                }
            }, label: {
                Text("Sign Up")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
        }
        .padding()
    }
}

struct SignedInHomeView: View {
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button(action: {
                    showAlert.toggle()
                }, label: {
                    Text("Show welcome alert !")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                })
                .alert(isPresented: $showAlert, content: {
                    return Alert(title: Text("Welcome to the app!"))
                })
                
                NavigationLink(destination: Text("Destination!"), label: {
                    Text("Navigate")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                })
            } // VSTACK
            .padding()
            .navigationTitle("Welcome")
        }
    }
}

//
//  UsersViewModel.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import Foundation

class UsersViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var femaleIsSelected: Bool = true
    @Published var userIsActive: Bool = false
    
    
}

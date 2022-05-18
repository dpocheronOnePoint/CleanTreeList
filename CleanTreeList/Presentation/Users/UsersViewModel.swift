//
//  UsersViewModel.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 13/05/2022.
//

import Foundation

class UsersViewModel: ObservableObject {
    
    var userApiUseCase = UserApiUseCase(userRemoteRepository: UsersRemoteRepositoryImpl(usersRemoteDataSource: UsersAPIImpl()))
    
    @Published var userPost: UserPost = UserPost.starterUserPost
    @Published var femaleIsSelected: Bool = true {
        didSet {
            if femaleIsSelected {
                userPost.gender = "female"
            }else{
                userPost.gender = "male"
            }
        }
    }
    @Published var userIsActive: Bool = false {
        didSet {
            if userIsActive {
                userPost.status = "active"
            }else{
                userPost.status = "inactive"
            }
        }
    }
    
    func postUser() async {
         print(userPost)
        let createdUser = await userApiUseCase.postUser(user: userPost)
        print(createdUser)
    }
}

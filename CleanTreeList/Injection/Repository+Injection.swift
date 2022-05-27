//
//  Repository+Injection.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 25/05/2022.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerRepositories() {
        
        // TreeList Registration
        register { TreeRemoteImpl() }
            .implements(TreeRemoteDataSource.self)
            .scope(.application)
        
        register { TreeLocalImpl() }
            .implements(TreeLocalDataSource.self)
            .scope(.application)
        
        register { TreesRemoteRepositoryImpl(loadingMethod: .Default) }
            .implements(TreeListRemoteRepository.self)
            .scope(.application)
        
        register { TreesCDRepositoryImpl() }
            .implements(TreeListCDRepository.self)
            .scope(.application)
        
        register { TreeRealmRepositoryImpl() }
            .implements(TreeListRealmRepository.self)
            .scope(.application)
        
        register { TreeCDImpl() }
            .implements(TreeCDDataSource.self)
            .scope(.application)
        
        register { TreeRealmImpl() }
            .implements(TreeRealmDataSource.self)
            .scope(.application)
        
        
        // User Registration
        
        register { UsersRemoteImpl() }
            .implements(UsersRemoteDataSource.self)
            .scope(.application)
        
        register { UsersRemoteRepositoryImpl() }
            .implements(UserRemoteRepository.self)
            .scope(.application)
    }
}

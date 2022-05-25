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
        
        register { TreeRemoteImpl() }
            .implements(TreeRemoteDataSource.self)
            .scope(.application)
        
        register { TreeLocalImpl() }
            .implements(TreeLocalDataSource.self)
            .scope(.application)
    }
}

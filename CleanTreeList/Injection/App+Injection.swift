//
//  App+Injection.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 20/05/2022.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        defaultScope = .application
        register { TreeGetterListViewModel() }
        
        registerRepositories()
        
    }
}

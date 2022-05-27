//
//  ViewModel+Injection.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 25/05/2022.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerViewModel() {
        
        register { TreeGetterListViewModel() }
            .implements(TreeGetterListViewProtocol.self)
            .scope(.application)
        
        register { MapViewModel() }
            .implements(MapViewModelProtocol.self)
            .scope(.application)
    }
}

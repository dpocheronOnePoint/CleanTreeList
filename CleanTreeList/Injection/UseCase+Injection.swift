//
//  UseCase+injection.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 25/05/2022.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerUseCases() {
        
        register { TreeUseCase() }
            .implements(TreeUseCaseProtocol.self)
            .scope(.application)
    }
}

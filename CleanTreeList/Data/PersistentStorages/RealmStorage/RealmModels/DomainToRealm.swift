//
//  DomainToRealm.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 23/05/2022.
//

import Foundation

protocol DomainToRealm {
    associatedtype M: Any
    func toRealm() -> M
}

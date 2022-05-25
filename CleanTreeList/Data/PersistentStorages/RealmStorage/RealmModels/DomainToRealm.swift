//
//  DomainToRealm.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 25/05/2022.
//

import Foundation

protocol DomainToRealm {
    associatedtype N: Any
    func ToRealm() -> N
}

//
//  DomainToCoreData.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 12/05/2022.
//

import Foundation

protocol DomainToCoreData {
    associatedtype M: Any
    func ToCoreData() -> M
}


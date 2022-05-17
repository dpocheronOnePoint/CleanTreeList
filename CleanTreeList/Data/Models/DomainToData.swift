//
//  DomainToData.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 17/05/2022.
//

import Foundation

protocol DomainToData {
    associatedtype M: Any
    func ToData() -> M
}

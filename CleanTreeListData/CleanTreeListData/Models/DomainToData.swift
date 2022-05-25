//
//  DomainToData.swift
//  CleanTreeListData
//
//  Created by Dimitri POCHERON on 25/05/2022.
//

import Foundation

protocol DomainToData {
    associatedtype M: Any
    func ToData() -> M
}

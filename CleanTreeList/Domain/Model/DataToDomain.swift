//
//  DataToDomain.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

protocol DataToDomain {
    associatedtype M: Any
    func ToDomain() -> M
}

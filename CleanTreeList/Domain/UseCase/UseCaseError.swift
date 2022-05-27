//
//  UseCaseError.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 25/05/2022.
//

import Foundation

enum UseCaseError: Error {
case networkError, decodingError, error422(String), statusError
}

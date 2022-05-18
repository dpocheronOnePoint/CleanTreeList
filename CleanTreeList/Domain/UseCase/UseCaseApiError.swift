//
//  UseCaseApiError.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 18/05/2022.
//

import Foundation

enum UseCaseApiError: Error {
    case networkError, decodingError, error422(String), statusError
}

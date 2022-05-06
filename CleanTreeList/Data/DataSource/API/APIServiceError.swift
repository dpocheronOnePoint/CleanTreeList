//
//  APIServiceError.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

enum APIServiceError : Error {
    case badUrl, requestError, decodingError, statusNotOK
}

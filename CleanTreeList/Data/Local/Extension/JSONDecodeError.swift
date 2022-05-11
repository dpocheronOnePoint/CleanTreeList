//
//  JSONDecodeError.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 06/05/2022.
//

import Foundation

enum JSONDecodeError : Error {
    case locatingError, loadingError, decodingError
}

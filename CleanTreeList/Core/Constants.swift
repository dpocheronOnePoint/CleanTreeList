//
//  Constants.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

enum LoadingDataMethod: Int {
    case Default, WithApiManager, FromLocalJson
}

struct EnvironmentVariable {
    static let loadingDataMethod: LoadingDataMethod = LoadingDataMethod.Default
}

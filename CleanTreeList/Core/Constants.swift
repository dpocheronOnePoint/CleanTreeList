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

struct OpenDataAPI {
    static let baseURL = "https://opendata.paris.fr"
    static let searchPath = "/api/records/1.0/search/"
    static let nbrRowPerRequest = "20"
}

struct EnvironmentVariable {
    static let loadingDataMethod: LoadingDataMethod = LoadingDataMethod.Default
}

//
//  Urls.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 11/05/2022.
//

import Foundation

struct OpenDataAPI {
    static let baseURL = "https://opendata.paris.fr"
    static let searchPath = "/api/records/1.0/search/"
    static let nbrRowPerRequest = "20"
}

struct GorestAPI {
    static let baseUrl = "https://gorest.co.in/public/v2/users"
    static let bearerAuthorization = "Bearer d9bb22929bcbb202a9fb1143f51b87aecaaff9cdba82a00af9e33d4829925e9e"
}

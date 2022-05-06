//
//  Constants.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation


struct OpenDataAPI {
    static let baseURL = "https://opendata.paris.fr/"
    static let baseQuery = "api/records/1.0/search/?dataset=les-arbres&q="
    static let nbrRowPerRequest = 20
    static let facet = "&facet=&facet=arrondissement&facet=libellefrancais&facet=genre&facet=espece&facet=circonferenceencm&facet=hauteurenm"
}

struct EnvironmentVariable {
    static let isFromWs = false
}

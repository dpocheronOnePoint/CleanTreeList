//
//  Record.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

struct Records: Decodable {
    let nhits: Int
    let records: [RecordData]
}

struct RecordData:  Codable {
    let recordid: String
    let fields: Record
    let geometry: Geometry
    
    var id: String {
        recordid
    }
}

struct Record: Codable {
    let name, species, address2: String?
    let address: String
    let height, circumference: Int16

    enum CodingKeys: String, CodingKey {
        case name = "libellefrancais"
        case species = "espece"
        case address2 = "complementadresse"
        case address = "adresse"
        case height = "hauteurenm"
        case circumference = "circonferenceencm"
    }
}

struct Geometry: Codable {
    let type: String
    let coordinates: [Double]
}

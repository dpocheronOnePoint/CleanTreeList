//
//  TreeAPIlmpl.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

struct TreeAPIlmpl: TreeDataSource {
    func getTreeList(startRow: Int, nbRows: Int) async throws -> [GeolocatedTree] {
        
        // Define URL and check if it's a good url
        guard let url = URL(string: "https://opendata.paris.fr/api/records/1.0/search/?dataset=les-arbres&q=20&facet=&facet=arrondissement&facet=libellefrancais&facet=genre&facet=espece&facet=circonferenceencm&facet=hauteurenm") else {
            throw APIServiceError.badUrl
        }
        
        // Launch WS call to get data and response
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw APIServiceError.requestError
        }
        
        // Check if response.statusCode is 200
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIServiceError.statusNotOK
        }
        
        // Map result to Records Object
        guard let result = try? JSONDecoder().decode(Records.self, from: data) else {
            print("decodingError")
            throw APIServiceError.decodingError
        }
            
        // Convert Records Object to GeolocatedAPI Array and return it
        return result.records.map({ item in
            GeolocatedTree(
                tree: item.fields.ToDomain(),
                lng: item.geometry.coordinates[0],
                lat: item.geometry.coordinates[1]
            )
        })
    }
    
    func getTreeListFromLocal() async throws -> [GeolocatedTree] {
        
        // Map result to Records Object
        let result: Records = try Bundle.main.decode(Records.self, from: "trees.json")
        
        // Convert Records Object to GeolocatedAPI Array and return it
        return result.records.map({ item in
            GeolocatedTree(
                tree: item.fields.ToDomain(),
                lng: item.geometry.coordinates[0],
                lat: item.geometry.coordinates[1]
            )
        })
    }
}

//
//  TreeAPIlmpl.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

struct TreeAPIlmpl: TreeDataSource {
    func getTreeList(startRow: Int) async throws -> [GeolocatedTree] {
        
        // Define URL and check if it's a good url
        guard var urlComponents = URLComponents(string: "\(OpenDataAPI.baseURL)\(OpenDataAPI.searchPath)") else {
            throw APIServiceError.badUrl
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "dataset", value: "les-arbres"),
            URLQueryItem(name: "rows", value: OpenDataAPI.nbrRowPerRequest)
        ]
        
        let urlRequest = URLRequest(url: urlComponents.url!)
        
        // Launch WS call to get data and response
        guard let (data, response) = try? await URLSession.shared.data(for: urlRequest) else {
            throw APIServiceError.requestError
        }
        
        // Check if response.statusCode is 200
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIServiceError.statusNotOK
        }
        
        // Map result to Records Object
        guard let result = try? JSONDecoder().decode(Records.self, from: data) else {
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
    
    
    func getTreeListWithApiManager(startRow: Int) async throws -> [GeolocatedTree] {
        
        // Define request parameters
        let parameters = [
            URLQueryItem(name: "dataset", value: "les-arbres"),
            URLQueryItem(name: "rows", value: OpenDataAPI.nbrRowPerRequest)
        ]
        
        guard let result = await ApiManager.shared.sendRequest(
            model: Records.self,
            with: OpenDataAPI.searchPath,
            requestType: .getRequest,
            body: [:],
            parameters: parameters
        ) else {
            throw APIServiceError.decodingError
        }
        
        switch result {
        case .success(let response):
            // Convert Records Object to GeolocatedAPI Array and return it
            return response.records.map({ item in
                GeolocatedTree(
                    tree: item.fields.ToDomain(),
                    lng: item.geometry.coordinates[0],
                    lat: item.geometry.coordinates[1]
                )
            })
        case .failure:
            return []
        }
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

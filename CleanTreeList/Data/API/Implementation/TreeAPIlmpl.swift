//
//  TreeAPIlmpl.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

struct TreeAPIlmpl: TreeRemoteDataSource {
    
    func getTreeList(startIndex: Int) async throws -> [RecordData] {
        
        // Define URL and check if it's a good url
        guard var urlComponents = URLComponents(string: "\(OpenDataAPI.baseURL)\(OpenDataAPI.searchPath)") else {
            throw APIServiceError.badUrl
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "dataset", value: "les-arbres"),
            URLQueryItem(name: "start", value: "\(startIndex)"),
            URLQueryItem(name: "rows", value: OpenDataAPI.nbrRowPerRequest)
        ]
        
        let urlRequest = URLRequest(url: urlComponents.url!)
        
        // Launch WS call to get data and response
        guard let (data, response) = try? await URLSession.shared.data(for: urlRequest) else {
            throw APIServiceError.requestError
        }
        
        // Check if response.statusCode is 200
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIServiceError.statusError
        }
        
        // Map result to Records Object and return it
        guard let result = try? JSONDecoder().decode(Records.self, from: data) else {
            throw APIServiceError.decodingError
        }
        
        return result.records
    }
    
    
    func getTreeListWithApiManager(startIndex: Int) async throws -> [RecordData] {
        
        // Define request parameters
        let parameters = [
            URLQueryItem(name: "dataset", value: "les-arbres"),
            URLQueryItem(name: "start", value: "\(startIndex)"),
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
            return response.records
        case .failure:
            return []
        }
    }
}

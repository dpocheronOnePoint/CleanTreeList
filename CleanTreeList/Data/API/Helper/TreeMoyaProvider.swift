//
//  TreeMoyaProvider.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 14/06/2022.
//

import Moya

public enum TreeMoyaProvider {
    case search
}

extension TreeMoyaProvider: TargetType {
    public var baseURL: URL {
        return URL(string: OpenDataAPI.baseURL)!
    }
    
    public var path: String {
        switch self {
        case .search: return OpenDataAPI.searchPath
        }
    }
    
    public var method: Method {
        switch self {
        case .search: return .get
        }
    }
    
    // Use for Unit tests --> Mock response
    public var sampleData: Data {
      return Data()
    }
    
    public var task: Task {
        switch self {
        case .search:
            return .requestParameters(parameters: [
                "dataset": "les-arbres",
                "start": "\(20)",
                "rows": OpenDataAPI.nbrRowPerRequest
            ], encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
      return .successCodes
    }
}

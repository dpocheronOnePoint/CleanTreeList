//
//  TreeRepositoryImpl.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

enum LoadingDataMethod {
    case Default, WithApiManager, FromLocalJson
}

struct TreeRepositoryImpl: TreeListRepository {
    
    // Constant to select the loading method
    let loadingMethod: LoadingDataMethod = .Default
    
    var remoteDataSource: TreeRemoteDataSource
    var localDataSource: TreeLocalDataSource
    
    func getTreeList(startIndex: Int) async throws -> [GeolocatedTree] {
        let trees: [GeolocatedTree]
        
        switch loadingMethod {
        
        case .Default:
            trees = try await remoteDataSource.getTreeList(startIndex: startIndex)
        
        case .WithApiManager:
            trees = try await remoteDataSource.getTreeListWithApiManager(startIndex: startIndex)
        
        case .FromLocalJson:
            trees = try await localDataSource.getTreeListFromLocal()
        }
        
        return trees
    }
}

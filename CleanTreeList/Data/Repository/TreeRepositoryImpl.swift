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
    
    func getTreeList(startIndex: Int) async throws -> [RecordData] {
        let records: [RecordData]
        
        switch loadingMethod {
        
        case .Default:
            records = try await remoteDataSource.getTreeList(startIndex: startIndex)
        
        case .WithApiManager:
            records = try await remoteDataSource.getTreeListWithApiManager(startIndex: startIndex)
        
        case .FromLocalJson:
            records = try await localDataSource.getTreeListFromLocal()
        }
        
        return records
    }
}

//
//  TreeRepositoryImpl.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation
import Resolver

enum LoadingDataMethod {
    case Default, WithApiManager, FromLocalJson
}

struct TreesRemoteRepositoryImpl: TreeListRemoteRepository {
    
    // Constant to select the loading method
    let loadingMethod: LoadingDataMethod = .Default
    
    @Injected var remoteDataSource: TreeRemoteDataSource
    @Injected var localDataSource: TreeLocalDataSource
    
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

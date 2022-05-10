//
//  getTreeList.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

protocol getTreeList {
    func execute(startIndex: Int) async -> Result<[GeolocatedTree], UseCaseError>
}

struct GetTreeListUseCase: getTreeList {
    
    var treeListRepository: TreeListRepository
    
    func execute(startIndex: Int) async -> Result<[GeolocatedTree], UseCaseError> {
        do {
            switch EnvironmentVariable.loadingDataMethod {
            case .Default:
                let treeList = try await treeListRepository.getTreeList(startIndex: startIndex)
                return .success(treeList)
            case .WithApiManager:
                let treeList = try await treeListRepository.getTreeListWithApiManager(startIndex: startIndex)
                return .success(treeList)
            case .FromLocalJson:
                let treeList = try await treeListRepository.getTreeListFromLocal()
                return .success(treeList)
            }
            
        } catch (let error) {
            
            switch error {
            case APIServiceError.decodingError:
                return .failure(.decodingError)
                
            default:
                return .failure(.networkError)
            }
            
        }
    }
}

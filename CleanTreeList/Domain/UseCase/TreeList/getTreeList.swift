//
//  getTreeList.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

protocol getTreeList {
    func execute(startRow: Int) async -> Result<[GeolocatedTree], UseCaseError>
}

struct GetTreeListUseCase: getTreeList {
    
    var treeListRepository: TreeListRepository
    
    func execute(startRow: Int = 0) async -> Result<[GeolocatedTree], UseCaseError> {
        do {
            
            let treeList = try await treeListRepository.getTreeList(startRow: startRow, nbrRows: OpenDataAPI.nbrRowPerRequest)
            return .success(treeList)
            
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

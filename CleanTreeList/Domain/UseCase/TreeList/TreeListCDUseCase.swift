//
//  TreeListCDUseCase.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 11/05/2022.
//

import Foundation
import CoreData

enum UseCaseCDError: Error {
    case fetchingError
}

protocol TreeListCDUseCaseProtocol {
    func loadLocalTrees() async -> Result<[GeolocatedTree], UseCaseCDError>
}

struct TreeListCDUseCase: TreeListCDUseCaseProtocol {
    func loadLocalTrees() async -> Result<[GeolocatedTree], UseCaseCDError> {
        return .success([])
    }
    
    
}

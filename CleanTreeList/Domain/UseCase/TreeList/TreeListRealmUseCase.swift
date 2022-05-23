//
//  TreeListRealmUseCase.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 23/05/2022.
//

import Foundation
import RealmSwift

enum UseCaseRealmError: Error {
    case insertingError
}

protocol TreeListRealmProtocol {
    func saveGeolocatedTreeListInCoreDataWith(geolocatedTreeList: [GeolocatedTree]) async throws
}

struct TreeListRealmUseCase: TreeListRealmProtocol {
    var treeListRealmRepository: TreeListRealmRepository
    
    func saveGeolocatedTreeListInCoreDataWith(geolocatedTreeList: [GeolocatedTree]) async throws {
        do {
            try await treeListRealmRepository.saveGeolocatedTreeInRealmwiWith(geolocatedTreeList: geolocatedTreeList)
        } catch {
            throw UseCaseRealmError.insertingError
        }
    }
}

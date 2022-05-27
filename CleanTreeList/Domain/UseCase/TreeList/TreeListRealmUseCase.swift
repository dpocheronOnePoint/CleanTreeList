////
////  TreeListRealmUseCase.swift
////  CleanTreeList
////
////  Created by Dimitri POCHERON on 23/05/2022.
////
//
//import Foundation
//import RealmSwift
//
//enum UseCaseRealmError: Error {
//    case fetchingError, deletingError, insertingError
//}
//
//protocol TreeListRealmProtocol {
//    func loadLocalTrees() async -> Result<[GeolocatedTree], UseCaseRealmError>
//    func clearDataBase() async throws
//    func saveGeolocatedTreeInRealmwiWith(geolocatedTreeList: [GeolocatedTree]) async throws
//}
//
//struct TreeListRealmUseCase: TreeListRealmProtocol {
//    var treeListRealmRepository: TreeListRealmRepository
//    
//    func loadLocalTrees() async -> Result<[GeolocatedTree], UseCaseRealmError> {
//        do {
//            let realmGeolocatedTrees = try await treeListRealmRepository.loadLocalTrees()
//            let geolocatedTress: [GeolocatedTree] = realmGeolocatedTrees.map({ item in
//                GeolocatedTree(tree: item.tree!.ToDomain(), lng: item.lng, lat: item.lat)
//            })
//            return .success(geolocatedTress)
//        } catch {
//            return .failure(.fetchingError)
//        }
//    }
//    
//    func clearDataBase() async throws {
//        do {
//            try await treeListRealmRepository.clearDataBase()
//        } catch {
//            throw UseCaseRealmError.deletingError
//        }
//    }
//    
//    func saveGeolocatedTreeInRealmwiWith(geolocatedTreeList: [GeolocatedTree]) async throws {
//        do {
//            try await treeListRealmRepository.saveGeolocatedTreeInRealmwiWith(geolocatedTreeList: geolocatedTreeList)
//        } catch {
//            throw UseCaseRealmError.insertingError
//        }
//    }
//}

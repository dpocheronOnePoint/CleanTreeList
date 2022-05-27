////
////  TreeListCDUseCase.swift
////  CleanTreeList
////
////  Created by Dimitri POCHERON on 11/05/2022.
////
//
//import Foundation
//import CoreData
//
//enum UseCaseCDError: Error {
//    case fetchingError, deletingError, insertingError
//}
//
//protocol TreeListCDUseCaseProtocol {
////    func loadLocalTrees() async -> Result<[GeolocatedTree], UseCaseCDError>
//    func clearDataBase() async throws
//    func saveGeolocatedTreeListInCoreDataWith(geolocatedTreeList: [GeolocatedTree]) async throws
//}
//
//struct TreeListCDUseCase: TreeListCDUseCaseProtocol {
//
//    var treeListCDRepository: TreeListCDRepository
//
////    func loadLocalTrees() async -> Result<[GeolocatedTree], UseCaseCDError> {
////        do {
////            let cdGeolocatedTrees = try await treeListCDRepository.loadLocalTrees()
////
////            let geolocatedTrees: [GeolocatedTree] = cdGeolocatedTrees.map({ item in
////                GeolocatedTree(
////                    tree: item.tree.ToDomain(),
////                    lng: item.lng,
////                    lat: item.lat
////                )
////            })
////
////            return .success(geolocatedTrees)
////        } catch {
////            return .failure(.fetchingError)
////        }
////    }
//
//    func clearDataBase() async throws {
//        do {
//            try await treeListCDRepository.clearDataBase()
//        } catch {
//            throw UseCaseCDError.deletingError
//        }
//    }
//
//    func saveGeolocatedTreeListInCoreDataWith(geolocatedTreeList: [GeolocatedTree]) async throws {
//        do {
//            try await treeListCDRepository.saveGeolocatedTreeListInCoreDataWith(geolocatedTreeList: geolocatedTreeList)
//        } catch {
//            throw UseCaseCDError.insertingError
//        }
//    }
//
//}

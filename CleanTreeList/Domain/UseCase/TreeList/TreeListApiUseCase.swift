//
//  getTreeList.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

//import Foundation
//import CoreData
//
//protocol TreeListApiUseCaseProtocol {
//    func getTreeList(startIndex: Int) async -> Result<[GeolocatedTree], UseCaseApiError>
//}
//
//struct TreeListApiUseCase: TreeListApiUseCaseProtocol {
//
//    var treeListRemoteRepository: TreeListRemoteRepository
//
//    func getTreeList(startIndex: Int) async -> Result<[GeolocatedTree], UseCaseApiError> {
//        do {
//
//            let records = try await treeListRemoteRepository.getTreeList(startIndex: startIndex)
//            return .success(
//                records.map({ item in
//                    GeolocatedTree(
//                        tree: item.fields.ToDomain(),
//                        lng: item.geometry.coordinates[0],
//                        lat: item.geometry.coordinates[1]
//                    )
//                })
//            )
//
//        } catch (let error) {
//
//            switch error {
//            case APIServiceError.decodingError:
//                return .failure(.decodingError)
//
//            default:
//                return .failure(.networkError)
//            }
//
//        }
//    }
//}

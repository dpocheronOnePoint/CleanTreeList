//
//  getTreeList.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation
import CoreData

enum UseCaseApiError: Error {
    case networkError, decodingError
}

protocol TreeListApiUseCaseProtocol {
//    func loadLocalTrees() async -> Result<[GeolocatedTree], UseCaseError>
    func getTreeList(startIndex: Int) async -> Result<[GeolocatedTree], UseCaseApiError>
}

struct TreeListApiUseCase: TreeListApiUseCaseProtocol {
    
    var treeListRepository: TreeListRemoteRepository
    
//    func loadLocalTrees() -> Result<[GeolocatedTree], UseCaseError> {
//
//        let fetchRequest: NSFetchRequest<CDGeolocatedTree>
//        fetchRequest = CDGeolocatedTree.fetchRequest()
//
//        let context = CoreDataStack.sharedInstance.viewContext
//
//        do {
//            let cdGeolocatedTrees: [CDGeolocatedTree] = try context.fetch(fetchRequest)
//            let treeList: [GeolocatedTree] = cdGeolocatedTrees.map({ item in
//                GeolocatedTree(
//                    tree: item.tree.ToDomain(),
//                    lng: item.lng,
//                    lat: item.lat
//                )
//            })
//
//            return .success(treeList)
//        }catch {
//            return .failure(.databaseError)
//        }
//    }
    
    func getTreeList(startIndex: Int) async -> Result<[GeolocatedTree], UseCaseApiError> {
        do {

            let records = try await treeListRepository.getTreeList(startIndex: startIndex)
            return .success(
                records.map({ item in
                    GeolocatedTree(
                        tree: item.fields.ToDomain(),
                        lng: item.geometry.coordinates[0],
                        lat: item.geometry.coordinates[1]
                    )
                })
            )
            
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

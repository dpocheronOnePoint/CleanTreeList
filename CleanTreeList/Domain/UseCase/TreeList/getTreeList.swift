//
//  getTreeList.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation
import CoreData

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
    
    func clearData() {
        let context = CoreDataStack.sharedInstance.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: CDGeolocatedTree.self))
        do {
            let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
            _ = objects.map{$0.map{context.delete($0)}}
            CoreDataStack.sharedInstance.saveContext()
        } catch let error {
            print("ERROR DELETING : \(error)")
        }
    }
}

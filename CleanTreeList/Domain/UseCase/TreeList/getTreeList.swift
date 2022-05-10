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
            let treeList: [GeolocatedTree]
            
            switch EnvironmentVariable.loadingDataMethod {
            case .Default:
                treeList = try await treeListRepository.getTreeList(startIndex: startIndex)
            case .WithApiManager:
                treeList = try await treeListRepository.getTreeListWithApiManager(startIndex: startIndex)
            case .FromLocalJson:
                treeList = try await treeListRepository.getTreeListFromLocal()
                
            }
            
            displayTreeFromDB()
//            clearData()
//            saveGeolocatedTreeListInCoreDataWith(geolocatedTreeList: treeList)
            
            
            
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
    
    func createGeolocatedTreeEntityFrom(geolocatedTree: GeolocatedTree) {
        let context = CoreDataStack.sharedInstance.viewContext
        if let geolocatedTreeEntity = NSEntityDescription.insertNewObject(forEntityName: "CDGeolocatedTree", into: context) as? CDGeolocatedTree {
            print("###### \(geolocatedTree.lng)")
            geolocatedTreeEntity.lng = geolocatedTree.lng
        }
    }
    
    func saveGeolocatedTreeListInCoreDataWith(geolocatedTreeList: [GeolocatedTree]) {
        for geolocatedTree in geolocatedTreeList {
            self.createGeolocatedTreeEntityFrom(geolocatedTree: geolocatedTree)
        }
        CoreDataStack.sharedInstance.saveContext()
    }
    
    func displayTreeFromDB() {
        // Create a fetch request with a string filter
        // for an entity’s name
        let fetchRequest: NSFetchRequest<CDGeolocatedTree>
        fetchRequest = CDGeolocatedTree.fetchRequest()
        
        //        fetchRequest.predicate = NSPredicate(
        //            format: "name LIKE %@", "Robert"
        //        )
        
        // Get a reference to a NSManagedObjectContext
        let context = CoreDataStack.sharedInstance.viewContext
        
        // Perform the fetch request to get the objects
        // matching the predicate
        do {
            let objects: [CDGeolocatedTree] = try context.fetch(fetchRequest)
            for test in objects {
                print("###### \(test.lng)")
            }
            print(objects)
        } catch {
            print("Error")
        }
    }
}

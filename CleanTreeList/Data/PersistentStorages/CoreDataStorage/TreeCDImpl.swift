//
//  TreeCDImpl.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 11/05/2022.
//

import Foundation
import CoreData

enum CoreDataError : Error {
    case fetchingError, insertingError, deletingError
}

struct TreeCDImpl: TreeCDDataSource {
    func getTreeList(startIndex: Int) async throws -> [RecordData] {
        return []
    }
    
    
    
    func loadLocalTrees() async throws -> [CDGeolocatedTree] {
        
        let fetchRequest: NSFetchRequest<CDGeolocatedTree>
        fetchRequest = CDGeolocatedTree.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "tree.name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let context = CoreDataStack.sharedInstance.viewContext
        
        guard let cdGeolocatedTrees: [CDGeolocatedTree] = try? context.fetch(fetchRequest) else {
            throw CoreDataError.fetchingError
        }
        return cdGeolocatedTrees
    }
    
    func clearDataBase() async throws {
        let context = CoreDataStack.sharedInstance.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: CDGeolocatedTree.self))
        do {
            let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
            _ = objects.map{$0.map{context.delete($0)}}
            CoreDataStack.sharedInstance.saveContext()
        } catch {
            throw CoreDataError.deletingError
        }
    }
    
    func saveGeolocatedTreeListInCoreDataWith(geolocatedTreeList: [GeolocatedTree]) throws {
        for geolocatedTree in geolocatedTreeList {
            let _ = geolocatedTree.ToCoreData()
        }
        CoreDataStack.sharedInstance.saveContext()
    }
}

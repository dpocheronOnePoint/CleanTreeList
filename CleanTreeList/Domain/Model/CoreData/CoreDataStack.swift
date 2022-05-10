//
//  CoreDataStack.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 10/05/2022.
//

import Foundation
import CoreData

final class CoreDataStack {
    // MARK: - Properties
    private let persistentContainerName = "CleanTreeLisy"
    
    // MARK: - Singleton
    static let sharedInstance = CoreDataStack()
    
    // MARK: - Public
    var viewContext: NSManagedObjectContext {
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Private
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo) for \(storeDescription.description)")
            }
        })
        
        return container
    }()
}

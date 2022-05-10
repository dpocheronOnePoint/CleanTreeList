//
//  CDTree+CoreDataProperties.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 10/05/2022.
//
//

import Foundation
import CoreData


extension CDTree {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTree> {
        return NSFetchRequest<CDTree>(entityName: "CDTree")
    }

    @NSManaged public var name: String?
    @NSManaged public var species: String?
    @NSManaged public var address2: String?
    @NSManaged public var address: String
    @NSManaged public var height: Int16
    @NSManaged public var circumference: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var fromGeolocatedTree: CDGeolocatedTree?

}

extension CDTree : Identifiable {

}

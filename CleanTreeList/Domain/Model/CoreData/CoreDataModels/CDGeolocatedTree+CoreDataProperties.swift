//
//  CDGeolocatedTree+CoreDataProperties.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 10/05/2022.
//
//

import Foundation
import CoreData


extension CDGeolocatedTree {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGeolocatedTree> {
        return NSFetchRequest<CDGeolocatedTree>(entityName: "CDGeolocatedTree")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var lng: Double

}

extension CDGeolocatedTree : Identifiable {

}

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
    @NSManaged public var tree: CDTree
    @NSManaged public var lat, lng: Double

}

extension CDGeolocatedTree : Identifiable {

}

extension GeolocatedTree: DomainToCoreData {
    func ToCoreData() -> CDGeolocatedTree {
        let cdGeolocatedTree = CDGeolocatedTree(context: CoreDataStack.sharedInstance.viewContext)
        cdGeolocatedTree.tree = tree.ToCoreData()
        cdGeolocatedTree.lat = lat
        cdGeolocatedTree.lng = lng
        return cdGeolocatedTree
    }
}

//
//  RealmManager.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 23/05/2022.
//

import Foundation
import RealmSwift

final class RealmManager {
    private(set) var localrealm: Realm?
    
    init(){
        openRealm()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            
            Realm.Configuration.defaultConfiguration = config
            
            localrealm = try Realm()
        } catch {
            print("Error opening realm: \(error)")
        }
    }
}

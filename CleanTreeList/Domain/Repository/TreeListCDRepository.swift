//
//  TreeListCDRepository.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 12/05/2022.
//

import Foundation

protocol TreeListCDRepository {
    func loadLocalTrees() async throws -> [CDGeolocatedTree]
}

//
//  TreeListRepository.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

protocol TreeListRepository {
    func getTreeList(startRow: Int, nbrRows: Int) async throws -> [GeolocatedTree]
}

//
//  TreeDataSource.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

protocol TreeDataSource {
    func getTreeList(startRow: Int, nbRows: Int) async throws -> [GeolocatedTree]
}

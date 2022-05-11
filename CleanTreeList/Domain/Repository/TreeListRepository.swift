//
//  TreeListRepository.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

protocol TreeListRepository {
    func getTreeList(startIndex: Int) async throws -> [RecordData]
}

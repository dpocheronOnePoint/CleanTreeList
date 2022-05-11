//
//  TreeListRepository.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

protocol TreeListRemoteRepository {
    func getTreeList(startIndex: Int) async throws -> [RecordData]
}

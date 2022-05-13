//
//  TreeLocalDataSource.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 11/05/2022.
//

import Foundation

protocol TreeLocalDataSource {
    func getTreeListFromLocal() async throws -> [RecordData]
}

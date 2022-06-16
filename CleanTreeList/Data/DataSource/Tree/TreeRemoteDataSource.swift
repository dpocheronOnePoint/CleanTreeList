//
//  TreeDataSource.swift
//  CleanTreeList
//
//  Created by Dimitri POCHERON on 05/05/2022.
//

import Foundation

protocol TreeRemoteDataSource {
    func getTreeList(startIndex: Int) async throws -> [RecordData]
    func getTreeListWithApiManager(startIndex: Int) async throws -> [RecordData]
    func getTreeListWithMoya(startIndew: Int) async throws -> [RecordData]
}

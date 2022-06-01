//
//  TreeGetterListViewModel_Tests.swift
//  CleanTreeList_Tests
//
//  Created by Dimitri POCHERON on 24/05/2022.
//

import XCTest
import Nimble
@testable import CleanTreeList

class TreesRemoteRepositoryImpl_Tests: XCTestCase {

    private var treesRemoteRepositoryImpl = TreesRemoteRepositoryImpl(loadingMethod: .FromLocalJson)
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_TreeGetterListViewModel_geolocatedTrees_notEmpty() async throws{
        
        guard let mockGeolocatedTrees = try? await treesRemoteRepositoryImpl.getTreeList(startIndex: 0) else {
            throw UseCaseError.decodingError
        }
        
        expect(mockGeolocatedTrees).notTo(haveCount(0))
        
//        XCTAssertNotNil(mockGeolocatedTrees)
    }
}

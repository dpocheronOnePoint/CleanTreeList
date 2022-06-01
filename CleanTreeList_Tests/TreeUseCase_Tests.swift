//
//  TreeUseCase_Tests.swift
//  CleanTreeList_Tests
//
//  Created by Dimitri POCHERON on 27/05/2022.
//

import XCTest
@testable import CleanTreeList
import Resolver
import CoreData

class TreeUseCase_Tests: XCTestCase {
    
    @Injected var treeUseCase: TreeUseCase
    var geolocatedTrees: [GeolocatedTree] = []
    
    // MARK: - SetUp And TearDown functions
    
    // Function call before every tests start
    override func setUpWithError() throws {
        guard  let records: Records = try? Bundle.main.decode(Records.self, from: "trees.json") else {
            throw UseCaseError.decodingError
        }
        
        geolocatedTrees = treeUseCase.convertRecordsArrayToGeolocatedTreeArray(recordsData: records.records)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Tests functions
    
    func test_TreeUseCase_ConvertRecordDataToGeolocatedTrees_Success() throws {
        
        XCTAssertNotNil(geolocatedTrees)
        XCTAssertTrue(geolocatedTrees.count == 10)
        
        let firstGeolocatedTree = geolocatedTrees.first
        
        
        XCTAssertEqual(firstGeolocatedTree?.tree.name, "Erable")
        
    }
    
    func test_TreeUseCase_SaveAndLoadCDGeolocatedTrees_Success() async throws {
        XCTAssertTrue(
            geolocatedTrees.count == 10,
            "Check if mockData is loaded"
        )
        
        await treeUseCase.updateCDDataBase(geolocatedTrees: geolocatedTrees)
        
        let cdGeolocatedTRees = try await treeUseCase.treeListCDRepository.loadLocalTrees()
        
        XCTAssertEqual(
            cdGeolocatedTRees.count, geolocatedTrees.count ,
            "Check if CoreData geolocatedTrees count equal to mockData Count"
        )
    }
    
    func test_TreeUseCase_ClearSaveAndLoadRealmGeolocatedTrees_Success() async throws {
        XCTAssertTrue(
            geolocatedTrees.count == 10,
            "Check if mockData is loaded"
        )
        
        await treeUseCase.updateRealmDataBase(geolocatedTrees: geolocatedTrees)
        
        let realmGeolocatedTrees = try await treeUseCase.treeListRealmRepository.loadLocalTrees()
        
        XCTAssertEqual(
            realmGeolocatedTrees.count, geolocatedTrees.count ,
            "Check if Realm geolocatedTrees count equal to mockData Count"
        )
        
    }
}

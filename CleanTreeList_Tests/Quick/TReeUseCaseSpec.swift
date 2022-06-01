//
//  TReeUseCaseSpec.swift
//  CleanTreeList_Tests
//
//  Created by Dimitri POCHERON on 01/06/2022.
//

@testable import CleanTreeList
import Quick
import Nimble
import Resolver
import SwiftUI

class TReeUseCaseSpec: QuickSpec {
    override func spec() {
        @Injected var treeUseCase: TreeUseCase
        var geolocatedTrees: [GeolocatedTree] = []
        guard  let records: Records = try? Bundle.main.decode(Records.self, from: "trees.json") else {
            return
        }
        
        beforeSuite {
            waitUntil { done in
                geolocatedTrees = treeUseCase.convertRecordsArrayToGeolocatedTreeArray(recordsData: records.records)
                done()
            }
        }
        
        it("should do some async operation") {
            expect(geolocatedTrees).notTo(haveCount(0))
        }
    }
}

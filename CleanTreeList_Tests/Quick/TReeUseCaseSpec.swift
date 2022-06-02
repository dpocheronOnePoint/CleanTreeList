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
    
    // Needed to place variable out of spec function to be use in async process
    @Injected var treeUseCase: TreeUseCase
    var geolocatedTrees: [GeolocatedTree] = []
    var cdGeolocatedTRees: [CDGeolocatedTree] = []
    
    override func spec() {
        
        guard  let records: Records = try? Bundle.main.decode(Records.self, from: "trees.json") else {
            return
        }
        
        beforeSuite {
            self.geolocatedTrees = self.treeUseCase.convertRecordsArrayToGeolocatedTreeArray(recordsData: records.records)
        }
        
        it("Check if Mock Data is valid") {
            expect(self.geolocatedTrees).to(haveCount(10))
            
            let firstGeolocatedTree = self.geolocatedTrees.first
            
            expect(firstGeolocatedTree?.tree.name).to(equal("Erable"))
        }
        
        it("Save Mock Data to CoreData") {
            expect(self.geolocatedTrees).to(haveCount(10))
            
            Task {
                await self.treeUseCase.updateCDDataBase(geolocatedTrees: self.geolocatedTrees)
                self.cdGeolocatedTRees = try await self.treeUseCase.treeListCDRepository.loadLocalTrees()
                expect(self.cdGeolocatedTRees).to(haveCount(10))
            }
        }
    }
}

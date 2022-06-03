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

class TreeUseCaseSpec: QuickSpec {
    
    // Needed to place variable out of spec function to be use in async process
    @Injected var treeUseCase: TreeUseCase
    var geolocatedTrees: [GeolocatedTree] = []
    
    override func spec() {
        
        describe("Save MockData to database") {
            guard  let records: Records = try? Bundle.main.decode(Records.self, from: "trees.json") else {
                return
            }
            
            beforeSuite {
                self.geolocatedTrees = self.treeUseCase.convertRecordsArrayToGeolocatedTreeArray(recordsData: records.records)
            }
            
            context("Mock data validity") {
                it("Count is valid") {
                    expect(self.geolocatedTrees).to(haveCount(10))
                }
                
                it("Firt item title is valid") {
                    let firstGeolocatedTree = self.geolocatedTrees.first
                    expect(firstGeolocatedTree?.tree.name).to(equal("Erable"))
                }
            }
            
            context("CoreData") {
                it("Save and load Mock Data") {
                    Task {
                        await self.treeUseCase.updateCDDataBase(geolocatedTrees: self.geolocatedTrees)
                        let cdGeolocatedTrees = try await self.treeUseCase.treeListCDRepository.loadLocalTrees()
                        expect(cdGeolocatedTrees).to(haveCount(self.geolocatedTrees.count))
                    }
                }
            }
            
            context("Realm") {
                it("Save and load Mock Data") {
                    Task {
                        await self.treeUseCase.updateRealmDataBase(geolocatedTrees:self.geolocatedTrees)
                        let realmGeolocatedTrees = try await self.treeUseCase.treeListRealmRepository.loadLocalTrees()
                        expect(realmGeolocatedTrees).to(haveCount(self.geolocatedTrees.count))
                    }
                }
            }
        }
    }
}

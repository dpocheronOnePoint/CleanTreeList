//
//  TreeListViewModelSpec.swift
//  CleanTreeList_Tests
//
//  Created by Dimitri POCHERON on 03/06/2022.
//

@testable import CleanTreeList
import Quick
import Nimble
import Resolver
import Combine

class TreeListViewModelSpec: QuickSpec {
    
    @Injected var treeUseCase: TreeUseCase
    var treeListViewModel = TreeListViewModel()
    var geolocatedTrees: [GeolocatedTree] = []
    private var cancellables = Set<AnyCancellable>()
    
    override func spec() {
        describe("Filter trees list") {
            guard  let records: Records = try? Bundle.main.decode(Records.self, from: "trees.json") else {
                return
            }
            
            beforeSuite {
                self.geolocatedTrees = self.treeUseCase.convertRecordsArrayToGeolocatedTreeArray(recordsData: records.records)
            }
            
            context("No search text") {
                it("Test") {
                    expect(self.geolocatedTrees).to(haveCount(10))
                }
                
                
                
                it("return all result") { [self] in
                    self.treeListViewModel
                        .$geolocatedTrees
                        .dropFirst()
                            .sink { geolocatedTrees in
                                expect(geolocatedTrees).to(haveCount(1))
                            }.store(in: &self.cancellables)
                    
                    self.treeListViewModel.filterTreeResult(searchText: "Pin", allGeolocatedTrees: self.geolocatedTrees)
                }
            }
        }
    }
    
}

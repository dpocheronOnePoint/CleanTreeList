//
//  TreesRemoteRepositoryImplSpec.swift
//  CleanTreeList_Tests
//
//  Created by Dimitri POCHERON on 01/06/2022.
//

import Quick
import Nimble
@testable import CleanTreeList

class TreesRemoteRepositoryImplSpec: QuickSpec {
    override func spec() {
        describe("The TreesRemoteRepositoryImpl") {
            let treesRemoteRepositoryImpl = TreesRemoteRepositoryImpl(loadingMethod: .FromLocalJson)
            it("Loading mock GeolocatedTree list") {
                Task {
                    guard let mockGeolocatedTrees = try? await treesRemoteRepositoryImpl.getTreeList(startIndex: 0) else {
                        throw UseCaseError.decodingError
                    }
                    expect(mockGeolocatedTrees).notTo(haveCount(0))
                }
            }
        }
    }
}

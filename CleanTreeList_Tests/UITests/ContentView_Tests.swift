//
//  ContentView_Tests.swift
//  CleanTreeList_Tests
//
//  Created by Dimitri POCHERON on 27/05/2022.
//

import XCTest

class ContentView_Tests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_ContentView() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let welcome = app.staticTexts["Welcome!"]
        
        XCTAssert(welcome.exists)
    }
}

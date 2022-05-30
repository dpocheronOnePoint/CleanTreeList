//
//  CleanTreeListUITests.swift
//  CleanTreeListUITests
//
//  Created by Dimitri POCHERON on 27/05/2022.
//

import XCTest

class CleanTreeListUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_UITestingBootcampView_signUpButton_shouldNotSignin() {
        
        // Given
        let textfield = app.textFields["SignUpTextField"]
        
        
        textfield.tap()
        
        let keyA = app/*@START_MENU_TOKEN@*/.keys["A"]/*[[".keyboards.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        keyA.tap()
        let keya = app.keys["a"]
        keya.tap()
        
        let returnButton = app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"retour\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        returnButton.tap()
        
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
        
        let navBar = app.navigationBars["Welcome"]
        
        XCTAssertTrue(navBar.exists)
    }
}

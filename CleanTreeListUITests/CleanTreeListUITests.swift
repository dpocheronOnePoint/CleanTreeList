//
//  CleanTreeListUITests.swift
//  CleanTreeListUITests
//
//  Created by Dimitri POCHERON on 27/05/2022.
//

import XCTest

class CleanTreeListUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    // UI constant
    
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_UITestingBootcampView_signUpButton_shouldNotSignin() {
        signUpAndSignIn(writeText: false)
        
        checkUserIsConnected(userConnected: false)
    }
    
    func test_UITestingBootcampView_signUpButton_shouldSignin() {
        signUpAndSignIn(writeText: true)
        
        checkUserIsConnected(userConnected: true)
    }
    
    func test_SignedInHomeView_showalertButton_shouldDisplayAndDismissAlert() {
        
        signUpAndSignIn(writeText: true)
        
        checkUserIsConnected(userConnected: true)
        
        let showAlertButton = app.buttons["ShowAlertButton"]
        showAlertButton.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists)
        
        let alertOKButton = alert.buttons["OK"]
        XCTAssertTrue(alertOKButton.exists)
        
        let alertOKButtonExists = alertOKButton.waitForExistence(timeout: 5)
        XCTAssertTrue(alertOKButtonExists)
        
        alertOKButton.tap()
        
        // To slow down action befor testing alert disappear
        sleep(5)
        
        XCTAssertFalse(alert.exists)
    }
    
    func test_SignedInHomeView_navigationLinkToDestination_shouldNavigateToDestinationAndGoBack() {
        
        signUpAndSignIn(writeText: true)
        
        checkUserIsConnected(userConnected: true)
        
        let navigateButton = app.buttons["NavigationLinkToDestination"]
        navigateButton.tap()
        
        let destinationText = app.staticTexts["Destination !"]
        XCTAssertTrue(destinationText.exists)
        
        let backButton = app.navigationBars.buttons["Welcome"]
        backButton.tap()
        
        checkUserIsConnected(userConnected: true)
    }
}

// MARK: - Logical Function

extension CleanTreeListUITests {
    func signUpAndSignIn(writeText: Bool) {
        let textfield = app.textFields["SignUpTextField"]
        
        textfield.tap()
        
        if(writeText) {
            let keyA = app/*@START_MENU_TOKEN@*/.keys["A"]/*[[".keyboards.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            keyA.tap()
            let keya = app.keys["a"]
            keya.tap()
        }
        
        let returnButton = app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"retour\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        returnButton.tap()
        
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
    }
    
    func checkUserIsConnected(userConnected: Bool) {
        let navBar = app.navigationBars["Welcome"]
        
        if(userConnected){
            XCTAssertTrue(navBar.exists)
        } else {
            XCTAssertFalse(navBar.exists)
        }
    }
}

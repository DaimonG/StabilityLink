//
//  PhysioSanity.swift
//  StabilityLink12UITests
//
//  Created by Alex Makasoff on 2019-11-18.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import XCTest

class PhysioSanityTest: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        app = XCUIApplication()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app.launchArguments.append("--uitesting")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testLoginButton() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        app.launch()
        XCUIApplication().buttons["Log In"].tap()
        
    }
    
    func testLoginSuccessful(){
        app.buttons["Log In"].tap()
        app.textFields["Email"].tap()
        
        
        let useremail = "test1@gmail.com"
        let userpassword = "abc123!!!"
        app.typeText(useremail)
        app.typeText("\n")
        app.textFields["Password"].tap()
        app.typeText(userpassword)
        app.buttons["Log In"].tap()
        
    }
    
    func testHomepageButton(){
        
    }
    
    func testViewPatients(){
        
    }
    
    func testAddPatient(){
        
    }
    
    func testDisplayPatientData(){
        
    }

}

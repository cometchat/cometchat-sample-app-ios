//
//  LoginTests.swift
//  CometChat KitchenSink UITests
//
//  Created by Pushpsen Airekar on 26/01/21.
//  Copyright © 2021 MacMini-03. All rights reserved.
//

import XCTest
import CometChatPro

class LoginTests : XCTestCase {

    
    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
      
        
    }
    
    func test1LoginWithSuperhero1() {

        let app = XCUIApplication()
        if app.navigationBars["CometChat Kitchen Sink"].exists {
            let tablesQuery = app.tables
            tablesQuery/*@START_MENU_TOKEN@*/.buttons["Groups"]/*[[".cells",".segmentedControls.buttons[\"Groups\"]",".buttons[\"Groups\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
            tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Logout"]/*[[".cells",".buttons[\"Logout\"].staticTexts[\"Logout\"]",".staticTexts[\"Logout\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.alerts["⚠️ Warning!"].scrollViews.otherElements.buttons["OK"].tap()
            app.staticTexts["superhero1"].tap()
            let unifiedScreen  = app.navigationBars["CometChat Kitchen Sink"]
            self.expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: unifiedScreen, handler: nil)
            self.waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(unifiedScreen.exists)
            
        }else{
            app.staticTexts["superhero1"].tap()
            let unifiedScreen  = app.navigationBars["CometChat Kitchen Sink"]
            self.expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: unifiedScreen, handler: nil)
            self.waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(unifiedScreen.exists)
        }
            
    }
    
    
    
    func test2LoginWithSuperhero2() {

        let app = XCUIApplication()
        if app.navigationBars["CometChat Kitchen Sink"].exists {
            let tablesQuery = app.tables
            tablesQuery/*@START_MENU_TOKEN@*/.buttons["Groups"]/*[[".cells",".segmentedControls.buttons[\"Groups\"]",".buttons[\"Groups\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
            tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Logout"]/*[[".cells",".buttons[\"Logout\"].staticTexts[\"Logout\"]",".staticTexts[\"Logout\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.alerts["⚠️ Warning!"].scrollViews.otherElements.buttons["OK"].tap()
            app.staticTexts["superhero2"].tap()
            let unifiedScreen  = app.navigationBars["CometChat Kitchen Sink"]
            self.expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: unifiedScreen, handler: nil)
            self.waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(unifiedScreen.exists)
        }else{
            app.staticTexts["superhero2"].tap()
            let unifiedScreen  = app.navigationBars["CometChat Kitchen Sink"]
            self.expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: unifiedScreen, handler: nil)
            self.waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(unifiedScreen.exists)
        }
    }
    
    func test3LoginWithSuperhero3() {

        let app = XCUIApplication()
        if app.navigationBars["CometChat Kitchen Sink"].exists {
            let tablesQuery = app.tables
            tablesQuery/*@START_MENU_TOKEN@*/.buttons["Groups"]/*[[".cells",".segmentedControls.buttons[\"Groups\"]",".buttons[\"Groups\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
            tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Logout"]/*[[".cells",".buttons[\"Logout\"].staticTexts[\"Logout\"]",".staticTexts[\"Logout\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.alerts["⚠️ Warning!"].scrollViews.otherElements.buttons["OK"].tap()
            app.staticTexts["superhero3"].tap()
            let unifiedScreen  = app.navigationBars["CometChat Kitchen Sink"]
            self.expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: unifiedScreen, handler: nil)
            self.waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(unifiedScreen.exists)
        }else{
            app.staticTexts["superhero3"].tap()
            let unifiedScreen  = app.navigationBars["CometChat Kitchen Sink"]
            self.expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: unifiedScreen, handler: nil)
            self.waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(unifiedScreen.exists)
        }
    }
    
    func test4LoginWithSuperhero4() {

        let app = XCUIApplication()
        if app.navigationBars["CometChat Kitchen Sink"].exists {
            let tablesQuery = app.tables
            tablesQuery/*@START_MENU_TOKEN@*/.buttons["Groups"]/*[[".cells",".segmentedControls.buttons[\"Groups\"]",".buttons[\"Groups\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
            tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Logout"]/*[[".cells",".buttons[\"Logout\"].staticTexts[\"Logout\"]",".staticTexts[\"Logout\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.alerts["⚠️ Warning!"].scrollViews.otherElements.buttons["OK"].tap()
            app.staticTexts["superhero3"].tap()
            let unifiedScreen  = app.navigationBars["CometChat Kitchen Sink"]
            self.expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: unifiedScreen, handler: nil)
            self.waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(unifiedScreen.exists)
        }else{
            app.staticTexts["superhero3"].tap()
            let unifiedScreen  = app.navigationBars["CometChat Kitchen Sink"]
            self.expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: unifiedScreen, handler: nil)
            self.waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(unifiedScreen.exists)
        }
    }
    
    
    func test5LoginWithEmptyUID() {

        let app = XCUIApplication()
        if app.navigationBars["CometChat Kitchen Sink"].exists {
            let tablesQuery = app.tables
            tablesQuery.buttons["Groups"].swipeUp()
            tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Logout"]/*[[".cells",".buttons[\"Logout\"].staticTexts[\"Logout\"]",".staticTexts[\"Logout\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.alerts["⚠️ Warning!"].scrollViews.otherElements.buttons["OK"].tap()
           
            let app = XCUIApplication()
            app.staticTexts["Login using UID"].tap()
            let enterUidHereTextField = app.textFields["Enter UID here"]
            enterUidHereTextField.tap()
            enterUidHereTextField.typeText("")
            app.buttons["Sign In"].tap()
            let loginWithUIDScreen  = app.navigationBars["Sign In"]
            self.expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: loginWithUIDScreen, handler: nil)
            self.waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(loginWithUIDScreen.exists)
        }else{
           
            let app = XCUIApplication()
            app/*@START_MENU_TOKEN@*/.staticTexts["Login using UID"]/*[[".buttons[\"Login using UID\"].staticTexts[\"Login using UID\"]",".staticTexts[\"Login using UID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            let enterUidHereTextField = app.textFields["Enter UID here"]
            enterUidHereTextField.tap()
            enterUidHereTextField.typeText("")
            app.buttons["Sign In"].tap()
            let loginWithUIDScreen  = app.navigationBars["Sign In"]
            self.expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: loginWithUIDScreen, handler: nil)
            self.waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(loginWithUIDScreen.exists)
        }
    }
    
    
    
    func test6LoginWithInValidUID() {

        let app = XCUIApplication()
        if app.navigationBars["CometChat Kitchen Sink"].exists {
            let tablesQuery = app.tables
            tablesQuery.buttons["Groups"].swipeUp()
            tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Logout"]/*[[".cells",".buttons[\"Logout\"].staticTexts[\"Logout\"]",".staticTexts[\"Logout\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.alerts["⚠️ Warning!"].scrollViews.otherElements.buttons["OK"].tap()
           
            let app = XCUIApplication()
            app.staticTexts["Login using UID"].tap()
            let enterUidHereTextField = app.textFields["Enter UID here"]
            enterUidHereTextField.tap()
            enterUidHereTextField.typeText("Invalid UID")
            app.buttons["Sign In"].tap()
            let loginWithUIDScreen  = app.navigationBars["Sign In"]
            self.expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: loginWithUIDScreen, handler: nil)
            self.waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(loginWithUIDScreen.exists)
        }else{
           
            let app = XCUIApplication()
            app/*@START_MENU_TOKEN@*/.staticTexts["Login using UID"]/*[[".buttons[\"Login using UID\"].staticTexts[\"Login using UID\"]",".staticTexts[\"Login using UID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            let enterUidHereTextField = app.textFields["Enter UID here"]
            enterUidHereTextField.tap()
            enterUidHereTextField.typeText("Invalid UID")
            app.buttons["Sign In"].tap()
            let loginWithUIDScreen  = app.navigationBars["Sign In"]
            self.expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: loginWithUIDScreen, handler: nil)
            self.waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(loginWithUIDScreen.exists)
        }
    }
    
    
    func test7LoginWithValidUID() {

        let app = XCUIApplication()
        if app.navigationBars["CometChat Kitchen Sink"].exists {
            let tablesQuery = app.tables
            tablesQuery/*@START_MENU_TOKEN@*/.buttons["Groups"]/*[[".cells",".segmentedControls.buttons[\"Groups\"]",".buttons[\"Groups\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
            tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Logout"]/*[[".cells",".buttons[\"Logout\"].staticTexts[\"Logout\"]",".staticTexts[\"Logout\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.alerts["⚠️ Warning!"].scrollViews.otherElements.buttons["OK"].tap()
           
            let app = XCUIApplication()
            app/*@START_MENU_TOKEN@*/.staticTexts["Login using UID"]/*[[".buttons[\"Login using UID\"].staticTexts[\"Login using UID\"]",".staticTexts[\"Login using UID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            let enterUidHereTextField = app.textFields["Enter UID here"]
            enterUidHereTextField.tap()
            enterUidHereTextField.typeText("superhero1")
            app.buttons["Sign In"].tap()
            let unifiedScreen  = app.navigationBars["CometChat Kitchen Sink"]
            self.expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: unifiedScreen, handler: nil)
            self.waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(unifiedScreen.exists)
        }else{
           
            let app = XCUIApplication()
            app/*@START_MENU_TOKEN@*/.staticTexts["Login using UID"]/*[[".buttons[\"Login using UID\"].staticTexts[\"Login using UID\"]",".staticTexts[\"Login using UID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            let enterUidHereTextField = app.textFields["Enter UID here"]
            enterUidHereTextField.tap()
            enterUidHereTextField.typeText("superhero1")
            app.buttons["Sign In"].tap()
            let unifiedScreen  = app.navigationBars["CometChat Kitchen Sink"]
            self.expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: unifiedScreen, handler: nil)
            self.waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(unifiedScreen.exists)
        }
    }
    
    
    
    
}

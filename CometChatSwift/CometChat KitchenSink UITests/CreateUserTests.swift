//
//  CreateUserTests.swift
//  CometChat KitchenSink UITests
//
//  Created by Pushpsen Airekar on 26/01/21.
//  Copyright © 2021 MacMini-03. All rights reserved.
//
import XCTest
import CometChatPro


class CreateUserTests : XCTestCase {

    
    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
      
        
    }
    
    func test1CreateUserWithEmptyUserName() {
        let app = XCUIApplication()
        if app.navigationBars["CometChat Kitchen Sink"].exists {
            let tablesQuery = app.tables
            tablesQuery.buttons["Groups"].swipeUp()
            tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Logout"]/*[[".cells",".buttons[\"Logout\"].staticTexts[\"Logout\"]",".staticTexts[\"Logout\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.alerts["⚠️ Warning!"].scrollViews.otherElements.buttons["OK"].tap()
            app/*@START_MENU_TOKEN@*/.staticTexts["Don't have an Account? Sign Up"]/*[[".buttons[\"Don't have an Account? Sign Up\"].staticTexts[\"Don't have an Account? Sign Up\"]",".staticTexts[\"Don't have an Account? Sign Up\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.textFields["Enter your name here"].tap()
            app.buttons["Submit"].tap()
            XCTAssertTrue(app.alerts["Warning!"].scrollViews.otherElements.staticTexts["Name cannot be empty"].exists)
            
        }else{
            app/*@START_MENU_TOKEN@*/.staticTexts["Don't have an Account? Sign Up"]/*[[".buttons[\"Don't have an Account? Sign Up\"].staticTexts[\"Don't have an Account? Sign Up\"]",".staticTexts[\"Don't have an Account? Sign Up\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.textFields["Enter your name here"].tap()
            app.buttons["Submit"].tap()
            XCTAssertTrue(app.alerts["Warning!"].scrollViews.otherElements.staticTexts["Name cannot be empty"].exists)
        }
    }
    
    
    
    func test1CreateUserWithValidUserName() {
        let app = XCUIApplication()
        if app.navigationBars["CometChat Kitchen Sink"].exists {
            let tablesQuery = app.tables
            tablesQuery.buttons["Groups"].swipeUp()
            tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Logout"]/*[[".cells",".buttons[\"Logout\"].staticTexts[\"Logout\"]",".staticTexts[\"Logout\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.alerts["⚠️ Warning!"].scrollViews.otherElements.buttons["OK"].tap()
            app/*@START_MENU_TOKEN@*/.staticTexts["Don't have an Account? Sign Up"]/*[[".buttons[\"Don't have an Account? Sign Up\"].staticTexts[\"Don't have an Account? Sign Up\"]",".staticTexts[\"Don't have an Account? Sign Up\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.textFields["Enter your name here"].tap()
            app.textFields["Enter your name here"].typeText("TestUser1")
            app.buttons["Submit"].tap()
            let unifiedScreen  = app.navigationBars["CometChat Kitchen Sink"]
            self.expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: unifiedScreen, handler: nil)
            self.waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(unifiedScreen.exists)
            
        }else{
            app/*@START_MENU_TOKEN@*/.staticTexts["Don't have an Account? Sign Up"]/*[[".buttons[\"Don't have an Account? Sign Up\"].staticTexts[\"Don't have an Account? Sign Up\"]",".staticTexts[\"Don't have an Account? Sign Up\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.textFields["Enter your name here"].tap()
            app.textFields["Enter your name here"].typeText("TestUser")
            app.buttons["Submit"].tap()
            let unifiedScreen  = app.navigationBars["CometChat Kitchen Sink"]
            self.expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: unifiedScreen, handler: nil)
            self.waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(unifiedScreen.exists)
        }
        
    }
    
    func test1CreateUserWithValidUserNameAndSpace() {
        let app = XCUIApplication()
        if app.navigationBars["CometChat Kitchen Sink"].exists {
            let tablesQuery = app.tables
            tablesQuery.buttons["Groups"].swipeUp()
            tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Logout"]/*[[".cells",".buttons[\"Logout\"].staticTexts[\"Logout\"]",".staticTexts[\"Logout\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.alerts["⚠️ Warning!"].scrollViews.otherElements.buttons["OK"].tap()
            app/*@START_MENU_TOKEN@*/.staticTexts["Don't have an Account? Sign Up"]/*[[".buttons[\"Don't have an Account? Sign Up\"].staticTexts[\"Don't have an Account? Sign Up\"]",".staticTexts[\"Don't have an Account? Sign Up\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.textFields["Enter your name here"].tap()
            app.textFields["Enter your name here"].typeText("Test User ")
            app.buttons["Submit"].tap()
            let unifiedScreen  = app.navigationBars["CometChat Kitchen Sink"]
            self.expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: unifiedScreen, handler: nil)
            self.waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(unifiedScreen.exists)
            
        }else{
            app/*@START_MENU_TOKEN@*/.staticTexts["Don't have an Account? Sign Up"]/*[[".buttons[\"Don't have an Account? Sign Up\"].staticTexts[\"Don't have an Account? Sign Up\"]",".staticTexts[\"Don't have an Account? Sign Up\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            app.textFields["Enter your name here"].tap()
            app.textFields["Enter your name here"].typeText("Test User")
            
            let app = XCUIApplication()
            let enterYourNameHereTextField = app.textFields["Enter your name here"]
            enterYourNameHereTextField.tap()
            enterYourNameHereTextField.tap()
            enterYourNameHereTextField.tap()
            enterYourNameHereTextField.tap()
            app.buttons["Submit"].tap()
            
            let unifiedScreen  = app.navigationBars["CometChat Kitchen Sink"]
            self.expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: unifiedScreen, handler: nil)
            self.waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(unifiedScreen.exists)
        }
    }
    
}

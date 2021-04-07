//
//  CreateUserTests.swift
//  CometChat KitchenSink UITests
//
//  Created by Pushpsen Airekar on 26/01/21.
//  Copyright © 2021 MacMini-03. All rights reserved.
//
import XCTest
import CometChatPro
import CometChat_KitchenSink

class CometChatUITests : XCTestCase {

    
    override func setUpWithError() throws {
        continueAfterFailure = false
       
        let app = XCUIApplication()
        app.launch()
        if app.navigationBars["CometChat Kitchen Sink"].exists {
        
        }else{
            app.staticTexts["superhero1"].tap()
            let unifiedScreen  = app.navigationBars["CometChat Kitchen Sink"]
        }
       
    }

    override func tearDownWithError() throws {
      
        
    }
    
    func test1LaunchCometChatUIWithFullScreen() {
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Fullscreen"]/*[[".cells",".segmentedControls.buttons[\"Fullscreen\"]",".buttons[\"Fullscreen\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"CometChat UI")/*[[".cells.containing(.staticText, identifier:\"It open's Activity directly from UI Library. It is pre-defined UI helpful for user to build chat system by integrating it within minutes.\")",".cells.containing(.staticText, identifier:\"CometChat UI\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Launch"].tap()
        XCTAssertTrue(XCUIApplication().tabBars["Tab Bar"].exists)
    }
    
    func test2LaunchCometChatUIWithPopOver() {
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.segmentedControls.containing(.button, identifier:"Fullscreen")/*[[".cells.segmentedControls.containing(.button, identifier:\"Fullscreen\")",".segmentedControls.containing(.button, identifier:\"Fullscreen\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Popover"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"CometChat UI")/*[[".cells.containing(.staticText, identifier:\"It open's Activity directly from UI Library. It is pre-defined UI helpful for user to build chat system by integrating it within minutes.\")",".cells.containing(.staticText, identifier:\"CometChat UI\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Launch"].tap()
        XCTAssertTrue(XCUIApplication().tabBars["Tab Bar"].exists)
    }
    
    func test3CheckAllTabsArePresents() {
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"CometChat UI").staticTexts["Launch"]/*[[".cells.containing(.staticText, identifier:\"It open's Activity directly from UI Library. It is pre-defined UI helpful for user to build chat system by integrating it within minutes.\")",".buttons[\"Launch\"].staticTexts[\"Launch\"]",".staticTexts[\"Launch\"]",".cells.containing(.staticText, identifier:\"CometChat UI\")"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssertTrue(tabBar.buttons["Chats"].exists)
        XCTAssertTrue(tabBar.buttons["Calls"].exists)
        XCTAssertTrue(tabBar.buttons["Users"].exists)
        XCTAssertTrue(tabBar.buttons["Groups"].exists)
        XCTAssertTrue(tabBar.buttons["More"].exists)
    }
    
    func test4CheckAllTabsClickable() {
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"CometChat UI").staticTexts["Launch"]/*[[".cells.containing(.staticText, identifier:\"It open's Activity directly from UI Library. It is pre-defined UI helpful for user to build chat system by integrating it within minutes.\")",".buttons[\"Launch\"].staticTexts[\"Launch\"]",".staticTexts[\"Launch\"]",".cells.containing(.staticText, identifier:\"CometChat UI\")"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Chats"].tap()
        tabBar.buttons["Calls"].tap()
        tabBar.buttons["Users"].tap()
        tabBar.buttons["Groups"].tap()
        tabBar.buttons["More"].tap()
        tabBar.buttons["Groups"].tap()
        tabBar.buttons["Users"].tap()
        tabBar.buttons["Calls"].tap()
        tabBar.buttons["Chats"].tap()
    }
    
    
}

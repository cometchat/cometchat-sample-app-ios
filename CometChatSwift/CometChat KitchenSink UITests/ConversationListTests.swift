//
//  ConversationListTests.swift
//  CometChat KitchenSink UITests
//
//  Created by Pushpsen Airekar on 11/02/21.
//  Copyright © 2021 MacMini-03. All rights reserved.
//

import XCTest
import CometChatPro
import CometChat_KitchenSink

class ConversationListTests : XCTestCase {

    
    override func setUpWithError() throws {
        continueAfterFailure = false
       
        let app = XCUIApplication()
        app.launch()
        if app.navigationBars["CometChat Kitchen Sink"].exists {
        
        }else{
            app.staticTexts["superhero1"].tap()
        }
       
    }

    override func tearDownWithError() throws {
      
        
    }
    
    func test1LaunchConversationListWithFullScreen() {

        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Chats"]/*[[".cells",".segmentedControls.buttons[\"Chats\"]",".buttons[\"Chats\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["FullScreen"]/*[[".cells",".segmentedControls.buttons[\"FullScreen\"]",".buttons[\"FullScreen\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let uiComponentsCellsQuery = tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"UI Components")/*[[".cells.containing(.staticText, identifier:\"It open's Screen Activity where user can use predefined screen present in library. User can create their own layout using screen in few minutes.\")",".cells.containing(.staticText, identifier:\"UI Components\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        uiComponentsCellsQuery.buttons["Launch"].swipeUp()
        uiComponentsCellsQuery/*@START_MENU_TOKEN@*/.staticTexts["Launch"]/*[[".buttons[\"Launch\"].staticTexts[\"Launch\"]",".staticTexts[\"Launch\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(XCUIApplication().navigationBars["Chats"].exists)
    }
    
    func test2LaunchConversationListWithPopOver() {
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Chats"]/*[[".cells",".segmentedControls.buttons[\"Chats\"]",".buttons[\"Chats\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.segmentedControls.containing(.button, identifier:"FullScreen")/*[[".cells.segmentedControls.containing(.button, identifier:\"FullScreen\")",".segmentedControls.containing(.button, identifier:\"FullScreen\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Popover"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"UI Components").staticTexts["Launch"]/*[[".cells.containing(.staticText, identifier:\"It open's Screen Activity where user can use predefined screen present in library. User can create their own layout using screen in few minutes.\")",".buttons[\"Launch\"].staticTexts[\"Launch\"]",".staticTexts[\"Launch\"]",".cells.containing(.staticText, identifier:\"UI Components\")"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(XCUIApplication().navigationBars["Chats"].exists)
               
    }
    
    func test3CheckNavigationBarTitleIsPresent() {
      
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Chats"]/*[[".cells",".segmentedControls.buttons[\"Chats\"]",".buttons[\"Chats\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["FullScreen"]/*[[".cells",".segmentedControls.buttons[\"FullScreen\"]",".buttons[\"FullScreen\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let uiComponentsCellsQuery = tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"UI Components")/*[[".cells.containing(.staticText, identifier:\"It open's Screen Activity where user can use predefined screen present in library. User can create their own layout using screen in few minutes.\")",".cells.containing(.staticText, identifier:\"UI Components\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        uiComponentsCellsQuery.buttons["Launch"].swipeUp()
        uiComponentsCellsQuery/*@START_MENU_TOKEN@*/.staticTexts["Launch"]/*[[".buttons[\"Launch\"].staticTexts[\"Launch\"]",".staticTexts[\"Launch\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(XCUIApplication().navigationBars["Chats"].staticTexts["Chats"].exists)
    }
    
    func test4CheckSearchbarIsPresent() {
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Chats"]/*[[".cells",".segmentedControls.buttons[\"Chats\"]",".buttons[\"Chats\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["FullScreen"]/*[[".cells",".segmentedControls.buttons[\"FullScreen\"]",".buttons[\"FullScreen\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let uiComponentsCellsQuery = tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"UI Components")/*[[".cells.containing(.staticText, identifier:\"It open's Screen Activity where user can use predefined screen present in library. User can create their own layout using screen in few minutes.\")",".cells.containing(.staticText, identifier:\"UI Components\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        uiComponentsCellsQuery.buttons["Launch"].swipeUp()
        uiComponentsCellsQuery/*@START_MENU_TOKEN@*/.staticTexts["Launch"]/*[[".buttons[\"Launch\"].staticTexts[\"Launch\"]",".staticTexts[\"Launch\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let chatsNavigationBar = XCUIApplication().navigationBars["Chats"]
        XCTAssertTrue(chatsNavigationBar.searchFields["Search"].exists)
    }
    
    func test5CheckSearchbarIsClickable() {
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Chats"]/*[[".cells",".segmentedControls.buttons[\"Chats\"]",".buttons[\"Chats\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["FullScreen"]/*[[".cells",".segmentedControls.buttons[\"FullScreen\"]",".buttons[\"FullScreen\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let uiComponentsCellsQuery = tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"UI Components")/*[[".cells.containing(.staticText, identifier:\"It open's Screen Activity where user can use predefined screen present in library. User can create their own layout using screen in few minutes.\")",".cells.containing(.staticText, identifier:\"UI Components\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        uiComponentsCellsQuery.buttons["Launch"].swipeUp()
        uiComponentsCellsQuery/*@START_MENU_TOKEN@*/.staticTexts["Launch"]/*[[".buttons[\"Launch\"].staticTexts[\"Launch\"]",".staticTexts[\"Launch\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let chatsNavigationBar = XCUIApplication().navigationBars["Chats"]
        XCTAssertTrue(chatsNavigationBar.searchFields["Search"].isHittable)
    }

    func test6CheckKeyboardAppreanceWhenTappedOnSearchBar() {
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Chats"]/*[[".cells",".segmentedControls.buttons[\"Chats\"]",".buttons[\"Chats\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["FullScreen"]/*[[".cells",".segmentedControls.buttons[\"FullScreen\"]",".buttons[\"FullScreen\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let uiComponentsCellsQuery = tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"UI Components")/*[[".cells.containing(.staticText, identifier:\"It open's Screen Activity where user can use predefined screen present in library. User can create their own layout using screen in few minutes.\")",".cells.containing(.staticText, identifier:\"UI Components\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        uiComponentsCellsQuery.buttons["Launch"].swipeUp()
        uiComponentsCellsQuery/*@START_MENU_TOKEN@*/.staticTexts["Launch"]/*[[".buttons[\"Launch\"].staticTexts[\"Launch\"]",".staticTexts[\"Launch\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIApplication().navigationBars["Chats"].searchFields["Search"].tap()
        XCTAssert(XCUIApplication().keyboards.count > 0, "The keyboard is not shown")
        
//        let chatsNavigationBar = XCUIApplication().navigationBars["Chats"]
//
//        let app = XCUIApplication()
//        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"UI Components").staticTexts["Launch"]/*[[".cells.containing(.staticText, identifier:\"It open's Screen Activity where user can use predefined screen present in library. User can create their own layout using screen in few minutes.\")",".buttons[\"Launch\"].staticTexts[\"Launch\"]",".staticTexts[\"Launch\"]",".cells.containing(.staticText, identifier:\"UI Components\")"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
//        app.navigationBars["Chats"].searchFields["Search"].tap()
//        app.children(matching: .window).element(boundBy: 2).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 2).tap()
        
    }
    
    func test7CheckSerchbarCancelButtonIsClickable() {
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Chats"]/*[[".cells",".segmentedControls.buttons[\"Chats\"]",".buttons[\"Chats\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["FullScreen"]/*[[".cells",".segmentedControls.buttons[\"FullScreen\"]",".buttons[\"FullScreen\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let uiComponentsCellsQuery = tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"UI Components")/*[[".cells.containing(.staticText, identifier:\"It open's Screen Activity where user can use predefined screen present in library. User can create their own layout using screen in few minutes.\")",".cells.containing(.staticText, identifier:\"UI Components\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        uiComponentsCellsQuery.buttons["Launch"].swipeUp()
        uiComponentsCellsQuery/*@START_MENU_TOKEN@*/.staticTexts["Launch"]/*[[".buttons[\"Launch\"].staticTexts[\"Launch\"]",".staticTexts[\"Launch\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let chatsNavigationBar = XCUIApplication().navigationBars["Chats"]
        chatsNavigationBar.searchFields["Search"].tap()
        XCTAssertTrue(chatsNavigationBar.buttons["Cancel"].isHittable)
    }
    
    func test8CheckKeyboardAppreanceWhenTappedOnCancelButton() {
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Chats"]/*[[".cells",".segmentedControls.buttons[\"Chats\"]",".buttons[\"Chats\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["FullScreen"]/*[[".cells",".segmentedControls.buttons[\"FullScreen\"]",".buttons[\"FullScreen\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let uiComponentsCellsQuery = tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"UI Components")/*[[".cells.containing(.staticText, identifier:\"It open's Screen Activity where user can use predefined screen present in library. User can create their own layout using screen in few minutes.\")",".cells.containing(.staticText, identifier:\"UI Components\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        uiComponentsCellsQuery.buttons["Launch"].swipeUp()
        uiComponentsCellsQuery/*@START_MENU_TOKEN@*/.staticTexts["Launch"]/*[[".buttons[\"Launch\"].staticTexts[\"Launch\"]",".staticTexts[\"Launch\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let chatsNavigationBar = XCUIApplication().navigationBars["Chats"]
        chatsNavigationBar.searchFields["Search"].tap()
        chatsNavigationBar.buttons["Cancel"].tap()
        XCTAssert(XCUIApplication().keyboards.count == 0, "The keyboard is still showing")
    }
    
    func test9NavigationFromConversationToMessages() {
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"UI Components").staticTexts["Launch"]/*[[".cells.containing(.staticText, identifier:\"It open's Screen Activity where user can use predefined screen present in library. User can create their own layout using screen in few minutes.\")",".buttons[\"Launch\"].staticTexts[\"Launch\"]",".staticTexts[\"Launch\"]",".cells.containing(.staticText, identifier:\"UI Components\")"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        let converationView  = tablesQuery.cells.containing(.cell, identifier:"CometChatConversationListItem").element
        self.expectation(for: NSPredicate(format: "exists > 0"), evaluatedWith: converationView, handler: nil)
        self.waitForExpectations(timeout: 5, handler: nil)
        converationView.tap()
       
    }
    
    func test10() {
      
    }
}


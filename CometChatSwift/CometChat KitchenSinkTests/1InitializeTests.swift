//
//  CometChatInitializeTests.swift
//  CometChatProTests
//
//  Created by Inscripts11 on 18/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

import XCTest
import CometChatPro

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////// COMETCHATPRO: INIT() TEST CASES  /////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class CometChat1InitializeTests: XCTestCase {
    
    
    //1. CometChat.init() method without appID
    func test001CometChatInitWithEmptyAPPID() {
        
        //Creating an Expectation
        let expectation = self.expectation(description: "Testing Init of SDK with out APPID")
        var isInitializeSuccessful = false
        
      let appSettings = AppSettings.AppSettingsBuilder().subscribePresenceForAllUsers().setRegion(region:"us-green").build()
        
        CometChat.init(appId: "", appSettings: appSettings, onSuccess: { (Success) in
            isInitializeSuccessful = Success
         
            print("CometChatInitWithValidAPPID  onSuccess \(Success)")

        }) { (error) in
            print("CometChatInitWithValidAPPID error: \(error.errorDescription)")
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test002CometChatInitWithInValidAPPID() {
        
        //Creating an Expectation
        let expectation = self.expectation(description: "Testing Init of SDK with Invalid APPID")
        var isInitializeSuccessful = false

        let appSettings = AppSettings.AppSettingsBuilder().subscribePresenceForAllUsers().setRegion(region:"us-green").build()
        
        CometChat.init(appId: "Invalid", appSettings: appSettings, onSuccess: { (Success) in
            isInitializeSuccessful = Success
            XCTAssertTrue(isInitializeSuccessful)
            print("CometChatInitWithValidAPPID  onSuccess \(Success)")
            expectation.fulfill()
        }) { (error) in
            print("CometChatInitWithValidAPPID error: \(error.errorDescription)")
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test003CometChatInitWithEmptyRegion() {
        
        //Creating an Expectation
        let expectation = self.expectation(description: "Testing Init of SDK with Empty Region")
        var isInitializeSuccessful = false

        let appSettings = AppSettings.AppSettingsBuilder().subscribePresenceForAllUsers().setRegion(region:"").build()
        
        CometChat.init(appId: "Invalid", appSettings: appSettings, onSuccess: { (Success) in
            isInitializeSuccessful = Success
            XCTAssertTrue(isInitializeSuccessful)
            print("CometChatInitWithValidAPPID  onSuccess \(Success)")
            
        }) { (error) in
            print("CometChatInitWithValidAPPID error: \(error.errorDescription)")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    //2. CometChat.init() method with valid appID
    func test004CometChatInitWithValidAPPID() {
        
        //Creating an Expectation
        let expectation = self.expectation(description: "Testing Init of SDK with APPID")
        var isInitializeSuccessful = false

        let appSettings = AppSettings.AppSettingsBuilder().subscribePresenceForAllUsers().setRegion(region:"us-green").build()
        
        CometChat.init(appId: TestConstants.appId, appSettings: appSettings, onSuccess: { (Success) in
            isInitializeSuccessful = Success
            XCTAssertTrue(isInitializeSuccessful)
            print("CometChatInitWithValidAPPID  onSuccess \(Success)")
            expectation.fulfill()
        }) { (error) in
            print("CometChatInitWithValidAPPID error: \(error.errorDescription)")
        }
        
        wait(for: [expectation], timeout: 10)
    }

}

//
//  CometChatAuthenticationTests.swift
//  CometChatProTests
//
//  Created by Inscripts11 on 18/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

import XCTest
import CometChatPro

////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////  COMETCHATPRO: LOGIN(), LOGOUT() TEST CASES   //////////////////////
////////////////////////////////////////////////////////////////////////////////////////////


class CometChat2AuthenticationTests: XCTestCase {


    
///////////////////////////////// COMETCHATPRO:  LOGIN(uid:) ///////////////////////////////
    
    
    //2. login() method without UID and without ApiKey
    func test001LoginWithEmptyUIDEmptyAPIKey() {
        
        //Creating an Expectation
        let expectation = self.expectation(description: "test001LoginWithEmptyUIDEmptyAPIKey")
        var _user : User?
        CometChat.login(UID: "", apiKey: "", onSuccess: { (user) in
            _user = user
            print("loginWithoutUIDAndAPIKey successful. \(user.stringValue())")
        }) { (error) in
            print("loginWithoutUIDAndAPIKey error : \(error.errorDescription)")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
     //3. login() method with UID and empty ApiKey
    func test002LoginWithUIDAndEmptyAPIKey() {
        
        //Creating an Expectation
        let expectation = self.expectation(description: "test002LoginWithUIDAndEmptyAPIKey")
        
        var _user : User?
        
        CometChat.login(UID: TestConstants.user1, apiKey: "", onSuccess: { (user) in
            
            _user = user
            print("loginWithUIDAndEmptyAPIKey successful. \(user.stringValue())")
            
        }) { (error) in
            
            print("loginWithUIDAndEmptyAPIKey error : \(error.errorDescription)")

            XCTAssertNil(_user)

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
     //4. login() method with empty UID and valid ApiKey
    func test003LoginWithEmptyUIDAndValidAPIKey() {
        
        //Creating an Expectation
        let expectation = self.expectation(description: "test003LoginWithEmptyUIDAndValidAPIKey")
        
        var _user : User?
        
        CometChat.login(UID: "", apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            _user = user
            print("loginWithEmptyUIDAndValidAPIKey successful. \(user.stringValue())")
            
        }) { (error) in
            
            print("loginWithEmptyUIDAndValidAPIKey error : \(error.errorDescription)")

            XCTAssertNil(_user)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    //5. login() method with InvalidUID UID and valid ApiKey
    func test004LoginWithInvalidUIDAndValidAPIKey() {
        
        //Creating an Expectation
        let expectation = self.expectation(description: "test004LoginWithInvalidUIDAndValidAPIKey")
        CometChat.login(UID: "InvalidUID", apiKey: TestConstants.apiKey, onSuccess: { (user) in
            print("loginWithInvalidUIDAndValidAPIKey successful.")
        }) { (error) in
            print("loginWithInvalidUIDAndValidAPIKey error : \(error.errorDescription)")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
     //6. login() method with valid UID and Invalid ApiKey
    func test005LoginWithValidUIDAndInvalidAPIKey() {
        
        //Creating an Expectation
        let expectation = self.expectation(description: "test005LoginWithValidUIDAndInvalidAPIKey")
        
        var _user : User?
        
        CometChat.login(UID: TestConstants.user1, apiKey: "Invalid API Key", onSuccess: { (user) in
            
            _user = user
            print("loginWithValidUIDAndInvalidAPIKey successful.")
            
        }) { (error) in
            
            print("loginWithValidUIDAndInvalidAPIKey error : \(error.errorDescription)")

            XCTAssertNil(_user)

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
//7. login() method with Invalid UID and Invalid ApiKey
    func test006LoginInvalidUIDAndInvalidAPIKey() {
        
        //Creating an Expectation
        let expectation = self.expectation(description: "test006LoginInvalidUIDAndInvalidAPIKey")
        
        var _user : User?
        
        CometChat.login(UID: "Invalid UID", apiKey: "Invalid API Key", onSuccess: { (user) in
            
            _user = user
            print("loginInvalidUIDAndInvalidAPIKey successful.")
            
        }) { (error) in
            
            print("loginInvalidUIDAndInvalidAPIKey error : \(error.errorDescription)")

            XCTAssertNil(_user)

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test007LoginWithEmptyUIDAndInvalidAPIKey() {
        
        //Creating an Expectation
        let expectation = self.expectation(description: "test007LoginWithEmptyUIDAndInvalidAPIKey")
        
        CometChat.login(UID: "", apiKey: "Invalid", onSuccess: { (user) in
            
            userIsValid(user: user)
            print("loginWithValidUIDAndValidAPIKey successful. \(user.stringValue())")
            XCTAssertNotNil(user)
            
            
        }) { (error) in
            print("loginWithValidUIDAndValidAPIKey error : \(error.errorDescription)")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test008LoginWithInvalidUIDAndEmptyAPIKey() {
        
        //Creating an Expectation
        let expectation = self.expectation(description: "test008LoginWithInvalidUIDAndEmptyAPIKey")
        
        CometChat.login(UID: "Invalid", apiKey: "", onSuccess: { (user) in
            
            userIsValid(user: user)
            print("loginWithValidUIDAndValidAPIKey successful. \(user.stringValue())")
            XCTAssertNotNil(user)
            
            
        }) { (error) in
            print("loginWithValidUIDAndValidAPIKey error : \(error.errorDescription)")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

    
////////////////////////////////////////////////////////////////////////////////////////////
    
/////////////////////////////  COMETCHATPRO:  LOGIN(authToken:)   //////////////////////////
    
    //9. login() method with wmpty authToken
    func test009LoginWithEmptyAuthtoken() {

        //Creating an Expectation
        let expectation = self.expectation(description: "test009LoginWithEmptyAuthtoken")
        var _user : User?

        CometChat.login(authToken: "", onSuccess: { (user) in
            _user = user
            print("loginWithEmptyAuthtoken Successful...")

        }) { (error) in
            print("loginWithEmptyAuthtoken error : \(error.errorDescription)")
            XCTAssertNil(_user)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

    func test011LoginWithValidAuthtoken() {

        //Creating an Expectation
        let expectation = self.expectation(description: "test011LoginWithValidAuthtoken")

        var _user : User?
        let appSettings = AppSettings.AppSettingsBuilder().subscribePresenceForAllUsers().setRegion(region:"us").build()

        CometChat.init(appId: TestConstants.appId, appSettings: appSettings, onSuccess: { (success) in
                CometChat.login(authToken: TestConstants.authtokenUser1, onSuccess: { (user) in

                    _user = user
                    
                    print("loginWithValidAuthtoken Successful...")

                    XCTAssertNotNil(_user)

                    expectation.fulfill()
                    
                }) { (error) in

                    print("loginWithValidAuthtoken error: \(error.errorDescription)")
                }
            }) { (error) in
                print("CometChatInitWithValidAPPID error: \(error.errorDescription)")
            }

        wait(for: [expectation], timeout: 60)
    }
    
    func test012Logout() {
        
        let expectation = self.expectation(description: "test012Logout")

        CometChat.logout(onSuccess: { (isSuccess) in

            print("logout successful \(isSuccess)")

            XCTAssertEqual(isSuccess, "User logged out successfully.", "Logged out successful")

            expectation.fulfill()

        }) { (error) in

            print("logout error : \(String(describing: error.errorDescription))")
        }

        wait(for: [expectation], timeout: 10)
    }
    
    func test013CometChatInitWithValidAPPID() {
        
        //Creating an Expectation
        let expectation = self.expectation(description: "test013CometChatInitWithValidAPPID")
        var isInitializeSuccessful = false

        let appSettings = AppSettings.AppSettingsBuilder().subscribePresenceForAllUsers().setRegion(region:"us").build()
        
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
    
    //9. login() method with valid authToken
    
    func test014LoginWithValidUIDAndValidAPIKey() {
                
                //Creating an Expectation
        let expectation = self.expectation(description: "Testing Login with valid UID and valid APIKey")
        
        CometChat.login(UID: "superhero1", apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            userIsValid(user: user)
            print("test014LoginWithValidUIDAndValidAPIKey successful. \(user.stringValue())")
            
            //Uncomment the below block to initialise the setup
//                initialSetup { (mybool) in
//
//                    XCTAssertNotNil(user)
//                    expectation.fulfill()
//                }
            
            XCTAssertNotNil(user)
            expectation.fulfill()
            
        }) { (error) in
            print("test014LoginWithValidUIDAndValidAPIKey error : \(error.errorDescription)")
        }
        wait(for: [expectation], timeout: 100)
    }
    
}

////////////////////////////////////////////////////////////////////////////////////////////

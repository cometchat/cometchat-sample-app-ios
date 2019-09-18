//
//  CometChatAuthenticationTests.swift
//  CometChatProTests
//
//  Created by Inscripts11 on 18/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

import XCTest
@testable import CometChatPro

////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////  COMETCHATPRO: LOGIN(), LOGOUT() TEST CASES   //////////////////////
////////////////////////////////////////////////////////////////////////////////////////////


class CometChat2AuthenticationTests: XCTestCase {


    
///////////////////////////////// COMETCHATPRO:  LOGIN(uid:) ///////////////////////////////
    
    
    //2. login() method without UID and without ApiKey
    func test001LoginWithEmptyUIDEmptyAPIKey() {
        
        //Creating an Expectation
        let expectation = self.expectation(description: "Testing Login without UID and APIKey")
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
        let expectation = self.expectation(description: "Testing Login with UID and empty APIKey")
        
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
        let expectation = self.expectation(description: "Testing Login with empty UID and valid APIKey")
        
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
        let expectation = self.expectation(description: "Testing Login with invalid UID and valid APIKey")
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
        let expectation = self.expectation(description: "Testing Login with valid UID and invalid APIKey")
        
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
        let expectation = self.expectation(description: "Testing Login with invalid UID and invalid APIKey")
        
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
    
    //8. login() method with valid UID and valid ApiKey
    func test007LoginWithValidUIDAndValidAPIKey() {
        
        //Creating an Expectation
        let expectation = self.expectation(description: "Testing Login with valid UID and valid APIKey")
        
        CometChat.login(UID: TestConstants.user1, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            print("loginWithValidUIDAndValidAPIKey successful. \(user.stringValue())")
            XCTAssertNotNil(user)
            expectation.fulfill()
        }) { (error) in
            print("loginWithValidUIDAndValidAPIKey error : \(error.errorDescription)")
        }
        wait(for: [expectation], timeout: 20)
    }

    
////////////////////////////////////////////////////////////////////////////////////////////
    
/////////////////////////////  COMETCHATPRO:  LOGIN(authToken:)   //////////////////////////
    
    //9. login() method with wmpty authToken
    func test008LoginWithEmptyAuthtoken() {
        
        //Creating an Expectation
        let expectation = self.expectation(description: "Testing Login with empty Authtoken")
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
    
    //9. login() method with invalid authToken
    func test009LoginWithInvalidAuthtoken() {
        
        //Creating an Expectation
        let expectation = self.expectation(description: "Testing Login with invalid Authtoken")
        CometChat.login(authToken: "123456789101112131415116", onSuccess: { (user) in
            print("loginWithInvalidAuthtoken Successful...")
            
        }) { (error) in
            
            print("loginWithInvalidAuthtoken error : \(error.errorDescription)")
            XCTAssertEqual(error.errorDescription, "The auth token 123456789101112131415116 does not exist. Please make sure you are logged in and have a valid auth token or try login again.", "The auth token 123456789101112131415116 does not exist. Please make sure you are logged in and have a valid auth token or try login again.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //9. login() method with valid authToken
    func test010LoginWithValidAuthtoken() {
        
//        //Creating an Expectation
//        let expectation = self.expectation(description: "Testing Login with valid Authtoken")
//
//        var _user : User?
//
//        CometChat.login(authToken: TestConstants.authtokenUser1, onSuccess: { (user) in
//
//            _user = user
//
//            print("loginWithValidAuthtoken Successful...")
//
//            XCTAssertNotNil(_user)
//
//            expectation.fulfill()
//
//        }) { (error) in
//
//            print("loginWithValidAuthtoken error: \(error.errorDescription)")
//        }
//
//        wait(for: [expectation], timeout: 10)
        
    }
}


////////////////////////////////////////////////////////////////////////////////////////////

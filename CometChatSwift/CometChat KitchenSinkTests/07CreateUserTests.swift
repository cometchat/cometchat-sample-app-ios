//
//  CreateUser.swift
//  CometChatPro-swift-sampleAppTests
//
//  Created by Jeet Kapadia on 26/03/20.
//  Copyright © 2020 Admin1. All rights reserved.
//

import XCTest
import CometChatPro

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////  COMETCHATPRO: CREATE USER TEST CASES   /////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

class CometChat7CreateUserTests: XCTestCase {
    
    func test001CreateUserWithValidParams() {
        
        let expectation = self.expectation(description: "Create user with valid params")
        
        let user : User = User(uid: "DCSuperHero100", name: "Batman")
        
        CometChat.createUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: false, ismetaData: false, islink: false, isStatusMessage: false, isRole: false)
            
            print("test001CreateUserWithValidParams onSuccess: \(user)")
            expectation.fulfill()
            
        }) { (error) in
            
            print("test001CreateUserWithValidParams failed: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test002CreateUserWithValidEmptyAPIKey() {
        
        let expectation = self.expectation(description: "Create user with empty API Key")
        
        let user : User = User(uid: "DCSuperHero2", name: "Batman")
        
        CometChat.createUser(user: user, apiKey: "", onSuccess: { (user) in
            
            validateUserList(user: [user], isRole: false)
            
            print("test002CreateUserWithValidEmptyAPIKey onSuccess: \(user)")
            
            
        }) { (error) in
            
            print("test002CreateUserWithValidEmptyAPIKey failed: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test003CreateUserWithValidEmptyUID() {
        
        let expectation = self.expectation(description: "Create user with empty UID")
        
        let user : User = User(uid: "", name: "Batman")
        
        CometChat.createUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validateUserList(user: [user], isRole: false)
            
            print("test003CreateUserWithValidEmptyUID onSuccess: \(user)")
            
            
        }) { (error) in
            
            print("test003CreateUserWithValidEmptyUID failed: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test004CreateUserWithValidAvatar() {
        
        let expectation = self.expectation(description: "Create user with valid Avatar")
        
        let user : User = User(uid: "DCSuperHero3", name: "Batman")
        user.avatar = "https://image.shutterstock.com/image-photo/kiev-ukraine-april-16-2015-600w-276697244.jpg"
        CometChat.createUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: true, ismetaData: false, islink: false, isStatusMessage: false, isRole: false)
            
            print("test004CreateUserWithValidAvatar onSuccess: \(user)")
            expectation.fulfill()
            
        }) { (error) in
            
            print("test004CreateUserWithValidAvatar failed: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test005CreateUserWithEmptyAvatar() {
        
        let expectation = self.expectation(description: "Create user with empty Avatar")
        
        let user : User = User(uid: "DCSuperHero4", name: "Batman")
        user.avatar = ""
        CometChat.createUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: true, ismetaData: false, islink: false, isStatusMessage: false, isRole: false)
            
            print("test005CreateUserWithEmptyAvatar onSuccess: \(user)")
            
        }) { (error) in
            
            print("test005CreateUserWithEmptyAvatar failed: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test006CreateUserWithValidMetaData() {
        
        let expectation = self.expectation(description: "Create user with valid metaData")
        
        let user : User = User(uid: "DCSuperHero5", name: "Batman")
        user.metadata = ["RealName" : "Bruce Wayne"]
        CometChat.createUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: false, ismetaData: true, islink: false, isStatusMessage: false, isRole: false)
            
            print("test006CreateUserWithValidMetaData onSuccess: \(user)")
            
            expectation.fulfill()
        }) { (error) in
            
            print("test006CreateUserWithValidMetaData failed: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    
    func test007CreateUserWithEmptydMetaData() {
        
        let expectation = self.expectation(description: "Create user with empty metaData")
        
        let user : User = User(uid: "DCSuperHero6", name: "Batman")
        user.metadata = ["" : ""]
        CometChat.createUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: false, ismetaData: true, islink: false, isStatusMessage: false, isRole: false)
            
            print("test007CreateUserWithEmptydMetaData onSuccess: \(user)")
            expectation.fulfill()
        }) { (error) in
            
            print("test007CreateUserWithEmptydMetaData failed: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test008CreateUserWithValidLink() {
        
        let expectation = self.expectation(description: "Create user with valid link")
        
        let user : User = User(uid: "DCSuperHero7", name: "Batman")
        user.link = "https://www.google.com/"
        CometChat.createUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: false, ismetaData: false, islink: true, isStatusMessage: false, isRole: false)
            
            print("test009CreateUserWithValidLink onSuccess: \(user)")
            expectation.fulfill()
        }) { (error) in
            
            print("test009CreateUserWithValidLink failed: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test009CreateUserWithEmptyLink() {
        
        let expectation = self.expectation(description: "Create user with empty link")
        
        let user : User = User(uid: "DCSuperHero8", name: "Batman")
        user.link = ""
        CometChat.createUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: false, ismetaData: false, islink: true, isStatusMessage: false, isRole: false)
            
            print("test0010CreateUserWithEmptyLink onSuccess: \(user)")
            
        }) { (error) in
            
            print("test0010CreateUserWithEmptyLink failed: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test010CreateUserWithValidStatusMessage() {
        
        let expectation = self.expectation(description: "Create user with valid Status Message")
        
        let user : User = User(uid: "DCSuperHero9", name: "Batman")
        user.statusMessage = "Hey There I am using CometChat Pro"
        CometChat.createUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: false, ismetaData: false, islink: false, isStatusMessage: true, isRole: false)
            
            print("test0011CreateUserWithValidStatusMessage onSuccess: \(user)")
            expectation.fulfill()
        }) { (error) in
            
            print("test0011CreateUserWithValidStatusMessage failed: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test011CreateUserWithEMPTYStatusMessage() {
        
        let expectation = self.expectation(description: "Create user with empty Status Message")
        
        let user : User = User(uid: "DCSuperHero10", name: "Batman")
        user.statusMessage = ""
        CometChat.createUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: false, ismetaData: false, islink: false, isStatusMessage: true, isRole: false)
            
            print("test0012CreateUserWithEMPTYStatusMessage onSuccess: \(user)")
            
        }) { (error) in
            
            print("test0012CreateUserWithEMPTYStatusMessage failed: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test012CreateUserWithEMPTYROLE() {
        
        let expectation = self.expectation(description: "Create user with empty role")
        
        let user : User = User(uid: "DCSuperHero13", name: "Batman")
        user.role = ""
        CometChat.createUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: false, ismetaData: false, islink: false, isStatusMessage: true, isRole: false)
            
            print("test0012CreateUserWithEMPTYROLE onSuccess: \(user)")
            
        }) { (error) in
            
            print("test0012CreateUserWithEMPTYROLE failed: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test013CreateUserWithValidRole() {
        
        let expectation = self.expectation(description: "Create user with valid role")
        
        let user : User = User(uid: "DCSuperHero11", name: "Batman")
        user.role = "default"
        CometChat.createUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: false, ismetaData: false, islink: false, isStatusMessage: false, isRole: true)
            
            print("test0015CreateUserWithValidRole onSuccess: \(user)")
            expectation.fulfill()
        }) { (error) in
            
            print("test0015CreateUserWithValidRole failed: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
//    func test014CreateUserWithEmptyCredits() {
//
//        let expectation = self.expectation(description: "Create user with empty role")
//
//        let user : User = User(uid: "DCSuperHero14", name: "Batman")
//        user.credits = 0
//        CometChat.createUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
//
//            validatedCreatedUser(user: user, isavatar: false, ismetaData: false, islink: false, isStatusMessage: false, isRole: false, isCredit: true)
//
//            print("test0013CreateUserWithEmptyCredits onSuccess: \(user)")
//            expectation.fulfill()
//        }) { (error) in
//
//            print("test0013CreateUserWithEmptyCredits failed: \(String(describing: error?.errorDescription))")
//
//            XCTAssertNotNil(error)
//        }
//
//        wait(for: [expectation], timeout: 30)
//    }
    
//    func test015CreateUserWithValidCredits() {
//
//        let expectation = self.expectation(description: "Create user with valid role")
//
//        let user : User = User(uid: "DCSuperHero12", name: "Batman")
//        user.credits = 100
//        CometChat.createUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
//
//            validatedCreatedUser(user: user, isavatar: false, ismetaData: false, islink: false, isStatusMessage: false, isRole: false, isCredit: true)
//
//            print("test0016CreateUserWithValidCredits onSuccess: \(user)")
//            expectation.fulfill()
//        }) { (error) in
//
//            print("test0016CreateUserWithValidCredits failed: \(String(describing: error?.errorDescription))")
//
//            XCTAssertNotNil(error)
//
//        }
//
//        wait(for: [expectation], timeout: 30)
//    }
    
    
 
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////  COMETCHATPRO: UPDATE USER TEST CASES   /////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func test016UpdateUserWithValidParams() {
        
        let expectation = self.expectation(description: "Update user with valid params")
        
        let user : User = User(uid: "DCSuperHero100", name: "JusticeLeagueBatman")
        
        CometChat.updateUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: false, ismetaData: false, islink: false, isStatusMessage: false, isRole: false)
            
            print("test001UpdateUserWithValidParams onSuccess: \(user)")
            expectation.fulfill()
            
        }) { (error) in
            
            print("test001UpdateUserWithValidParams failed: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test017UpdateUserWithValidEmptyAPIKey() {
        
        let expectation = self.expectation(description: "Update user with empty API Key")
        
        let user : User = User(uid: "DCSuperHero2", name: "Batman")
        
        CometChat.updateUser(user: user, apiKey: "", onSuccess: { (user) in
            
            validateUserList(user: [user], isRole: false)
            
            print("test002UpdateUserWithValidEmptyAPIKey onSuccess: \(user)")
            
            
        }) { (error) in
            
            print("test002UpdateUserWithValidEmptyAPIKey failed: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test018UpdateUserWithValidEmptyUID() {
        
        let expectation = self.expectation(description: "Update user with empty UID")
        
        let user : User = User(uid: "", name: "Batman")
        
        CometChat.updateUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validateUserList(user: [user], isRole: false)
            
            print("test003UpdateUserWithValidEmptyUID onSuccess: \(user)")
            
            
        }) { (error) in
            
            print("test003UpdateUserWithValidEmptyUID failed: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test019UpdateUserWithValidAvatar() {
        
        let expectation = self.expectation(description: "Update user with valid Avatar")
        
        let user : User = User(uid: "DCSuperHero3", name: "BatmanBegins")
        user.avatar = "https://image.shutterstock.com/image-photo/khonkaenthailand-march-4th-2017-batman-600w-622078991.jpg"
        CometChat.updateUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: true, ismetaData: false, islink: false, isStatusMessage: false, isRole: false)
            
            print("test004UpdateUserWithValidAvatar onSuccess: \(user)")
            expectation.fulfill()
            
        }) { (error) in
            
            print("test004UpdateUserWithValidAvatar failed: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test020UpdateUserWithEmptyAvatar() {
        
        let expectation = self.expectation(description: "Update user with empty Avatar")
        
        let user : User = User(uid: "DCSuperHero3", name: "Batman")
        user.avatar = ""
        CometChat.updateUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: false, ismetaData: false, islink: false, isStatusMessage: false, isRole: false)
            
            print("test005UpdateUserWithEmptyAvatar onSuccess: \(user)")
            
            XCTAssertNotNil(user)
            expectation.fulfill()
        }) { (error) in
            
            print("test005UpdateUserWithEmptyAvatar failed: \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test021UpdateUserWithValidMetaData() {
        
        let expectation = self.expectation(description: "Update user with valid metaData")
        
        let user : User = User(uid: "DCSuperHero5", name: "Batman")
        user.metadata = ["RealName" : "Bruce Wayne", "BatMobileReady":"Yes it is ready"]
        CometChat.updateUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: false, ismetaData: true, islink: false, isStatusMessage: false, isRole: false)
            
            print("test006CreateUserWithValidMetaData onSuccess: \(user)")
            
            expectation.fulfill()
        }) { (error) in
            
            print("test006CreateUserWithValidMetaData failed: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    
    func test022UpdateUserWithEmptydMetaData() {
        
        let expectation = self.expectation(description: "Update user with empty metaData")
        
        let user : User = User(uid: "DCSuperHero5", name: "Batman")
        user.metadata = ["" : ""]
        CometChat.updateUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: false, ismetaData: true, islink: false, isStatusMessage: false, isRole: false)
            
            print("test007UpdateUserWithEmptydMetaData onSuccess: \(user)")
            expectation.fulfill()
        }) { (error) in
            
            print("test007UpdateUserWithEmptydMetaData failed: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test023UpdateUserWithValidLink() {
        
        let expectation = self.expectation(description: "Update user with valid link")
        
        let user : User = User(uid: "DCSuperHero7", name: "Batman")
        user.link = "https://prodocs.cometchat.com/"
        CometChat.updateUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: false, ismetaData: false, islink: true, isStatusMessage: false, isRole: false)
            
            print("test009UpdateUserWithValidLink onSuccess: \(user)")
            expectation.fulfill()
        }) { (error) in
            
            print("test009UpdateUserWithValidLink failed: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test024UpdateUserWithEmptyLink() {
        
        let expectation = self.expectation(description: "Update user with empty link")
        
        let user : User = User(uid: "DCSuperHero7", name: "Batman")
        user.link = ""
        CometChat.updateUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: false, ismetaData: false, islink: false, isStatusMessage: false, isRole: false)
            
            print("test024UpdateUserWithEmptyLink onSuccess: \(user)")
            
            XCTAssertNotNil(user)
            expectation.fulfill()
            
        }) { (error) in
            
            print("test024UpdateUserWithEmptyLink failed: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test025UpdateUserWithValidStatusMessage() {
        
        let expectation = self.expectation(description: "Update user with valid Status Message")
        
        let user : User = User(uid: "DCSuperHero9", name: "Batman")
        user.statusMessage = "Hey There I am using CometChat Pro and it is simple fast and amazing"
        CometChat.updateUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: false, ismetaData: false, islink: false, isStatusMessage: true, isRole: false)
            
            print("test0011UpdateUserWithValidStatusMessage onSuccess: \(user)")
            expectation.fulfill()
        }) { (error) in
            
            print("test0011UpdateUserWithValidStatusMessage failed: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test026UpdateUserWithEMPTYStatusMessage() {
        
        let expectation = self.expectation(description: "Update user with empty Status Message")
        
        let user : User = User(uid: "DCSuperHero9", name: "Batman")
        user.statusMessage = ""
        CometChat.updateUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: false, ismetaData: false, islink: false, isStatusMessage: false, isRole: false)
            
            print("test0012UpdateUserWithEMPTYStatusMessage onSuccess: \(user)")
            XCTAssertNotNil(user)
            expectation.fulfill()
        }) { (error) in
            
            print("test0012UpdateUserWithEMPTYStatusMessage failed: \(String(describing: error?.errorDescription))")
            
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
//    func test027UpdateUserWithEmptyCredits() {
//
//        let expectation = self.expectation(description: "Update user with empty role")
//
//        let user : User = User(uid: "UserForEmptyCredits", name: "BatmanWithNoCredits")
//        user.credits = 100
//
//        CometChat.createUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
//
//            let updatedUser : User = User(uid: user.uid!, name: user.name!)
//            updatedUser.credits = 0
//
//            CometChat.updateUser(user: updatedUser, apiKey: TestConstants.apiKey, onSuccess: { (user) in
//
//                validatedCreatedUser(user: user, isavatar: false, ismetaData: false, islink: false, isStatusMessage: false, isRole: false)
//
//                print("test0014UpdateUserWithEmptyCredits onSuccess: \(user)")
//                expectation.fulfill()
//            }) { (error) in
//
//
//
//                XCTAssertNotNil(error)
//            }
//
//        }) { (error) in
//
//            print("test0014UpdateUserWithEmptyCredits failed: \(String(describing: error?.errorDescription))")
//
//        }
//        wait(for: [expectation], timeout: 30)
//    }
    
    func test028UpdateUserWithEMPTYROLE() {
        
        let expectation = self.expectation(description: "Update user with empty role")
        
        let user : User = User(uid: "DCSuperHero11", name: "Batman")
        user.role = ""
        CometChat.updateUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: false, ismetaData: false, islink: false, isStatusMessage: false, isRole: false)
            
            print("test0013UpdateUserWithEMPTYROLE onSuccess: \(user)")
            
            XCTAssertNotNil(user)
            expectation.fulfill()
        }) { (error) in
            
            print("test0013UpdateUserWithEMPTYROLE failed: \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test029UpdateUserWithValidRole() {
        
        let expectation = self.expectation(description: "Update user with valid role")
        
        let user : User = User(uid: "DCSuperHero11", name: "BatmanDefaultRole")
        user.role = "default"
        CometChat.updateUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            validatedCreatedUser(user: user, isavatar: false, ismetaData: false, islink: false, isStatusMessage: false, isRole: true)
            
            print("test0015CreateUserWithValidRole onSuccess: \(user)")
            expectation.fulfill()
            
        }) { (error) in
            
            print("test0015CreateUserWithValidRole failed: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 30)
    }
    
    func test030UpdateUserLoggedInUser() {
        
        let expectation = self.expectation(description: "Update loggedIn User")
        
        let user : User = User(uid: "test1", name: "TESTSUPERHERO")
        user.name = "TESTSUPERHERO!!!!"
        CometChat.updateUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
            
            let loggedInUser = CometChat.getLoggedInUser()
            
            XCTAssertEqual(user.name, "TESTSUPERHERO!!!!")
            XCTAssertNotEqual(user.name, "test1")
            print("test0015CreateUserWithValidRole onSuccess: \(user)")
            expectation.fulfill()
        }) { (error) in
            
            print("test0015CreateUserWithValidRole failed: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 30)
    }
}

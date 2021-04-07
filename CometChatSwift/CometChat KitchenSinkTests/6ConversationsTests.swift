//
//  Cometchat6ConversationsTests.swift
//  CometChatProTests
//
//  Created by Inscripts11 on 19/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

import XCTest
import CometChatPro

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////  COMETCHATPRO: USERS TEST CASES   /////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Cometchat6ConversationsTests: XCTestCase {
  
///////////////////////////////    COMETCHATPRO:Conversation Retrieve  ///////////////////////////
    
    func test001GetConversationListWithValidLimit(){
         let convRequest = ConversationRequest.ConversationRequestBuilder(limit: 20).setConversationType(conversationType: .user).build()
          let expectation = self.expectation(description: "testGetConversationListWithValidLimit")
         convRequest.fetchNext(onSuccess: { (conversationList) in
            
            validateConversations(conversation : conversationList, validateType: .user)
            print("testGetConversationListWithValidLimit onSuccess: \(conversationList)")
            XCTAssertNotNil(conversationList)
            expectation.fulfill()
            print("success of convRequest \(conversationList)")
         }) { (exception) in
                     
           print("testGetConversationListWithValidLimit error: \(String(describing: exception?.errorDescription))")
         }
         wait(for: [expectation], timeout: 10)
     }
     
     func test002GetConversationListWithInValidLimit(){
         let convRequest = ConversationRequest.ConversationRequestBuilder(limit: 1000).setConversationType(conversationType: .user).build()
          let expectation = self.expectation(description: "test002GetConversationListWithInValidLimit")
         convRequest.fetchNext(onSuccess: { (conversationList) in
            print("test002GetConversationListWithInValidLimit onSuccess: \(conversationList)")
         }) { (exception) in
            print("test002GetConversationListWithInValidLimit error: \(String(describing: exception?.errorDescription))")
            XCTAssertNotNil(exception)
            expectation.fulfill()
         }
         wait(for: [expectation], timeout: 10)
     }

    func test003GetConversationListWithZeroLimit(){
        let convRequest = ConversationRequest.ConversationRequestBuilder(limit: 0).setConversationType(conversationType: .user).build()
              let expectation = self.expectation(description: "test002GetConversationListWithZeroLimit")
             convRequest.fetchNext(onSuccess: { (conversationList) in
                print("test002GetConversationListWithInValidLimit onSuccess: \(conversationList)")
             }) { (exception) in
                print("test002GetConversationListWithInValidLimit error: \(String(describing: exception?.errorDescription))")
                XCTAssertNotNil(exception)
                expectation.fulfill()
             }
             wait(for: [expectation], timeout: 10)
    }

    func test004GetConversationListWithMinusLimit(){
        let convRequest = ConversationRequest.ConversationRequestBuilder(limit: -100).setConversationType(conversationType: .user).build()
              let expectation = self.expectation(description: "test002GetConversationListWithMinusLimit")
             convRequest.fetchNext(onSuccess: { (conversationList) in
                print("test002GetConversationListWithInValidLimit onSuccess: \(conversationList)")
             }) { (exception) in
                print("test002GetConversationListWithInValidLimit error: \(String(describing: exception?.errorDescription))")
                XCTAssertNotNil(exception)
                expectation.fulfill()
             }
             wait(for: [expectation], timeout: 10)
     }

    func test005GetConversationListWithUserConversationType(){
        let convRequest = ConversationRequest.ConversationRequestBuilder(limit: 20).setConversationType(conversationType: .user).build()
         let expectation = self.expectation(description: "test003GetConversationListWithUserConversationType")
        convRequest.fetchNext(onSuccess: { (conversationList) in
            
            validateConversations(conversation : conversationList, validateType: .user)
           print("test003GetConversationListWithUserConversationType onSuccess: \(conversationList)")
           XCTAssertNotNil(conversationList)
           expectation.fulfill()
           print("success of convRequest \(conversationList)")
        }) { (exception) in
                    
          print("test003GetConversationListWithUserConversationType error: \(String(describing: exception?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
     
     func test006GetConversationListWithGroupConversationType() {
         let convRequest = ConversationRequest.ConversationRequestBuilder(limit: 20).setConversationType(conversationType: .group).build()
          let expectation = self.expectation(description: "test004GetConversationListWithGroupConversationType")
         convRequest.fetchNext(onSuccess: { (conversationList) in
            validateConversations(conversation : conversationList, validateType: .group)
            print("test004GetConversationListWithGroupConversationType onSuccess: \(conversationList)")
            XCTAssertNotNil(conversationList)
            expectation.fulfill()
            print("success of convRequest \(conversationList)")
         }) { (exception) in
                     
           print("test004GetConversationListWithGroupConversationType error: \(String(describing: exception?.errorDescription))")
         }
         wait(for: [expectation], timeout: 10)
     }
     
     func test007GetConversationListWithNoneConversationType(){
        
         let convRequest = ConversationRequest.ConversationRequestBuilder(limit: 20).setConversationType(conversationType: .none).build()
          let expectation = self.expectation(description: "testGetConversationListWithNoneConversationType")
         convRequest.fetchNext(onSuccess: { (conversationList) in
            validateConversations(conversation : conversationList, validateType: nil)
            print("testGetConversationListWithNoneConversationType onSuccess: \(conversationList)")
            XCTAssertNotNil(conversationList)
            expectation.fulfill()
            print("success of convRequest \(conversationList)")
         }) { (exception) in
                     
           print("testGetConversationListWithNoneConversationType error: \(String(describing: exception?.errorDescription))")
         }
         wait(for: [expectation], timeout: 30)
     }
    
    func test008GetParticularConversationForUserWithValidInput() {
        
        let expectation = self.expectation(description: "test008GetParticularConversationForUserWithValidInput")
        
        CometChat.getConversation(conversationWith: TestConstants.user1, conversationType: .user, onSuccess: { (success) in
            
            print("test008GetParticularConversationForUserWithValidInput onSuccess: \(success)")
            XCTAssertNotNil(success)
            expectation.fulfill()
        }) { (error) in
            
            print("test008GetParticularConversationForUserWithValidInput error: \(String(describing: error?.errorDescription))")
            XCTAssertEqual("No such conversation found.", error?.errorDescription)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
    }
    
    func test009GetParticularConversationForUserWithInValidInput() {
        
        let expectation = self.expectation(description: "test009GetParticularConversationForUserWithInValidInput")
        
        CometChat.getConversation(conversationWith: TestConstants.grpPublic1, conversationType: .user, onSuccess: { (success) in
            
            print("test009GetParticularConversationForUserWithInValidInput onSuccess: \(success)")
            
        }) { (error) in
            
            print("test009GetParticularConversationForUserWithInValidInput error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
    }
    
    func test010GetParticularConversationForGroupWithValidInput() {
        
        let expectation = self.expectation(description: "test010GetParticularConversationForGroupWithValidInput")
        
        CometChat.getConversation(conversationWith: TestConstants.grpPublic1, conversationType: .group, onSuccess: { (success) in
            
            print("test010GetParticularConversationForGroupWithValidInput onSuccess: \(success)")
            XCTAssertNotNil(success)
            expectation.fulfill()
            
        }) { (error) in
            
            print("test010GetParticularConversationForGroupWithValidInput error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 30)
    }
    
    func test011GetParticularConversationForGroupWithInValidInput() {
        
        let expectation = self.expectation(description: "test009GetParticularConversationForGroupWithValidInput")
        
        CometChat.getConversation(conversationWith: TestConstants.user1, conversationType: .group, onSuccess: { (success) in
            
            print("test009GetParticularConversationForGroupWithValidInput onSuccess: \(String(describing: success))")
            
            
        }) { (error) in
            
            print("test009GetParticularConversationForGroupWithValidInput error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}

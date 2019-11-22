//
//  Cometchat6ConversationsTests.swift
//  CometChatProTests
//
//  Created by Inscripts11 on 19/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

import XCTest
@testable import CometChatPro

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////  COMETCHATPRO: USERS TEST CASES   /////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Cometchat6ConversationsTests: XCTestCase {
  
    
    ///////////////////////////////    COMETCHATPRO:Conversation Retrieve  ///////////////////////////
        
        func test001GetConversationListWithValidLimit(){
             let convRequest = ConversationRequest.ConversationRequestBuilder(limit: 20).setConversationType(conversationType: .user).build()
              let expectation = self.expectation(description: "testGetConversationListWithValidLimit")
             convRequest.fetchNext(onSuccess: { (conversationList) in
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
    
         
        func test003GetConversationListWithUserConversationType(){
            let convRequest = ConversationRequest.ConversationRequestBuilder(limit: 20).setConversationType(conversationType: .user).build()
             let expectation = self.expectation(description: "test003GetConversationListWithUserConversationType")
            convRequest.fetchNext(onSuccess: { (conversationList) in
               print("test003GetConversationListWithUserConversationType onSuccess: \(conversationList)")
               XCTAssertNotNil(conversationList)
               expectation.fulfill()
               print("success of convRequest \(conversationList)")
            }) { (exception) in
                        
              print("test003GetConversationListWithUserConversationType error: \(String(describing: exception?.errorDescription))")
            }
            wait(for: [expectation], timeout: 10)
        }
         
         func test004GetConversationListWithGroupConversationType() {
             let convRequest = ConversationRequest.ConversationRequestBuilder(limit: 20).setConversationType(conversationType: .group).build()
              let expectation = self.expectation(description: "test004GetConversationListWithGroupConversationType")
             convRequest.fetchNext(onSuccess: { (conversationList) in
                print("test004GetConversationListWithGroupConversationType onSuccess: \(conversationList)")
                XCTAssertNotNil(conversationList)
                expectation.fulfill()
                print("success of convRequest \(conversationList)")
             }) { (exception) in
                         
               print("test004GetConversationListWithGroupConversationType error: \(String(describing: exception?.errorDescription))")
             }
             wait(for: [expectation], timeout: 10)
         }
         
         func test005GetConversationListWithNoneConversationType(){
             let convRequest = ConversationRequest.ConversationRequestBuilder(limit: 20).setConversationType(conversationType: .none).build()
              let expectation = self.expectation(description: "testGetConversationListWithNoneConversationType")
             convRequest.fetchNext(onSuccess: { (conversationList) in
                print("testGetConversationListWithNoneConversationType onSuccess: \(conversationList)")
                XCTAssertNotNil(conversationList)
                expectation.fulfill()
                print("success of convRequest \(conversationList)")
             }) { (exception) in
                         
               print("testGetConversationListWithNoneConversationType error: \(String(describing: exception?.errorDescription))")
             }
             wait(for: [expectation], timeout: 10)
         }
        

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
    
}

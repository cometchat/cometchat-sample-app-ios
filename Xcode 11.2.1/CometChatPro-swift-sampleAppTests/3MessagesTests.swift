//
//  CometChat4Messagess.swift
//  CometChatPros
//
//  Created by Inscripts11 on 20/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

import XCTest
@testable import CometChatPro

////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////  COMETCHATPRO: MESSAGES TEST CASES   ///////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////


class CometChat3Messages: XCTestCase {

    override func setUp() {
    }
    
////////////////////////////////////////////////////////////////////////////////////////////
    
////////////////////////////  COMETCHATPRO: TEXT MESSAGES  /////////////////////////////////
    
    //1. Sending Text message to user with AllValidInputs
    func test001SendTextMessagesToUserWithAllValidInputs() {
        
        let expectation = self.expectation(description: "Sending Text message to user with AllValidInputs")
        let _textMessage = TextMessage(receiverUid: TestConstants.user2, text: "Apostrophe is ' and right single quotation mark is `", receiverType: .user)
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            print("sendTextMessagesWithValidReceiverIdAndText successfully: \(textMessage.stringValue())")
            XCTAssertNotNil(textMessage)
            expectation.fulfill()
            
        }) { (error) in

            print("sendTextMessagesWithValidReceiverIdAndText error :\(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //2. Sending Text message to group with AllValidInputs
    func test002SendTextMessagesToGroupWithAllValidInputs() {
        
        let expectation = self.expectation(description: "Sending Text message to group with AllValidInputs")
        let _textMessage = TextMessage(receiverUid: TestConstants.grpPublic1, text: "this is normal text",  receiverType: .group)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            print("sendTextMessagesWithValidReceiverIdAndText successfully: \(textMessage.stringValue())")
            XCTAssertNotNil(textMessage)
            expectation.fulfill()
            
        }) { (error) in
            
            XCTAssertEqual(error?.errorDescription, "The UID \(TestConstants.user1) has blocked UID \(TestConstants.user2).")
            expectation.fulfill()
            print("sendTextMessagesWithValidReceiverIdAndText error :\(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    

    //3.Sending Text message to user with empty receiverUid
    func test003SendTextMessagesWithEmptyReceiverIdToUser(){
        
        let expectation = self.expectation(description: "Sending Text message to user with empty receiverUid")
        
        let _textMessage = TextMessage(receiverUid: "", text: "this is normal text",  receiverType: .user)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            print("sendTextMessagesWithEmptyReceiverIdToUser successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessagesWithEmptyReceiverIdToUser error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //4.Sending Text message to group with empty receiverUid
    func test004SendTextMessagesWithEmptyReceiverIdToGroup(){
        
        let expectation = self.expectation(description: "Sending Text message to group with empty receiverUid")
        
        let _textMessage = TextMessage(receiverUid: "", text: "this is normal text",  receiverType: .group)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            print("sendTextMessagesWithEmptyReceiverIdToGroup successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessagesWithEmptyReceiverIdToGroup error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //5.Sending Text message to user with empty  message text
    func test005SendTextMessagesWithEmptyMessageTextToUser(){
        
        let expectation = self.expectation(description: "Sending Text message to user with empty  message text")
        
        let _textMessage = TextMessage(receiverUid: TestConstants.user2, text: "",  receiverType: .user)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessagesWithEmptyMessageTextToUser successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessagesWithEmptyMessageTextToUser error :\(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //6.Sending Text message to group with empty  message text
    func test006SendTextMessagesWithEmptyMessageTextToGroup(){
        
        let expectation = self.expectation(description: "Sending Text message to group with empty  message text")
        
        let _textMessage = TextMessage(receiverUid: TestConstants.grpPublic1, text: "",  receiverType: .user)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessagesWithEmptyMessageTextToGroup successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessagesWithEmptyMessageTextToGroup error :\(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //7.Sending Text message to useR with Invalid  message Type
    func test007SendTextMessagesWithInvalidMessageTypeToUser() {
        //Discarded
    }
    
    //8.Sending Text message to group with Invalid  message Type
    func test008SendTextMessagesWithInvalidMessageTypeToGroup(){
        //Discarded
    }
    
    //9. Sending Text message to user with empty text
    func test009SendTextMessageWithEmptyTextToUser() {
        
        let expectation = self.expectation(description: "Sending Text message to user with empty text")
        
        let _textMessage = TextMessage(receiverUid: TestConstants.user2, text: "",  receiverType: .user)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessageWithEmptyTextToUser successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessageWithEmptyTextToUser error: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    //10. Sending Text message to group with empty text
    func test010SendTextMessageWithEmptyTextToGroup() {
        
        let expectation = self.expectation(description: "Sending Text message to group with empty text")
        
        let _textMessage = TextMessage(receiverUid: TestConstants.grpPublic1, text: "",  receiverType: .group)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessageWithEmptyTextToGroup successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessageWithEmptyTextToGroup error: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //11. Sending Text message to group with Invalid receiver Type
    func test011SendTextMessageToGroupWithInvalidReceiverType() {
        
        let expectation = self.expectation(description: "Sending Text message to user with Invalid receiver Type")
        
        let _textMessage = TextMessage(receiverUid: TestConstants.user1, text: "hello",  receiverType: .group)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessageToGroupWithInvalidReceiverType successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessageToGroupWithInvalidReceiverType error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //12. Sending Text message to group with Invalid receiver Type
    func test012SendTextMessageToUserWithInvalidReceiverType() {
        
        let expectation = self.expectation(description: "Sending Text message to group with Invalid receiver Type")
        
        let _textMessage = TextMessage(receiverUid: TestConstants.grpPublic1, text: "Hello",  receiverType: .user)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessageToUserWithInvalidReceiverType successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessageToUserWithInvalidReceiverType error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    
    //13. Sending Text message to group with Invalid receiver Type & Empty TExt
    func test013SendTextMessageToGroupWithInvalidReceiverTypeAndEmptyText() {
        
        let expectation = self.expectation(description: "Sending Text message to group with Invalid receiver Type & Empty TExt")
        
        let _textMessage = TextMessage(receiverUid: TestConstants.user1, text: "",  receiverType: .group)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessageToGroupWithInvalidReceiverTypeAndEmptyText successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessageToGroupWithInvalidReceiverTypeAndEmptyText error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //14. Sending Text message to group with Invalid receiver Type
    func test014SendTextMessageToUserWithInvalidReceiverTypeAndEmptyText() {
        
        let expectation = self.expectation(description: "Sending Text message to group with Invalid receiver Type & Empty TExt")
        
        let _textMessage = TextMessage(receiverUid: TestConstants.grpPublic1, text: "",  receiverType: .user)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessageToUserWithInvalidReceiverTypeAndEmptyText successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessageToUserWithInvalidReceiverTypeAndEmptyText error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //15. Sending Text message to user with vailid UID and Invalid receiverType, messageType.
    func test015SendTextMessageToUserWithValidUIDAndInvalidReceiverTypeInValidMessageType() {
        
        let expectation = self.expectation(description: "Sending Text message to user with vailid UID and Invalid receiverType, messageType.")
        
        let _textMessage = TextMessage(receiverUid: TestConstants.user2, text: "", receiverType: .group)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessageToUserWithValidUIDAndInvalidReceiverTypeInValidMessageType successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessageToUserWithValidUIDAndInvalidReceiverTypeInValidMessageType error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //16. Sending Text message to group with vailid GUID and Invalid receiverType, messageType.
    func test016SendTextMessageToGroupWithValidGUIDAndInvalidReceiverTypeInValidMessageType() {
        
        let expectation = self.expectation(description: "Sending Text message to user with vailid UID and Invalid receiverType, messageType.")
        
        let _textMessage = TextMessage(receiverUid: TestConstants.grpPublic1, text: "",  receiverType: .user)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessageToGroupWithValidGUIDAndInvalidReceiverTypeInValidMessageType successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessageToGroupWithValidGUIDAndInvalidReceiverTypeInValidMessageType error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //17.Sending Text message to user with Invalid receiverUid
    func test017SendTextMessagesWithInvalidReceiverIdToUser() {
        
        let expectation = self.expectation(description: "Sending Text message to user with Invalid receiverUid")
        
        let _textMessage = TextMessage(receiverUid: "Invalid", text: "this is normal text",  receiverType: .user)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessagesWithInvalidReceiverIdToUser successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessagesWithInvalidReceiverIdToUser error :\(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //18.Sending Text message to group with Invalid receiverUid
    func test018SendTextMessagesWithInvalidReceiverIdToGroup() {
        
        let expectation = self.expectation(description: "Sending Text message to group with Invalid receiverUid")
        
        let _textMessage = TextMessage(receiverUid: "Invalid" , text: "this is normal text",  receiverType: .group)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessagesWithInvalidReceiverIdToGroup successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessagesWithInvalidReceiverIdToGroup error :\(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //19.Sending Text message to user with Invalid receiverUid & Empty Text
    func test019SendTextMessagesWithInvalidReceiverIdAndEmptyTextToUser() {
        
        let expectation = self.expectation(description: "Sending Text message to user with Invalid receiverUid & Empty Text")
        
        let _textMessage = TextMessage(receiverUid: "Invalid", text: "",  receiverType: .user)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessagesWithInvalidReceiverIdAndEmptyTextToUser successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessagesWithInvalidReceiverIdAndEmptyTextToUser error :\(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //20.Sending Text message to group with Invalid receiverUid
    func test020SendTextMessagesWithInvalidReceiverIdAndEmptyTextToGroup() {
        
        let expectation = self.expectation(description: "Sending Text message to group with Invalid receiverUid")
        
        let _textMessage = TextMessage(receiverUid: "Invalid" , text: "",  receiverType: .group)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessagesWithInvalidReceiverIdAndEmptyTextToGroup successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessagesWithInvalidReceiverIdAndEmptyTextToGroup error :\(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    
    //21.Sending Text message to user with Invalid receiverUid & Invalid MessageType
    func test021SendTextMessagesWithInvalidReceiverIdAndInvalidMessageTypeToUser() {
        
        let expectation = self.expectation(description: "Sending Text message to user with Invalid receiverUid & Empty Text")
        
        let _textMessage = TextMessage(receiverUid: "Invalid", text: "hello", receiverType: .user)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessagesWithInvalidReceiverIdAndInvalidMessageTypeToUser successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessagesWithInvalidReceiverIdAndInvalidMessageTypeToUser error :\(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //22.Sending Text message to group with Invalid receiverUid & Invalid MessageType
    func test022SendTextMessagesWithInvalidReceiverIdAndInvalidMessageTypeToGroup() {
        
        let expectation = self.expectation(description: "Sending Text message to group with Invalid receiverUid & Invalid MessageType")
        
        let _textMessage = TextMessage(receiverUid: "Invalid" , text: "Helo", receiverType: .group)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessagesWithInvalidReceiverIdAndInvalidMessageTypeToGroup successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessagesWithInvalidReceiverIdAndInvalidMessageTypeToGroup error :\(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //23.Sending Text message to user with Invalid receiverUid & Invalid Receiver Type
    func test023SendTextMessagesWithInvalidReceiverIdAndInvalidReceiverTypeToUser() {
        
        let expectation = self.expectation(description: "Sending Text message to user with Invalid receiverUid & Invalid Receiver Type")
        
        let _textMessage = TextMessage(receiverUid: "supher132" , text: "Helo",  receiverType: .group)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessagesWithInvalidReceiverIdAndInvalidMessageTypeToGroup successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessagesWithInvalidReceiverIdAndInvalidMessageTypeToGroup error :\(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //24.Sending Text message to group with Invalid receiverUid & Invalid Receiver Type
    func test024SendTextMessagesWithInvalidReceiverIdAndInvalidReceiverTypeToGroup() {
        
        let expectation = self.expectation(description: "Sending Text message to group with Invalid receiverUid & Invalid Receiver Type")
        
        let _textMessage = TextMessage(receiverUid: "supgror1" , text: "Helo",  receiverType: .user)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessagesWithInvalidReceiverIdAndInvalidReceiverTypeToGroup successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessagesWithInvalidReceiverIdAndInvalidReceiverTypeToGroup error :\(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //25.Sending Text message to user with Invalid receiverUid & Invalid Receiver Type  & Invalide MEssage Type
    func test025SendTextMessagesWithInvalidReceiverIdInvalidReceiverInvalidMessageTypeTypeToUser() {
        
        let expectation = self.expectation(description: "Sending Text message to user with Invalid receiverUid & Invalid Receiver Type  & Invalide MEssage Type")
        
        let _textMessage = TextMessage(receiverUid: "supher132" , text: "Helo", receiverType: .group)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessagesWithInvalidReceiverIdInvalidReceiverInvalidMessageTypeTypeToUser successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessagesWithInvalidReceiverIdInvalidReceiverInvalidMessageTypeTypeToUser error :\(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //26.Sending Text message to group with Invalid receiverUid & Invalid Receiver Type
    func test026SendTextMessagesWithInvalidReceiverIdInvalidReceiverInvalidMessageTypeTypeToGroup() {
        
        let expectation = self.expectation(description: "Sending Text message to group with Invalid receiverUid & Invalid Receiver Type")
        
        let _textMessage = TextMessage(receiverUid: "supgror1" , text: "Helo",  receiverType: .user)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessagesWithInvalidReceiverIdInvalidReceiverInvalidMessageTypeTypeToGroup successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessagesWithInvalidReceiverIdInvalidReceiverInvalidMessageTypeTypeToGroup error :\(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //27.Sending Text message to user with all Invalid Inputs
    func test027SendTextMessagesWithAllInvalidInputsToUser() {
        
        let expectation = self.expectation(description: "Sending Text message to user with all Invalid Inputs")
        
        let _textMessage = TextMessage(receiverUid: "supher132" , text: "", receiverType: .group)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessagesWithAllInvalidInputsToUser successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessagesWithAllInvalidInputsToUser error :\(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //28.Sending Text message to group with with all Invalid Inputs
    func test028SendTextMessagesWithAllInvalidInputsToGroup() {
        
        let expectation = self.expectation(description: "Sending Text message to user with all Invalid Inputs")
        
        let _textMessage = TextMessage(receiverUid: "supgror1" , text: "",  receiverType: .user)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessagesWithAllInvalidInputsToUser successful: \(textMessage.stringValue())")
            
        }) { (error) in
            
            print("sendTextMessagesWithAllInvalidInputsToUser error :\(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //29.Sending Text message to user with metadata
    func test029SendTextMessagesWithMetaDataToUser() {
        
        let expectation = self.expectation(description: "Sending Text message to user with metadata")
        
        let _textMessage = TextMessage(receiverUid: TestConstants.user2, text: "this is normal text",  receiverType: .user)
        _textMessage.metaData = ["key":"value"]
        
        _ = CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessagesWithMetaData successfully: \(textMessage.stringValue())")
            
            XCTAssertNotNil(textMessage)
            expectation.fulfill()
            
        }) { (error) in
            
            XCTAssertEqual(error?.errorDescription, "The UID \(TestConstants.user1) has blocked UID \(TestConstants.user2).")
            expectation.fulfill()
            print("sendTextMessagesWithMetaData error :\(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //30. Sending Text message to group with metadata
    func test030SendTextMessagesWithMetaDataToGroup() {
        
        let expectation = self.expectation(description: "Sending Text message to group with metadata")
        
        let _textMessage = TextMessage(receiverUid: TestConstants.grpPublic1, text: "this is normal text",  receiverType: .group)
        _textMessage.metaData = ["key":"value"]
        
        _ = CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessagesWithMetaDataToGroup successfully: \(textMessage.stringValue())")
            
            XCTAssertNotNil(textMessage)
            expectation.fulfill()
            
        }) { (error) in
            
            
            print("sendTextMessagesWithMetaDataToGroup error :\(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //31.Sending Text message to user with muid
    func test031SendTextMessagesWithMuidToUser() {
        
        let expectation = self.expectation(description: "Sending Text message to user with muid")
        
        let _textMessage = TextMessage(receiverUid: TestConstants.user2, text: "this is normal text",  receiverType: .user)
        _textMessage.muid = "12"
        
         CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("testSendTextMessagesWithMuidToUser successfully: \(textMessage.muid)")
            XCTAssertEqual(textMessage.muid, "12")
            expectation.fulfill()
            
        }) { (error) in
            
            XCTAssertEqual(error?.errorDescription, "The UID \(TestConstants.user1) has blocked UID \(TestConstants.user2).")
            expectation.fulfill()
            print("testSendTextMessagesWithMuidToUser error :\(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //32. Sending Text message to group with metadata
    func test032SendTextMessagesWithMuidToGroup() {
        
        let expectation = self.expectation(description: "Sending Text message to group with muid")
        
        let _textMessage = TextMessage(receiverUid: TestConstants.grpPublic1, text: "this is normal text",  receiverType: .group)
        _textMessage.muid = "12"
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("testSendTextMessagesWithMuidToUser successfully: \(textMessage.muid)")
            XCTAssertEqual(textMessage.muid, "12")
            expectation.fulfill()
            
            
            
        }) { (error) in
            
            
            print("testSendTextMessagesWithMuidToGroup error :\(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }

////////////////////////////////////////////////////////////////////////////////////////////
    
//////////////////////////////  COMETCHATPRO: MEDIA MESSAGES  //////////////////////////////
    
    //1. Sending Media message to user with AllValidInputs
    func test033SendMediaMessageToUserWithAllValidInputs() {
        let expectation = self.expectation(description: "Sending Media message to user with AllValidInputs")
        let _mediaMessage = MediaMessage(receiverUid: TestConstants.user2, fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .image, receiverType: .user)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("sendMediaMessageToUserWithAllValidInputs successful: \(mediaMessage.stringValue())")
            XCTAssertNotNil(mediaMessage)
            expectation.fulfill()
         }) { (error) in
            print("sendMediaMessageToUserWithAllValidInputs error :\(String(describing: error?.errorDescription))")
           
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //2. Sending Media message to group with AllValidInputs
    func test034SendMediaMessageToGroupWithAllValidInputs() {
        let expectation = self.expectation(description: "Sending Media message to group with AllValidInputs")
        let _mediaMessage = MediaMessage(receiverUid: TestConstants.grpPublic1, fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .image, receiverType: .group)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("sendMediaMessageToGroupWithAllValidInputs successful: \(mediaMessage.stringValue())")
            XCTAssertNotNil(mediaMessage)
            expectation.fulfill()
        }) { (error) in
            print("sendMediaMessageToGroupWithAllValidInputs error :\(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //3.Sending Media message to user with empty receiverUid
    func test035SendMediaMessageToUserWithEmptyUserID() {
        let expectation = self.expectation(description: "Sending Media message to user with empty receiverUid")
        let _mediaMessage = MediaMessage(receiverUid: "", fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .image, receiverType: .user)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("sendMediaMessageToUserWithEmptyUserID successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("sendMediaMessageToUserWithEmptyUserID error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    //4.Sending Media message to group with empty receiverUid
    func test036SendMediaMessageToGroupWithEmptyUserID() {
        let expectation = self.expectation(description: "Sending Media message to group with empty receiverUid")
        let _mediaMessage = MediaMessage(receiverUid: "", fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .image, receiverType: .group)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("test036SendMediaMessageToGroupWithEmptyUserID successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("test036SendMediaMessageToGroupWithEmptyUserID error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //5.Sending Media message to user with empty  mediaURL
    func test037SendMediaMessageToUserWithEmptyMediaURL() {
        let expectation = self.expectation(description: "Sending Media message to user with empty  mediaURL")
        let _mediaMessage = MediaMessage(receiverUid: TestConstants.user2, fileurl: "", messageType: .image, receiverType: .user)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("test037SendMediaMessageToUserWithEmptyMediaURL successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("test037SendMediaMessageToUserWithEmptyMediaURL error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //6.Sending Media message to group with empty  mediaURL
    func test038SendMediaMessageToGroupWithEmptymediaURL() {
        let expectation = self.expectation(description: "Sending Media message to group with empty  mediaURL")
        let _mediaMessage = MediaMessage(receiverUid: TestConstants.grpPublic1, fileurl: "", messageType: .image, receiverType: .group)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("test038SendMediaMessageToGroupWithEmptymediaURL successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("test038SendMediaMessageToGroupWithEmptymediaURL error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //7.Sending Media message to useR with Invalid  message Type
    func test039SendMediaMessageToUserWithInvalidMessageType() {
        let expectation = self.expectation(description: "Sending Media message to useR with Invalid  message Type")
        let _mediaMessage = MediaMessage(receiverUid: TestConstants.user2, fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .text, receiverType: .user)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("test039SendMediaMessageToUserWithInvalidMessageType successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("test039SendMediaMessageToUserWithInvalidMessageType error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //8.Sending Media message to group with Invalid  message Type
    func test040SendMediaMessageToGroupWithInvalidMessageType() {
        let expectation = self.expectation(description: "Sending Media message to group with Invalid  message Type")
        let _mediaMessage = MediaMessage(receiverUid: TestConstants.user2, fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .text, receiverType: .group)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("test040SendMediaMessageToGroupWithInvalidMessageType successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("test040SendMediaMessageToGroupWithInvalidMessageType error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //9. Sending Media message to user with mediaURL
    func test041SendMediaMessageToUserWithInvalidmediaURL() {
        let expectation = self.expectation(description: "Sending Media message to group with Invalid  mediaURL ")
        let _mediaMessage = MediaMessage(receiverUid: TestConstants.user2, fileurl: "Invalid", messageType: .image, receiverType: .user)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToUserWithInvalidmediaURL successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("testSendMediaMessageToUserWithInvalidmediaURL error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //10. Sending Media message to group with mediaURL
    func test042SendMediaMessageToGroupWithInvalidmediaURL() {
        let expectation = self.expectation(description: "Sending Media message to group with Invalid  mediaURL")
        let _mediaMessage = MediaMessage(receiverUid: TestConstants.grpPublic1, fileurl: "Invalid", messageType: .image, receiverType: .group)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToGroupWithInvalidmediaURL successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("testSendMediaMessageToGroupWithInvalidmediaURL error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //11. Sending Media message to user with Invalid receiver Type
    func test043SendMediaMessageToUserWithInvalidReceiverType() {
        let expectation = self.expectation(description: "Sending Media message to user with Invalid receiver Type")
        let _mediaMessage = MediaMessage(receiverUid: TestConstants.user2, fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .image, receiverType: .group)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToUserWithInvalidReceiverType successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("testSendMediaMessageToUserWithInvalidReceiverType error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //12. Sending Media message to group with Invalid receiver Type
    func test044SendMediaMessageToGroupWithInvalidReceiverType() {
        let expectation = self.expectation(description: "Sending Media message to group with Invalid receiver Type")
        let _mediaMessage = MediaMessage(receiverUid: TestConstants.grpPublic1, fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .image, receiverType: .user)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToGroupWithInvalidReceiverType successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("testSendMediaMessageToGroupWithInvalidReceiverType error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    //13. Sending Media message to user with Invalid receiver Type & Empty mediaURL
    func test045SendMediaMessageToUserWithInvalidReceiverTypeAndEmptyImageURL() {
        let expectation = self.expectation(description: "Sending Media message to user with Invalid receiver Type")
        let _mediaMessage = MediaMessage(receiverUid: TestConstants.user2, fileurl: "", messageType: .image, receiverType: .group)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToUserWithInvalidReceiverType successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("testSendMediaMessageToUserWithInvalidReceiverType error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //14. Sending Media message to group with Invalid receiver Type & Empty mediaURL
    func test046SendMediaMessageToGroupWithInvalidReceiverTypeAndEmptyMediaURL() {
        let expectation = self.expectation(description: "Sending Media message to group with Invalid receiver Type")
        let _mediaMessage = MediaMessage(receiverUid: TestConstants.grpPublic1, fileurl: "", messageType: .image, receiverType: .user)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToGroupWithInvalidReceiverType successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("testSendMediaMessageToGroupWithInvalidReceiverType error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //15. Sending Media message to user with vailid UID and Invalid receiverType, messageType.
    func test047SendMediaMessageToUserWithInvalidReceiverTypeInvalidMessageType() {
        let expectation = self.expectation(description: "ending Media message to user with vailid UID and Invalid receiverType, messageType.")
        let _mediaMessage = MediaMessage(receiverUid: TestConstants.user2, fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .text, receiverType: .group)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToUserWithInvalidReceiverTypeInvalidmessageType successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("testSendMediaMessageToUserWithInvalidReceiverTypeInvalidmessageType error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //16. Sending Media message to group with vailid GUID and Invalid receiverType, messageType.
    func test048SendMediaMessageToGroupWithInvalidReceiverTypeInvalidMessageType() {
        let expectation = self.expectation(description: "Sending Media message to group with vailid GUID and Invalid receiverType, messageType.")
        let _mediaMessage = MediaMessage(receiverUid: TestConstants.user2, fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .text, receiverType: .user)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToGroupWithInvalidReceiverTypeInvalidmessageType successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("testSendMediaMessageToGroupWithInvalidReceiverTypeInvalidmessageType error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    //17.Sending Media message to user with Invalid receiverUid
    func test049SendMediaMessageToUserWithInvalidReceiverUid() {
        let expectation = self.expectation(description: "Sending Media message to user with Invalid receiverUid")
        let _mediaMessage = MediaMessage(receiverUid: "INVALID", fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .image, receiverType: .user)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToUserWithInvalidReceiverUid successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("testSendMediaMessageToUserWithInvalidReceiverUid error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    //18.Sending Media message to group with Invalid receiverUid
    func test050SendMediaMessageToGroupWithInvalidReceiverUid() {
        let expectation = self.expectation(description: "Sending Media message to group with Invalid receiverUid")
        let _mediaMessage = MediaMessage(receiverUid: "INVALID", fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .image, receiverType: .group)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToGroupWithInvalidReceiverUid successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("testSendMediaMessageToGroupWithInvalidReceiverUid error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //19.Sending Media message to user with Invalid receiverUid & Empty mediaURL
    func test051SendMediaMessageToUserWithInvalidReceiverUidAndEmptyURL() {
        let expectation = self.expectation(description: "Sending Media message to user with Invalid receiverUid & Empty mediaURL")
        let _mediaMessage = MediaMessage(receiverUid: "INVALID", fileurl: "", messageType: .image, receiverType: .user)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToUserWithInvalidReceiverUidAndEmptyURL successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("testSendMediaMessageToUserWithInvalidReceiverUidAndEmptyURL error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //20.Sending Media message to group with Invalid receiverUid & Empty mediaURL
    func test052SendMediaMessageToGroupWithInvalidReceiverUidAndEmptyURL() {
        let expectation = self.expectation(description: "Sending Media message to group with Invalid receiverUid& Empty mediaURL ")
        let _mediaMessage = MediaMessage(receiverUid: "INVALID", fileurl: "", messageType: .image, receiverType: .group)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToGroupWithInvalidReceiverUidAndEmptyURL successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("testSendMediaMessageToGroupWithInvalidReceiverUidAndEmptyURL error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //21.Sending Media message to user with Invalid receiverUid & Invalid MessageType
    func test053SendMediaMessageToUserWithInvalidReceiverUidInvalidMessageType() {
        let expectation = self.expectation(description: "Sending Media message to user with Invalid receiverUid & Invalid MessageType")
        let _mediaMessage = MediaMessage(receiverUid: "INVALID", fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .text, receiverType: .user)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToUserWithInvalidReceiverUidInvalidMessageType successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("testSendMediaMessageToUserWithInvalidReceiverUidInvalidMessageType error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //22.Sending Media message to group with Invalid receiverUid & Invalid MessageType
    func test054SendMediaMessageToGroupWithInvalidReceiverUidInvalidMessageType() {
        let expectation = self.expectation(description: "Sending Media message to group with Invalid receiverUid & Invalid MessageType")
        let _mediaMessage = MediaMessage(receiverUid: "INVALID", fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .text, receiverType: .group)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToGroupWithInvalidReceiverUidInvalidMessageType successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("testSendMediaMessageToGroupWithInvalidReceiverUidInvalidMessageType error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //23.Sending Media message to user with Invalid receiverUid & Invalid Receiver Type
    func test055SendMediaMessageToUserWithInvalidReceiverUidInvalidReceiverType() {
        let expectation = self.expectation(description: "Sending Media message to user with Invalid receiverUid & Invalid Receiver Type")
        let _mediaMessage = MediaMessage(receiverUid: "INVALID", fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .image, receiverType: .group)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToUserWithInvalidReceiverUidInvalidReceiverType successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("testSendMediaMessageToUserWithInvalidReceiverUidInvalidReceiverType error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //24.Sending Media message to group with Invalid receiverUid & Invalid Receiver Type
    func test056SendMediaMessageToGroupWithInvalidReceiverUidInvalidReceiverType() {
        let expectation = self.expectation(description: "Sending Media message to user with Invalid receiverUid & Invalid Receiver Type")
        let _mediaMessage = MediaMessage(receiverUid: "INVALID", fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .image, receiverType: .user)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToGroupWithInvalidReceiverUidInvalidReceiverType successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("testSendMediaMessageToGroupWithInvalidReceiverUidInvalidReceiverType error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //25.Sending Media message to user with Invalid receiverUid & Invalid Receiver Type  & Invalide MEssage Type
    func test057SendMediaMessageToUserWithInvalidReceiverUidInvalidReceiverTypeInvalidMessageType() {
        let expectation = self.expectation(description: "Sending Media message to user with Invalid receiverUid & Invalid Receiver Type  & Invalide MEssage Type")
        let _mediaMessage = MediaMessage(receiverUid: "INVALID", fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .text, receiverType: .group)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToUserWithInvalidReceiverUidInvalidReceiverTypeInvalidMessageType successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("testSendMediaMessageToUserWithInvalidReceiverUidInvalidReceiverTypeInvalidMessageType error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //26.Sending Media message to group with Invalid receiverUid & Invalid Receiver Type
    func test058SendMediaMessageToGroupWithInvalidReceiverUidInvalidReceiverTypeInvalidMessageType() {
        let expectation = self.expectation(description: "Sending Media message to group with Invalid receiverUid & Invalid Receiver Type")
        let _mediaMessage = MediaMessage(receiverUid: "INVALID", fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .text, receiverType: .user)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToGroupWithInvalidReceiverUidInvalidReceiverTypeInvalidMessageType successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("testSendMediaMessageToGroupWithInvalidReceiverUidInvalidReceiverTypeInvalidMessageType error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //27.Sending Media message to user with all Invalid Inputs
    func test059SendMediaMessageToUserWithAllInvalidInputs() {
        let expectation = self.expectation(description: "Sending Media message to group with Invalid receiverUid & Invalid Receiver Type")
        let _mediaMessage = MediaMessage(receiverUid: "INVALID", fileurl: "INVALID", messageType: .text, receiverType: .group)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToUserWithAllInvalidInputs successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("testSendMediaMessageToUserWithAllInvalidInputs error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //28.Sending Media message to group with with all Invalid Inputs
    func test060SendMediaMessageToGroupWithAllInvalidInputs() {
        let expectation = self.expectation(description: "Sending Media message to group with Invalid receiverUid & Invalid Receiver Type")
        let _mediaMessage = MediaMessage(receiverUid: "INVALID", fileurl: "INVALID", messageType: .text, receiverType: .user)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToUserWithAllInvalidInputs successful: \(mediaMessage.stringValue())")
        }) { (error) in
            print("testSendMediaMessageToUserWithAllInvalidInputs error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //29.Sending Media message to user with metadata
    func test061SendMediaMessageToUserWithMetadata() {
        let expectation = self.expectation(description: "Sending Media message to user with metadata")
        let _mediaMessage = MediaMessage(receiverUid: TestConstants.user2, fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .image, receiverType: .user)
        _mediaMessage.metaData = ["key":"value"]
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToUserWithMetadata successful: \(mediaMessage.stringValue())")
            XCTAssertNotNil(mediaMessage)
            expectation.fulfill()
        }) { (error) in
            print("testSendMediaMessageToUserWithMetadata error :\(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //30. Sending Media message to group with metadata
    func test062SendMediaMessageToGroupWithMetadata() {
        let expectation = self.expectation(description: "Sending Media message to group with metadata")
        let _mediaMessage = MediaMessage(receiverUid: TestConstants.grpPublic1, fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .image, receiverType: .group)
        _mediaMessage.metaData = ["key":"value"]
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToGroupWithMetadata successful: \(mediaMessage.stringValue())")
            XCTAssertNotNil(mediaMessage)
            expectation.fulfill()
        }) { (error) in
            print("testSendMediaMessageToGroupWithMetadata error :\(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //31.Sending Media message to user with muid
    func test063SendMediaMessageToUserWithMuid() {
        let expectation = self.expectation(description: "Sending Media message to user with metadata")
        let _mediaMessage = MediaMessage(receiverUid: TestConstants.user2, fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .image, receiverType: .user)
        _mediaMessage.muid = "12"
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToUserWithMuid successful: \(mediaMessage.muid)")
           XCTAssertEqual(mediaMessage.muid, "12")
            expectation.fulfill()
        }) { (error) in
            print("testSendMediaMessageToUserWithMuid error :\(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //32. Sending Media message to group with muid
    func test064SendMediaMessageToGroupWithMuid() {
        let expectation = self.expectation(description: "Sending Media message to group with metadata")
        let _mediaMessage = MediaMessage(receiverUid: TestConstants.grpPublic1, fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .image, receiverType: .group)
         _mediaMessage.muid = "12"
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            print("testSendMediaMessageToGroupWithMuid successful: \(mediaMessage.muid)")
           XCTAssertEqual(mediaMessage.muid, "12")
            expectation.fulfill()
        }) { (error) in
            print("testSendMediaMessageToGroupWithMuid error :\(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
////////////////////////////////////////////////////////////////////////////////////////////
    
///////////////////////////   COMETCHATPRO: CUSTOM MESSAGES  ///////////////////////////////
   
    //1. Sending Custom message to user with AllValidInputs
    func test065SendCustomMessageToUserWithAllValidInputs(){
        let expectation = self.expectation(description: "Sending Custom message to user with AllValidInputs")
        
        let _customMessage = CustomMessage(receiverUid: TestConstants.user2, receiverType: .user, customData: ["hello":"lksd"], type: "hello")

        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMessageToUserWithAllValidInputs successful: \(customMessage.stringValue())")
            XCTAssertNotNil(customMessage)
            expectation.fulfill()
        }) { (error) in
            print("testSendCustomMessageToUserWithAllValidInputs error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //2. Sending Custom message to group with AllValidInputs
    func test066SendCustomMessageToGroupWithAllValidInputs(){
        let expectation = self.expectation(description: "Sending Custom message to group with AllValidInputs")
        let _customMessage = CustomMessage(receiverUid: TestConstants.grpPublic1, receiverType: .group, customData: ["hello":"lksd"], type: "hello")
        
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMessageToGroupWithAllValidInputs successful: \(customMessage.stringValue())")
            XCTAssertNotNil(customMessage)
            expectation.fulfill()
        }) { (error) in
            print("testSendCustomMessageToGroupWithAllValidInputs error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    //3.Sending Custom message to user with empty receiverUid
    func test067SendCustomMessageToUserWithEmptyReceiverUid(){
        let expectation = self.expectation(description: "Sending Custom message to user with empty receiverUid")
        
        let _customMessage = CustomMessage(receiverUid: "", receiverType: .user, customData: ["customKey":"customValue"], type: "hello")
        
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMessageToUserWithEmptyReceiverUid successful: \(customMessage.stringValue())")
            
        }) { (error) in
            print("testSendCustomMessageToUserWithEmptyReceiverUid error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //4.Sending Custom message to group with empty receiverUid
    func test068SendCustomMessageToGroupWithEmptyReceiverUid(){
        let expectation = self.expectation(description: "Sending Custom message to group with empty receiverUid")
        let _customMessage = CustomMessage(receiverUid: "", receiverType: .group, customData: ["customKey":"customValue"], type: "hello")
        
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMessageToUserWithEmptyReceiverUid successful: \(customMessage.stringValue())")
           
        }) { (error) in
            print("testSendCustomMessageToUserWithEmptyReceiverUid error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //5.Sending Custom message to user with empty  customData
    func test069SendCustomMessageToUserWithEmptyStingsInCustomData(){
        let expectation = self.expectation(description: "SSending Custom message to user with empty  customData")
        
        let _customMessage = CustomMessage(receiverUid: TestConstants.user2, receiverType: .user, customData: ["":""], type: "hello")
        
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMessageToUserWithEmptyCustomData successful: \(customMessage.stringValue())")
            XCTAssertNotNil(customMessage)
            expectation.fulfill()
        }) { (error) in
            print("testSendCustomMessageToUserWithEmptyCustomData error: \(String(describing: error?.errorDescription))")
           
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //6.Sending Custom message to group with empty  customData
    func test070SendCustomMessageToGroupWithEmptyStringsInCustomData(){
        let expectation = self.expectation(description: "Sending Custom message to group with empty  customData")
    
        let _customMessage = CustomMessage(receiverUid: TestConstants.grpPublic1, receiverType: .group, customData: ["":""], type: "hello")
        
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMessageToGroupWithEmptyCustomData successful: \(customMessage.stringValue())")
            XCTAssertNotNil(customMessage)
            expectation.fulfill()
        }) { (error) in
            print("testSendCustomMessageToGroupWithEmptyCustomData error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //7. Sending Custom message to user with Invalid receiver Type
    func test071SendCustomMessageToUserWithInvalidReceiverType(){
        let expectation = self.expectation(description: "Sending Custom message to user with Invalid receiver Type")
        
         let _customMessage = CustomMessage(receiverUid: TestConstants.user2, receiverType: .group, customData: ["customKey":"customValue"], type: "hello")
        
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMessageToUserWithInvalidReceiverType successful: \(customMessage.stringValue())")
            
        }) { (error) in
            print("testSendCustomMessageToUserWithInvalidReceiverType error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    //8. Sending Custom message to group with Invalid receiver Type
    func test072SendCustomMessageToGroupWithInvalidReceiverType(){
        let expectation = self.expectation(description: "Sending Custom message to group with Invalid receiver Type")
         let _customMessage = CustomMessage(receiverUid: TestConstants.grpPublic1, receiverType: .user, customData: ["customKey":"customValue"], type: "hello")
        
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMessageToGroupWithInvalidReceiverType successful: \(customMessage.stringValue())")
            
        }) { (error) in
            print("testSendCustomMessageToGroupWithInvalidReceiverType error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //9. Sending Custom message to user with Invalid receiver Type & Empty CustomData
    func test073SendCustomMessageToUserWithInvalidReceiverTypeAndEmptyCustomData(){
        let expectation = self.expectation(description: "Sending Custom message to user with Invalid receiver Type & Empty CustomData")
        
         let _customMessage = CustomMessage(receiverUid: TestConstants.user2, receiverType: .group, customData:["":""], type: "hello")
        
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMessageToUserWithInvalidReceiverTypeAndEmptyCustomData successful: \(customMessage.stringValue())")
            
        }) { (error) in
            print("testSendCustomMessageToUserWithInvalidReceiverTypeAndEmptyCustomData error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    //10. Sending Custom message to group with Invalid receiver Type & Empty CustomData
    func test074SendCustomMessageToGroupWithInvalidReceiverTypeAndEmptyCustomData(){
        let expectation = self.expectation(description: "Sending Custom message to group with Invalid receiver Type & Empty CustomData")
        let _customMessage = CustomMessage(receiverUid: TestConstants.grpPublic1, receiverType: .user, customData: ["":""],type: "hello")
        
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMessageToGroupWithInvalidReceiverTypeAndEmptyCustomData successful: \(customMessage.stringValue())")
            
        }) { (error) in
            print("testSendCustomMessageToGroupWithInvalidReceiverTypeAndEmptyCustomData error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //11.Sending Custom message to user with Invalid receiverUid
    func test075SendCustomMessageToUserWithInvalidReceiverUID(){
        let expectation = self.expectation(description: "Sending Custom message to user with Invalid receiverUid")
        let _customMessage = CustomMessage(receiverUid: "INVALID", receiverType: .user, customData: ["customKey":"customValue"], type: "hello")
        
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMessageToUserWithInvalidReceiverUID successful: \(customMessage.stringValue())")
            
        }) { (error) in
            print("testSendCustomMessageToUserWithInvalidReceiverUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //12.Sending Custom message to group with Invalid receiverUid
    func test076SendCustomMessageToGroupWithInvalidReceiverUID(){
        let expectation = self.expectation(description: "Sending Custom message to group with Invalid receiverUid")
        let _customMessage = CustomMessage(receiverUid: "INVALID", receiverType: .group, customData: ["customKey":"customValue"], type: "hello")
        
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMessageToGroupWithInvalidReceiverUID successful: \(customMessage.stringValue())")
            
        }) { (error) in
            print("testSendCustomMessageToGroupWithInvalidReceiverUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //13.Sending Custom message to user with Invalid receiverUid & Empty customData
    func test077SendCustomMessageToUserWithInvalidReceiverUIDAndEmptyCustomData(){
        let expectation = self.expectation(description: "Sending Custom message to user with Invalid receiverUid & Empty customData")
        let _customMessage = CustomMessage(receiverUid: "INVALID", receiverType: .user, customData: ["":""], type: "hello")
        
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMessageToUserWithInvalidReceiverUIDAndEmptyCustomData successful: \(customMessage.stringValue())")
            
        }) { (error) in
            print("testSendCustomMessageToUserWithInvalidReceiverUIDAndEmptyCustomData error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //14.Sending Custom message to group with Invalid receiverUid & Empty mediaURL
    func test078SendCustomMessageToGroupWithInvalidReceiverUIDAndEmptyCustomData(){
        let expectation = self.expectation(description: "Sending Custom message to user with Invalid receiverUid & Empty customData")
        let _customMessage = CustomMessage(receiverUid: "INVALID", receiverType: .group, customData: ["":""], type: "hello")
        
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMessageToGroupWithInvalidReceiverUIDAndEmptyCustomData successful: \(customMessage.stringValue())")
            
        }) { (error) in
            print("testSendCustomMessageToGroupWithInvalidReceiverUIDAndEmptyCustomData error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //15.Sending Custom message to user with all Invalid Inputs
    func test079SendCustomMessageToUserWithAllInvalidInputs(){
        let expectation = self.expectation(description: "Sending Custom message to user with all Invalid Inputs")
        let _customMessage = CustomMessage(receiverUid: "INVALID", receiverType: .group, customData: ["INVALID":"INVALID"], type: "hello")
        
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMessageToUserWithAllInvalidInputs successful: \(customMessage.stringValue())")
            
        }) { (error) in
            print("testSendCustomMessageToUserWithAllInvalidInputs error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }


    //16.Sending Custom message to group with with all Invalid Inputs
    func test080SendCustomMessageToGroupWithAllInvalidInputs(){
        let expectation = self.expectation(description: "Sending Custom message to user with all Invalid Inputs")
        let _customMessage = CustomMessage(receiverUid: "INVALID", receiverType: .user, customData: ["INVALID":"INVALID"], type: "hello")
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMessageToUserWithAllInvalidInputs successful: \(customMessage.stringValue())")
            
        }) { (error) in
            print("testSendCustomMessageToUserWithAllInvalidInputs error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //17.Sending Custom message to user with metadata
    func test081SendCustomMessageToUserWithMetadata(){
        let expectation = self.expectation(description: "Sending Custom message to user with metadata")
        let _customMessage = CustomMessage(receiverUid: TestConstants.user2, receiverType: .user, customData: ["customKey":"customValue"], type: "hello")
        _customMessage.metaData = ["key":"value"]
        
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMessageToUserWithMetadata successful: \(customMessage.stringValue())")
            XCTAssertNotNil(customMessage)
            expectation.fulfill()
        }) { (error) in
            print("testSendCustomMessageToUserWithMetadata error: \(String(describing: error?.errorDescription))")
           
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //18. Sending Custom message to group with metadata
    func test082SendCustomMessageToGroupWithMetadata(){
        let expectation = self.expectation(description: "Sending Custom message to group with metadata")
        let _customMessage = CustomMessage(receiverUid: TestConstants.grpPublic1, receiverType: .group, customData: ["customKey":"customValue"], type: "hello")
        _customMessage.metaData = ["key":"value"]
        
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMessageToGroupWithMetadata successful: \(customMessage.stringValue())")
            XCTAssertNotNil(customMessage)
            expectation.fulfill()
        }) { (error) in
            print("testSendCustomMessageToGroupWithMetadata error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    //19.Sending Custom message to user with muid
    func test083SendCustomMessageToUserWithMuid(){
        let expectation = self.expectation(description: "Sending Custom message to user with muid")
        let _customMessage = CustomMessage(receiverUid: TestConstants.user2, receiverType: .user, customData: ["customKey":"customValue"], type: "hello")
        _customMessage.muid = "12"
        
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMessageToUserWithMetadata successful: \(customMessage.stringValue())")
            XCTAssertEqual(customMessage.muid, "12")
            expectation.fulfill()
        }) { (error) in
            print("testSendCustomMessageToUserWithMetadata error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //20. Sending Custom message to group with muid
    func test084SendCustomMessageToGroupWithMuid(){
        let expectation = self.expectation(description: "Sending Custom message to group with muid")
        let _customMessage = CustomMessage(receiverUid: TestConstants.grpPublic1, receiverType: .group, customData: ["customKey":"customValue"], type: "hello")
        _customMessage.muid = "12"
        
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMessageToGroupWithMuid successful: \(customMessage.stringValue())")
            XCTAssertEqual(customMessage.muid, "12")
            expectation.fulfill()
        }) { (error) in
            print("testSendCustomMessageToGroupWithMuid error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //21. Sending Custom message to user with Empty Custom Data
    func test085SendCustomMesssageToUserWithEmptyCustomData() {
        
        let expectation = self.expectation(description: "Sending Custom message to user with Empty Custom Data")
        let _customMessage = CustomMessage(receiverUid: TestConstants.user2, receiverType: .user, customData : [:], type: "hello")
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            print("testSendCustomMesssageToUserWithEmptyCustomData successful: \(customMessage.stringValue())")
            
        }) { (error) in
            print("testSendCustomMesssageToUserWithEmptyCustomData error :\(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    
    //21. Sending Custom message to group with Empty Custom Data
    func test086SendCustomMesssageToGroupWithEmptyCustomData() {
        
        let expectation = self.expectation(description: "SSending Custom message to group with Empty Custom Data")
        
        let _customMessage = CustomMessage(receiverUid: TestConstants.grpPublic1, receiverType: .group, customData : [:], type: "hello")
        CometChat.sendCustomMessage(message: _customMessage, onSuccess: { (customMessage) in
            
            print("testSendCustomMesssageToGroupWithEmptyCustomData successful: \(customMessage.stringValue())")
            
        }) { (error) in
            
            print("testSendCustomMesssageToGroupWithEmptyCustomData error :\(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
 
////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////  COMETCHATPRO: EDIT MESSAGES  ///////////////////////////
    
    
    //1. Sending edit message to user with All Valid inputs
    func test087EditTextMessageToUserWithAllValidInputs() {
        
        let expectation = self.expectation(description: "Sending edit message to user with All Valid inputs")
        let _textMessage = TextMessage(receiverUid: TestConstants.user2, text: "this is normal text",  receiverType: .user)
        
         CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            print("sendTextMessage Success")
            let editMessage = TextMessage(receiverUid: TestConstants.user2, text: "this is Edited text",  receiverType: .user)
             editMessage.id = textMessage.id
           
        CometChat.editMessage(editMessage, onSuccess: { (editedMessage) in
                print("testEditTextMessageToUserWithAllValidInputs sucess: \(String(describing: editedMessage))")
                XCTAssertNotNil(editedMessage)
                expectation.fulfill()
            }, onError: { (error) in
                print("testEditTextMessageToUserWithAllValidInputs error:\(String(describing: error.errorDescription))")
            })
        }) { (error) in
            print("sendTextMessage error \(String(describing: error?.errorDescription))")
        }
       wait(for: [expectation], timeout: 10)
    }
    
    //2. Sending edit message to group with All Valid inputs
    func test088EditTextMessageToGroupWithAllValidInputs() {
        
        let expectation = self.expectation(description: "Sending edit message to group with All Valid inputs")
       let _textMessage = TextMessage(receiverUid: TestConstants.grpPublic1, text: "this is normal text",  receiverType: .group)
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
             print("sendTextMessage Success")
            let editMessage = TextMessage(receiverUid: TestConstants.grpPublic1, text: "this is Edited text",  receiverType: .group)
            editMessage.id = textMessage.id
            CometChat.editMessage(editMessage, onSuccess: { (editedMessage) in
                print("testEditTextMessageToGroupWithAllValidInputs sucess: \(String(describing: editedMessage))")
                XCTAssertNotNil(editedMessage)
                expectation.fulfill()
            }, onError: { (error) in
                print("testEditTextMessageToGroupWithAllValidInputs error:\(String(describing: error.errorDescription))")
            })
        }) { (error) in
            print("sendTextMessage error \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //3. Sending edit message to user without messageID
    func test089EditTextMessageToUserWithoutMessageID() {
        let expectation = self.expectation(description: "Sending edit message to user without messageID")
        let _textMessage = TextMessage(receiverUid: TestConstants.user2, text: "this is normal text",  receiverType: .user)
       CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            print("sendTextMessage Success")
            let editMessage = TextMessage(receiverUid: TestConstants.user2, text: "this is Edited text",  receiverType: .user)
            CometChat.editMessage(editMessage, onSuccess: { (editedMessage) in
                print("testEditTextMessageToUserWithoutMessageID sucess: \(String(describing: editedMessage))")
                }, onError: { (error) in
                print("testEditTextMessageToUserWithoutMessageID error:\(String(describing: error.errorDescription))")
                XCTAssertNotNil(error)
                 expectation.fulfill()
            })
        }) { (error) in
            print("sendTextMessage error \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //4. Sending edit message to group without messageID
    func test090EditTextMessageToGroupWithoutMessageID() {
        let expectation = self.expectation(description: "Sending edit message to group without messageID")
        let _textMessage = TextMessage(receiverUid: TestConstants.grpPublic1, text: "this is normal text",  receiverType: .group)
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            print("sendTextMessage Success")
            let editMessage = TextMessage(receiverUid: TestConstants.grpPublic1, text: "this is Edited text",  receiverType: .group)
            CometChat.editMessage(editMessage, onSuccess: { (editedMessage) in
                 print("testEditTextMessageToGroupWithoutMessageID sucess: \(String(describing: editedMessage))")
            }, onError: { (error) in
                print("testEditTextMessageToGroupWithoutMessageID error:\(String(describing: error.errorDescription))")
                XCTAssertNotNil(error)
                expectation.fulfill()
            })
        }) { (error) in
            print("sendTextMessage error \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
   //5. Sending edit message to user with Invalid messageID
    func test091EditTextMessagesToUserWithInvalidMessageID() {
        
        let expectation = self.expectation(description: "Sending edit message to user with Invalid messageID")
        
        let _textMessage = TextMessage(receiverUid: TestConstants.user2, text: "this is normal text",  receiverType: .user)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessage Success")
            let editMessage = TextMessage(receiverUid: TestConstants.user2, text: "this is Edited text",  receiverType: .user)
            editMessage.id = 12345678910
            
            CometChat.editMessage(editMessage, onSuccess: { (editedMessage) in
                
                print("editTextMessagesToUserWithInvalidMessageID sucess: \(String(describing: editedMessage))")
                
            }, onError: { (error) in
                
                print("editTextMessagesToUserWithInvalidMessageID error:\(String(describing: error.errorDescription))")
                XCTAssertNotNil(error)
                expectation.fulfill()
            })
        }) { (error) in
            print("sendTextMessage error \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    //6. Sending edit message to group with Invalid messageID
    func test092EditTextMessagesToGroupWithInvalidMessageID() {
        
        let expectation = self.expectation(description: "Sending edit message to group with Invalid messageID")
        
        let _textMessage = TextMessage(receiverUid: TestConstants.grpPublic1, text: "this is normal text",  receiverType: .group)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            
            print("sendTextMessage Success")
            let editMessage = TextMessage(receiverUid: TestConstants.grpPublic1, text: "this is Edited text",  receiverType: .group)
            editMessage.id = 12345678910
            
            CometChat.editMessage(editMessage, onSuccess: { (editedMessage) in
                
                print("editTextMessagesToGroupWithInvalidMessageID sucess: \(String(describing: editedMessage))")
                
            }, onError: { (error) in
                
                print("editTextMessagesToGroupWithInvalidMessageID error:\(String(describing: error.errorDescription))")
                XCTAssertNotNil(error)
                expectation.fulfill()
            })
        }) { (error) in
            print("sendTextMessage error \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    
    
     //7. Sending edit message to user with Invalid messageType
    func test093EditTextMessagesToUserWithInvalidMessageType() {
        //Discarded
    }
    
    //8. Sending edit message to group with Invalid messageType
    func test094EditTextMessagesToGroupWithInvalidMessageType() {
       //Discarded
    }
    
    
    //9. Sending edit message to User with Invalid receiverUID
    func test095EditTextMessagesToUserWithInvalidReceiverUID() {
       //Discarded
    }
    
     //10. Sending edit message to Group with Invalid receiverUID
    func test096EditTextMessagesToGroupsWithInvalidReceiverUID() {
       //Discarded
    }

    
////////////////////////////////////////////////////////////////////////////////////////////
    
///////////////////////////   COMETCHATPRO: DELETE MESSAGES  //////////////////////////////
   
    
    
    //1. Sending Delete Text message to user  with valid inputs
    func test097DeleteTextMessageToUserWithAllValidInputs() {
        let expectation = self.expectation(description: "Sending Delete message to user  with valid inputs")
        let _textMessage = TextMessage(receiverUid: TestConstants.user2, text: "this is normal text",  receiverType: .user)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            CometChat.delete(byMessageId: textMessage.id, onSuccess: { (deletedMessage) in
                print("testDeleteTextMessageToUserWithAllValidInputs sucess: \(String(describing: deletedMessage))")
                XCTAssertNotNil(deletedMessage)
                expectation.fulfill()
            }, onError: { (error) in
                print("testDeleteTextMessageToUserWithAllValidInputs error:\(String(describing: error.errorDescription))")
            })
        }) { (error) in
            print("sendTextMessage error \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //2. Sending Delete Text message to group with  Valid inputs
    func test098DeleteTextMessageToGroupWithAllValidInputs() {
        let expectation = self.expectation(description: "Sending Delete message to user  with valid inputs")
        let _textMessage = TextMessage(receiverUid: TestConstants.grpPublic1, text: "this is normal text",  receiverType: .group)
        
        CometChat.sendTextMessage(message: _textMessage, onSuccess: { (textMessage) in
            CometChat.delete(byMessageId: textMessage.id, onSuccess: { (deletedMessage) in
                print("testDeleteTextMessageToGroupWithAllValidInputs sucess: \(String(describing: deletedMessage))")
                XCTAssertNotNil(deletedMessage)
                expectation.fulfill()
            }, onError: { (error) in
                print("testDeleteTextMessageToGroupWithAllValidInputs error:\(String(describing: error.errorDescription))")
            })
        }) { (error) in
            print("sendTextMessage error \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //3. Sending Delete Text message with Invalid messageID.
    func test099DeleteTextMessageWithInvalidMessageID() {
        let expectation = self.expectation(description: "Sending Delete message to user with Invalid messageID.")
        CometChat.delete(byMessageId: 12345678910, onSuccess: { (deletedMessage) in
            print("deleteTextMessageToUserWithInvalidMessageID sucess: \(String(describing: deletedMessage))")
        }, onError: { (error) in
            print("deleteTextMessageToUserWithInvalidMessageID error:\(String(describing: error.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10)
    }
    

     //4. Sending Delete Media message to user  with valid inputs
    func test100DeleteMediaMessageToUser() {
        
        let expectation = self.expectation(description: "Send a text message with valid Receiver Id")
        
        let _mediaMessage = MediaMessage(receiverUid: TestConstants.user2, fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .image, receiverType: .user)
        
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            
            CometChat.delete(byMessageId: mediaMessage.id, onSuccess: { (deletedMessage) in
               
                print("deleteMediaMessageToUser sucess: \(String(describing: deletedMessage))")
                
                XCTAssertNotNil(deletedMessage)
                
                expectation.fulfill()
                
            }, onError: { (error) in
                
                  print("deleteMediaMessageToUser error:\(String(describing: error.errorDescription))")
            })
            
        }) { (error) in
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //5. Sending Delete Media message to group  with valid inputs
    func test101DeleteMediaMessageToGroup() {
        let expectation = self.expectation(description: "Send a text message with valid Receiver Id")
        let _mediaMessage = MediaMessage(receiverUid: TestConstants.grpPublic1, fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .image, receiverType: .group)
        CometChat.sendMediaMessage(message: _mediaMessage, onSuccess: { (mediaMessage) in
            CometChat.delete(byMessageId: mediaMessage.id, onSuccess: { (deletedMessage) in
                print("deleteMediaMessageToUser sucess: \(String(describing: deletedMessage))")
                XCTAssertNotNil(deletedMessage)
                expectation.fulfill()
            }, onError: { (error) in
                print("deleteMediaMessageToUser error:\(String(describing: error.errorDescription))")
            })
        }) { (error) in
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //6. Sending Delete Custom message to user  with valid inputs
    func test102DeleteCustomMessageToUser() {
        let expectation = self.expectation(description: "Sending Delete Custom message to user  with valid inputs")
        let customMessage = CustomMessage(receiverUid: TestConstants.user2, receiverType: .user, customData: ["key":"value"], type: "hello")
        CometChat.sendCustomMessage(message: customMessage, onSuccess: { (CustomMessage) in
            CometChat.delete(byMessageId: CustomMessage.id, onSuccess: { (deletedMessage) in
                 print("testDeleteCustomMessageToUser sucess: \(String(describing: deletedMessage))")
                XCTAssertNotNil(deletedMessage)
                expectation.fulfill()
            }, onError: { (error) in
                print("testDeleteCustomMessageToUser error:\(String(describing: error.errorDescription))")
            })
        }) { (error) in
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //7. Sending Delete Custom message to group  with valid inputs
    func test103DeleteCustomMessageToGroup() {
        let expectation = self.expectation(description: "Sending Delete Custom message to user  with valid inputs")
        let customMessage = CustomMessage(receiverUid: TestConstants.grpPublic1, receiverType: .group, customData: ["key":"value"], type: "hello")
        CometChat.sendCustomMessage(message: customMessage, onSuccess: { (CustomMessage) in
            CometChat.delete(byMessageId: CustomMessage.id, onSuccess: { (deletedMessage) in
                print("testDeleteCustomMessageToGroup sucess: \(String(describing: deletedMessage))")
                XCTAssertNotNil(deletedMessage)
               expectation.fulfill()
            }, onError: { (error) in
                print("testDeleteCustomMessageToGroup error:\(String(describing: error.errorDescription))")
            })
        }) { (error) in
        }
        wait(for: [expectation], timeout: 10)
    }

////////////////////////////////////////////////////////////////////////////////////////////
    
////////////////////////////  COMETCHATPRO: FETCH MESSAGES  ///////////////////////////////
    
    
    //1. Fetching messages for user with valid limit
    func test104FetchMessagesForUserWithValidLimit(){
        
        let expectation = self.expectation(description: "test fetch messages for user with valid limit")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(uid: TestConstants.user2).set(limit: 20).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("fetchMessagesForUserWithValidLimit sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
            
        }) { (error) in
            
              print("fetchMessagesForUserWithValidLimit sucess: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //2. Fetching messages for group with valid limit
    func test105FetchMessagesForGroupWithValidLimit(){
        
        let expectation = self.expectation(description: "test fetch messages for group with valid limit")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(guid: TestConstants.grpPublic1).set(limit: 20).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("fetchMessagesForGroupWithValidLimit sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
            
        }) { (error) in
            
            print("fetchMessagesForGroupWithValidLimit sucess: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //3. Fetching messages for users with Invalid limit
    func test106FetchMessagesForUsersWithInValidLimit(){
        
//        let expectation = self.expectation(description: "test fetch messages for user with invalid limit")
//        let messageRequest = MessagesRequest.MessageRequestBuilder().set(uid: TestConstants.user2).set(limit: 1000).build()
//
//        messageRequest.fetchPrevious(onSuccess: { (messages) in
//
//            print("fetchMessagesForUsersWithInValidLimit sucess: \(String(describing: messages))")
//
//
//        }) { (error) in
//
//            print("fetchMessagesForUsersWithInValidLimit sucess: \(String(describing: error?.errorDescription))")
//            XCTAssertNotNil(error)
//            expectation.fulfill()
//
//        }
//        wait(for: [expectation], timeout: 10)
    }
    
    //4. Fetching messages for group with Inalid limit
    func test107FetchMessagesForGroupsWithInValidLimit(){
        
//        let expectation = self.expectation(description: "test fetch messages for group with invalid limit")
//        let messageRequest = MessagesRequest.MessageRequestBuilder().set(guid: TestConstants.grpPublic1).set(limit: 1000).build()
//
//        messageRequest.fetchPrevious(onSuccess: { (messages) in
//
//            print("fetchMessagesForGroupsWithInValidLimit sucess: \(String(describing: messages))")
//            XCTAssertNotNil(messages)
//            expectation.fulfill()
//
//        }) { (error) in
//
//            print("fetchMessagesForGroupsWithInValidLimit sucess: \(String(describing: error?.errorDescription))")
//
//        }
//        wait(for: [expectation], timeout: 10)
    }
    
    
    //5. Fetching messages for user with zero limit
    func test108FetchMessagesForUsersWithZeroLimit(){
        
        let expectation = self.expectation(description: "test fetch messages for user with invalid limit")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(uid: TestConstants.user2).set(limit: 0).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("fetchMessagesForUsersWithInValidLimit sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
            
        }) { (error) in
            
            print("fetchMessagesForUsersWithInValidLimit error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
     //6. Fetching messages for group with zero limit
    func test109FetchMessagesForGroupsWithZeroLimit(){
        
        let expectation = self.expectation(description: "test fetch messages for group with invalid limit")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(guid: TestConstants.grpPublic1).set(limit: 0).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("fetchMessagesForGroupsWithInValidLimit sucess: \(String(describing: messages))")
            
       }) { (error) in
            
            print("fetchMessagesForGroupsWithInValidLimit sucess: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
     //7. Fetching messages for user with minus limit
    func test110FetchMessagesForUsersWithMinusLimit(){
        
        let expectation = self.expectation(description: "test fetch messages for group with minus limit")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(uid: TestConstants.user2).set(limit: -1).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("fetchMessagesForUsersWithMinusLimit sucess: \(String(describing: messages))")
            
        }) { (error) in
            
            print("fetchMessagesForUsersWithMinusLimit error: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
     //8. Fetching messages for group with zero limit
    func test112FetchMessagesForGroupsWithMinusLimit(){
        
        let expectation = self.expectation(description: "test fetch messages for group with minus limit")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(guid: TestConstants.grpPublic1).set(limit: -1).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("fetchMessagesForGroupsWithMinusLimit sucess: \(String(describing: messages))")
            
        }) { (error) in
            
            print("fetchMessagesForGroupsWithMinusLimit error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
     //9. Fetching messages for user with no limit
    func test113FetchMessagesForUsersWithNoLimit(){
        
        let expectation = self.expectation(description: "test fetch messages for group with minus limit")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(uid: TestConstants.user2).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("fetchMessagesForUsersWithNoLimit sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
        }) { (error) in
            
            print("fetchMessagesForUsersWithNoLimit error: \(String(describing: error?.errorDescription))")
            
           
        }
        wait(for: [expectation], timeout: 10)
    }
    
     //10. Fetching messages for groups with zero limit
    func test114FetchMessagesForGroupsWithNoLimit(){
        
        let expectation = self.expectation(description: "test fetch messages for group with minus limit")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(guid: TestConstants.grpPublic1).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("fetchMessagesForGroupsWithNoLimit sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
        }) { (error) in
            
            print("fetchMessagesForGroupsWithNoLimit error: \(String(describing: error?.errorDescription))")
          
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test115FetchMessagesForGroupsWithInvalidGUID(){
        
        let expectation = self.expectation(description: "test fetch messages for group with invalid GUID")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(guid: "INVALID").build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForGroupsWithInvalidGUID sucess: \(String(describing: messages))")
    
        }) { (error) in
            print("testFetchMessagesForGroupsWithInvalidGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test116FetchMessagesForGroupsWithEmptyGUID(){
        
        let expectation = self.expectation(description: "test fetch messages for group with Empty GUID")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(guid: "").build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForGroupsWithEmptyGUID sucess: \(String(describing: messages))")
            
        }) { (error) in
            print("testFetchMessagesForGroupsWithEmptyGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test117FetchMessagesForUsersWithInvalidUID(){
        
        let expectation = self.expectation(description: "test fetch messages for users with invalid UID")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(uid: "INVALID").build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForUsersWithInvalidUID sucess: \(String(describing: messages))")
            
        }) { (error) in
            print("testFetchMessagesForUsersWithInvalidUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test118FetchMessagesForUsersWithEmptyUID(){
        
        let expectation = self.expectation(description: "test fetch messages for user with Empty GUID")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(uid: "").build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForUsersWithEmptyUID sucess: \(String(describing: messages))")
            
        }) { (error) in
            print("testFetchMessagesForUsersWithEmptyUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
  
    func test119FetchMessagesForUsersWithSetMessageID(){
        
        let expectation = self.expectation(description: "testFetchMessagesForUsersWithSetMessageID")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(uid: TestConstants.user2).set(messageID: 5).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForUsersWithSetMessageID sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
        }) { (error) in
            
            print("testFetchMessagesForUsersWithSetMessageID error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test120FetchMessagesForUsersWithSetInvalidMessageID(){
        
        let expectation = self.expectation(description: "testFetchMessagesForUsersWithSetInvalidMessageID")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(uid: TestConstants.user2).set(messageID: 123456789).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForUsersWithSetInvalidMessageID sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
        }) { (error) in
            
            print("testFetchMessagesForUsersWithSetInvalidMessageID error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
 
    func test121FetchMessagesForGroupsWithSetMessageID(){
        
        let expectation = self.expectation(description: "testFetchMessagesForGroupsWithSetMessageID")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(guid: TestConstants.grpPublic1).set(messageID: 5).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForGroupsWithSetMessageID sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
        }) { (error) in
            
            print("testFetchMessagesForGroupsWithSetMessageID error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test122FetchMessagesForGroupsWithInvalidMessageID(){
        
        let expectation = self.expectation(description: "testFetchMessagesForGroupsWithInvalidMessageID")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(guid: TestConstants.grpPublic1).set(messageID: 123456789).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForGroupsWithInvalidMessageID sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
        }) { (error) in
            
            print("testFetchMessagesForGroupsWithInvalidMessageID error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test123FetchMessagesForUsersWithSetTimeStamp(){
        
        let expectation = self.expectation(description: "testFetchMessagesForUserssWithSetTimeStamp")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(uid: TestConstants.user2).set(timeStamp: Int(Date().timeIntervalSince1970 * 100)).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForUserssWithSetTimeStamp sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
        }) { (error) in
            
            print("testFetchMessagesForUserssWithSetTimeStamp error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test124FetchMessagesForGroupsWithSetTimeStamp(){
        
        let expectation = self.expectation(description: "testFetchMessagesForGroupsWithSetTimeStamp")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(guid: TestConstants.grpPublic1).set(timeStamp: Int(Date().timeIntervalSince1970 * 100)).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForGroupsWithSetTimeStamp sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
        }) { (error) in
            
            print("testFetchMessagesForGroupsWithSetTimeStamp error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test125FetchMessagesForUsersWithInvalidTimeStamp(){
        
        let expectation = self.expectation(description: "testFetchMessagesForUsersWithInvalidTimeStamp")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(uid: TestConstants.user2).set(timeStamp: 123456789101112).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForUsersWithInvalidTimeStamp sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
        }) { (error) in
            
            print("testFetchMessagesForUsersWithInvalidTimeStamp error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test126FetchMessagesForGroupsWithInvalidTimeStamp(){
        
        let expectation = self.expectation(description: "testFetchMessagesForGroupsWithInvalidTimeStamp")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(guid: TestConstants.grpPublic1).set(timeStamp: 123456789101112).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForGroupsWithInvalidTimeStamp sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
        }) { (error) in
            
            print("testFetchMessagesForGroupsWithInvalidTimeStamp error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test127FetchMessagesForUsersWithUnreadFlagTrue(){
        
        let expectation = self.expectation(description: "testFetchMessagesForUserssWithSetTimeStamp")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(uid: TestConstants.user2).set(unread: true).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForUserssWithSetTimeStamp sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
        }) { (error) in
            
            print("testFetchMessagesForUserssWithSetTimeStamp error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test128FetchMessagesForGroupsWithSetUnreadFlagTrue(){
        
        let expectation = self.expectation(description: "testFetchMessagesForGroupsWithSetUnreadFlagTrue")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(guid: TestConstants.grpPublic1).set(unread: true).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForGroupsWithSetUnreadFlagTrue sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
        }) { (error) in
            
            print("testFetchMessagesForGroupsWithSetUnreadFlagTrue error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test129FetchMessagesForUsersWithUnreadFlagFalse(){
        
        let expectation = self.expectation(description: "testFetchMessagesForUsersWithUnreadFlagFalse")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(uid: TestConstants.user2).set(unread: false).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForUsersWithUnreadFlagFalse sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
        }) { (error) in
            
            print("testFetchMessagesForUsersWithUnreadFlagFalse error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test130FetchMessagesForGroupsWithSetUnreadFlagFalse(){
        
        let expectation = self.expectation(description: "testFetchMessagesForGroupsWithSetUnreadFlagFalse")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(guid: TestConstants.grpPublic1).set(unread: false).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForGroupsWithSetUnreadFlagFalse sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
        }) { (error) in
            
            print("testFetchMessagesForGroupsWithSetUnreadFlagFalse error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    
    func test131FetchMessagesForUsersWithUndeliveredFlagTrue(){
        
        let expectation = self.expectation(description: "testFetchMessagesForUsersWithUndeliveredFlagTrue")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(uid: TestConstants.user2).set(undelivered: true).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForUsersWithUndeliveredFlagTrue sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
        }) { (error) in
            
            print("testFetchMessagesForUsersWithUndeliveredFlagTrue error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test132FetchMessagesForGroupsWithSetUndeliveredFlagTrue(){
        
        let expectation = self.expectation(description: "testFetchMessagesForGroupsWithSetUndeliveredFlagTrue")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(guid: TestConstants.grpPublic1).set(undelivered: true).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForGroupsWithSetUndeliveredFlagTrue sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
        }) { (error) in
            
            print("testFetchMessagesForGroupsWithSetUndeliveredFlagTrue error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test133FetchMessagesForUsersWithUndeliveredFlagFalse(){
        
        let expectation = self.expectation(description: "testFetchMessagesForUsersWithUndeliveredFlagFalse")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(uid: TestConstants.user2).set(undelivered: false).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForUsersWithUndeliveredFlagFalse sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
        }) { (error) in
            
            print("testFetchMessagesForUsersWithUndeliveredFlagFalse error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test134FetchMessagesForGroupsWithSetUndeliveredFlagFalse(){
        
        let expectation = self.expectation(description: "testFetchMessagesForGroupsWithSetUndeliveredFlagFalse")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(guid: TestConstants.grpPublic1).set(undelivered: false).build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForGroupsWithSetUndeliveredFlagFalse sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
        }) { (error) in
            
            print("testFetchMessagesForGroupsWithSetUndeliveredFlagFalse error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test135FetchMessagesForUsersWithAllInputs(){
        
        let expectation = self.expectation(description: "testFetchMessagesForUsersWithAllInputs")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(uid: TestConstants.user2).set(undelivered: true).set(unread: true).set(limit: 30).hideMessagesFromBlockedUsers(true).set(searchKeyword: "hi").build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForUsersWithAllInputs sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
        }) { (error) in
            
            print("testFetchMessagesForUsersWithAllInputs error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test136FetchMessagesForGroupsWithallInputs(){
        
        let expectation = self.expectation(description: "testFetchMessagesForGroupsWithallInputs")
        let messageRequest = MessagesRequest.MessageRequestBuilder().set(guid: TestConstants.grpPublic1).set(undelivered: true).set(unread: true).set(limit: 30).hideMessagesFromBlockedUsers(true).set(searchKeyword: "hi").build()
        
        messageRequest.fetchPrevious(onSuccess: { (messages) in
            
            print("testFetchMessagesForGroupsWithallInputs sucess: \(String(describing: messages))")
            XCTAssertNotNil(messages)
            expectation.fulfill()
        }) { (error) in
            
            print("testFetchMessagesForGroupsWithallInputs error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
////////////////////////////////////////////////////////////////////////////////////////////
    
/////////////////////////  COMETCHATPRO: UNREAD MESSAGE COUNT  /////////////////////////////
    

    func test137GetUnreadMessageCountForUser(){
      let expectation = self.expectation(description: "testGetUnreadMessageCountForUser")
      CometChat.getUnreadMessageCountForUser("superhero2", onSuccess: { (success) in
        print("testGetUnreadMessageCountForUser onSuccess: \(success)")
        XCTAssertNotNil(success)
        expectation.fulfill()
        }) { (error) in
            print("testGetUnreadMessageCountForUser error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test138GetUnreadMessageCountForUserWithEmptyUID(){
        let expectation = self.expectation(description: "testGetUnreadMessageCountForUserWithEmptyUID")
        CometChat.getUnreadMessageCountForUser("", onSuccess: { (success) in
            print("testGetUnreadMessageCountForUserWithEmptyUID onSuccess: \(success)")
           
        }) { (error) in
            print("testGetUnreadMessageCountForUserWithEmptyUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test139GetUnreadMessageCountForUserWithInvalidUID(){
        let expectation = self.expectation(description: "testGetUnreadMessageCountForUserWithInvalidUID")
        CometChat.getUnreadMessageCountForUser("INVALID", onSuccess: { (success) in
            print("testGetUnreadMessageCountForUserWithInvalidUID onSuccess: \(success)")
            
        }) { (error) in
            print("testGetUnreadMessageCountForUserWithInvalidUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test140GetUnreadMessageCountForGroup(){
        let expectation = self.expectation(description: "testGetUnreadMessageCountForGroup")
        CometChat.getUnreadMessageCountForGroup(TestConstants.grpPublic1, onSuccess: { (success) in
            print("testGetUnreadMessageCountForGroup onSuccess: \(success)")
            XCTAssertNotNil(success)
            expectation.fulfill()
        }) { (error) in
            print("testGetUnreadMessageCountForGroup error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test141GetUnreadMessageCountForGroupWithEmptyGUID(){
        let expectation = self.expectation(description: "testGetUnreadMessageCountForGroupWithEmptyGUID")
        CometChat.getUnreadMessageCountForGroup("", onSuccess: { (success) in
            print("testGetUnreadMessageCountForGroupWithEmptyGUID onSuccess: \(success)")
            
        }) { (error) in
            print("testGetUnreadMessageCountForGroupWithEmptyGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test142GetUnreadMessageCountForGroupWithInvalidGUID(){
        let expectation = self.expectation(description: "testGetUnreadMessageCountForGroupWithInvalidGUID")
        CometChat.getUnreadMessageCountForGroup("INVALID", onSuccess: { (success) in
            print("testGetUnreadMessageCountForGroupWithInvalidGUID onSuccess: \(success)")
            
        }) { (error) in
            print("testGetUnreadMessageCountForGroupWithInvalidGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test143GetUnreadMessageCountForAllUsers(){
    let expectation = self.expectation(description: "testGetUnreadMessageCountForAllUsers")
        CometChat.getUnreadMessageCountForAllUsers(onSuccess: { (success) in
            print("testGetUnreadMessageCountForAllUsers onSuccess: \(success)")
            XCTAssertNotNil(success)
            expectation.fulfill()
        }) { (error) in
             print("testGetUnreadMessageCountForAllUsers error: \(String(describing: error?.errorDescription))")
        }
         wait(for: [expectation], timeout: 10)
    }
    
    func test144GetUnreadMessageCountForAllGroups(){
        let expectation = self.expectation(description: "testGetUnreadMessageCountForAllGroups")
        CometChat.getUnreadMessageCountForAllGroups(onSuccess: { (success) in
            print("testGetUnreadMessageCountForAllGroups onSuccess: \(success)")
            XCTAssertNotNil(success)
            expectation.fulfill()
        }) { (error) in
            print("testGetUnreadMessageCountForAllGroups error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test145GetUnreadMessageCount(){
     let expectation = self.expectation(description: "testGetUnreadMessageCount")
        CometChat.getUnreadMessageCount(onSuccess: { (success) in
            print("testGetUnreadMessageCount onSuccess: \(success)")
            XCTAssertNotNil(success)
            expectation.fulfill()
        }) { (error) in
             print("testGetUnreadMessageCount error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test146GetUnreadMessageCountFilterByHideBlockedUsersTrue(){
         let expectation = self.expectation(description: "testGetUnreadMessageCountFilterByHideBlockedUsersTrue")
        CometChat.getUnreadMessageCount(hideMessagesFromBlockedUsers: true, onSuccess: { (success) in
            print("testGetUnreadMessageCountFilterByHideBlockedUsersTrue onSuccess: \(success)")
            XCTAssertNotNil(success)
            expectation.fulfill()
        }) { (error) in
              print("testGetUnreadMessageCountFilterByHideBlockedUsersTrue error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test147GetUnreadMessageCountFilterByHideBlockedUsersFalse(){
           let expectation = self.expectation(description: "testGetUnreadMessageCountFilterByHideBlockedUsersFalse")
        CometChat.getUnreadMessageCount(hideMessagesFromBlockedUsers: false, onSuccess: { (success) in
            print("testGetUnreadMessageCountFilterByHideBlockedUsersFalse onSuccess: \(success)")
            XCTAssertNotNil(success)
            expectation.fulfill()
        }) { (error) in
            print("testGetUnreadMessageCountFilterByHideBlockedUsersFalse error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
/////////////////////////////////////////////////////////////////////////////////////////////
    

///////////////////  COMETCHATPRO: UNDELIVERED MESSAGE COUNT  /////////////////////////////

    
    func test151GetUndeliveredMessageCountForUser(){
        let expectation = self.expectation(description: "testGetUndeliveredMessageCountForUser")
        CometChat.getUndeliveredMessageCountForUser("superhero2", onSuccess: { (success) in
            print("testGetUndeliveredMessageCountForUser onSuccess: \(success)")
            XCTAssertNotNil(success)
            expectation.fulfill()
        }) { (error) in
            print("testGetUndeliveredMessageCountForUser error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test152GetUndeliveredMessageCountForUserWithEmptyUID(){
        let expectation = self.expectation(description: "testGetUndeliveredMessageCountForUserWithEmptyUID")
        CometChat.getUndeliveredMessageCountForUser("", onSuccess: { (success) in
            print("testGetUndeliveredMessageCountForUserWithEmptyUID onSuccess: \(success)")
            
        }) { (error) in
            print("testGetUndeliveredMessageCountForUserWithEmptyUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test153GetUndeliveredMessageCountForUserWithInvalidUID(){
        let expectation = self.expectation(description: "testGetUndeliveredMessageCountForUserWithInvalidUID")
        CometChat.getUndeliveredMessageCountForUser("INVALID", onSuccess: { (success) in
            print("testGetUndeliveredMessageCountForUserWithInvalidUID onSuccess: \(success)")
            
        }) { (error) in
            print("testGetUndeliveredMessageCountForUserWithInvalidUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test154GetUndeliveredMessageCountForGroup(){
        let expectation = self.expectation(description: "testGetUndeliveredMessageCountForGroup")
        CometChat.getUndeliveredMessageCountForGroup(TestConstants.grpPublic1, onSuccess: { (success) in
            print("testGetUndeliveredMessageCountForGroup onSuccess: \(success)")
            XCTAssertNotNil(success)
            expectation.fulfill()
        }) { (error) in
            print("testGetUndeliveredMessageCountForGroup error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test155GetUndeliveredMessageCountForGroupWithEmptyGUID(){
        let expectation = self.expectation(description: "testGetUndeliveredMessageCountForGroupWithEmptyGUID")
        CometChat.getUndeliveredMessageCountForGroup("", onSuccess: { (success) in
            print("testGetUndeliveredMessageCountForGroupWithEmptyGUID onSuccess: \(success)")
            
        }) { (error) in
            print("testGetUndeliveredMessageCountForGroupWithEmptyGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test156GetUndeliveredMessageCountForGroupWithInvalidGUID(){
        let expectation = self.expectation(description: "testGetUndeliveredMessageCountForGroupWithInvalidGUID")
        CometChat.getUndeliveredMessageCountForGroup("INVALID", onSuccess: { (success) in
            print("testGetUndeliveredMessageCountForGroupWithInvalidGUID onSuccess: \(success)")
            
        }) { (error) in
            print("testGetUndeliveredMessageCountForGroupWithInvalidGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test157GetUndeliveredMessageCountForAllUsers(){
        let expectation = self.expectation(description: "testGetUndeliveredMessageCountForAllUsers")
        
        CometChat.getUndeliveredMessageCountForAllUsers(onSuccess: { (success) in
            print("testGetUndeliveredMessageCountForAllUsers onSuccess: \(success)")
            XCTAssertNotNil(success)
            expectation.fulfill()
        }) { (error) in
            print("testGetUndeliveredMessageCountForAllUsers error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test158GetUndeliveredMessageCountForAllGroups(){
        let expectation = self.expectation(description: "testGetUndeliveredMessageCountForAllGroups")
        CometChat.getUndeliveredMessageCountForAllGroups(onSuccess: { (success) in
            print("testGetUndeliveredMessageCountForAllGroups onSuccess: \(success)")
            XCTAssertNotNil(success)
            expectation.fulfill()
        }) { (error) in
            print("testGetUndeliveredMessageCountForAllGroups error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test159GetUndeliveredMessageCount(){
        let expectation = self.expectation(description: "testGetUndeliveredMessageCount")
        CometChat.getUndeliveredMessageCount(onSuccess: { (success) in
            print("testGetUndeliveredMessageCount onSuccess: \(success)")
            XCTAssertNotNil(success)
            expectation.fulfill()
        }) { (error) in
            print("testGetUndeliveredMessageCount error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test160GetUndeliveredMessageCountFilterByHideBlockedUsers(){
        let expectation = self.expectation(description: "testGetUndeliveredMessageCountFilterByHideBlockedUsers")
        CometChat.getUndeliveredMessageCount(hideMessagesFromBlockedUsers: true, onSuccess: { (success) in
            print("testGetUndeliveredMessageCountFilterByHideBlockedUsers onSuccess: \(success)")
            XCTAssertNotNil(success)
            expectation.fulfill()
        }) { (error) in
            print("testGetUndeliveredMessageCountFilterByHideBlockedUsers error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test161GetUndeliveredMessageCountFilterByHideBlockedUsersFalse(){
         let expectation = self.expectation(description: "testGetUndeliveredMessageCountFilterByHideBlockedUsersFalse")
        CometChat.getUndeliveredMessageCount(hideMessagesFromBlockedUsers: false, onSuccess: { (success) in
            print("testGetUndeliveredMessageCountFilterByHideBlockedUsersFalse onSuccess: \(success)")
            XCTAssertNotNil(success)
            expectation.fulfill()
        }) { (error) in
            print("testGetUndeliveredMessageCountFilterByHideBlockedUsersFalse error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
}

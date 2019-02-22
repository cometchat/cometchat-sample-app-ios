//
//  ChatVCCallback.swift
//  CometChatPulse-swift-sampleApp
//
//  Created by Jeet Kapadia on 31/12/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import Foundation

import CometChatPro

class ChatVCCallbacks_{
    
    private var userMessageRequest:MessagesRequest!
    private var groupMessageRequest:GroupMembersRequest!
    
    public typealias sendMessageResponse = (_ success:getSendMessageResponse? , _ error:CometChatException?) -> Void
    
    public typealias usermessageResponse = (_ user:getMessageResponse? , _ error:CometChatException?) ->Void
    public typealias groupmessageResponse = (_ group:[BaseMessage]? , _ error:CometChatException?) ->Void
    
    func fetchUserMessages(userUID: String, completionHandler:@escaping usermessageResponse) {
        
//        let userMessageRequest = MessagesRequest.MessageRequestBuilder(UID: userUID).set(limit: 20).build();
        
        let userMessageRequest = MessagesRequest.MessageRequestBuilder().set(UID: userUID).set(limit: 20).build()
        userMessageRequest.fetchPrevious(onSuccess: { (messages) in
            let usersMessagesArray = messages
            
            do {
                let response = try getMessageResponse(myMessageData: usersMessagesArray!)
                completionHandler(response, nil)
            } catch {}
            
        }) { (error) in
            
            completionHandler(nil,error)
            return
            
        }
        
    }
    
    func sendTextMessage(toUserUID: String, message : String ,completionHandler:@escaping sendMessageResponse){
        
        let textMessage = TextMessage(receiverUid: toUserUID, text: message, messageType: .text, receiverType: .user)
        
        CometChat.sendTextMessage(message: textMessage, onSuccess: { (message) in
            
            do {
                let response = try getSendMessageResponse(myMessageData: message)
                completionHandler(response, nil)
            } catch {}

            
        }) { (error) in
            
            completionHandler(nil,error)
            
        }
        
    }
    
    
}




//func getMessage(forUID : String) -> Array<Any> {
//
//    let messagelist = UserMessagesRequest.UserMessagesRequestBuilder(fromUID: forUID).setLimit(limit: 20).build()
//
//    messagelist.fetchPrevious { (messages, error) in
//
//        if error != nil { // Error
//            return
//        }
//    }
//
//
//}

// *** STEP 4:.confirming to a protocol




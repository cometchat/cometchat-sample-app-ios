//
//  MessageResponse.swift
//  CometChatPulse-swift-sampleApp
//
//  Created by Jeet Kapadia on 09/01/19.
//  Copyright © 2019 Admin1. All rights reserved.
//

import Foundation
import CometChatPro

struct getMessageResponse {
    
    let messages : [Message]
    
    init?(myMessageData : [BaseMessage]) throws {
        
        var messages = [Message]()
        var messageDict = [String : Any]()
        
        for myData in myMessageData{
            
            switch myData.messageCategory{
                
            case .message:
                
                switch myData.messageType{
                    
                case .text:
                    let date = Date(timeIntervalSince1970: TimeInterval(myData.sentAt))
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.dateFormat = "HH:mm:a"
                    
                    dateFormatter1.timeZone = NSTimeZone.local
                    let dateString : String = dateFormatter1.string(from: date)
                    print("formatted date is =  \(dateString)")
                    
                    let myUID = UserDefaults.standard.string(forKey: "LoggedInUserUID")
                    let isSelf : Bool
                    
                    if(myUID == myData.sender?.uid){
                        
                        isSelf = true
                        
                    }else {
                        
                        isSelf = false
                    }
                    
                    if(myData.receiverType == .group){
                        
                        messageDict["isGroup"] = true
                        
                    }else {
                        
                        messageDict["isGroup"] = false
                        
                    }
                    
                    let myMessage = (myData as? TextMessage)
                    print("myMessage is \(String(describing: myMessage?.text))")
                    messageDict["userID"] = myMessage?.sender?.uid
                    messageDict["userName"] = myMessage?.sender?.name
                    messageDict["messageText"] = myMessage?.text
                    messageDict["messageType"] = "text" //
                    messageDict["isSelf"] = isSelf
                    messageDict["time"] = dateString
                    messageDict["avatarURL"] = myMessage?.sender?.avatar
                    print("myDict is \(messageDict)")
                    guard let message = Message(dict: messageDict) else { continue }
                    print("MyMessage is 22222 \(message)")
                    messages.append(message)
                    
                case .image:
                    
                    let date = Date(timeIntervalSince1970: TimeInterval(myData.sentAt))
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.dateFormat = "HH:mm:a"
                    
                    dateFormatter1.timeZone = NSTimeZone.local
                    let dateString : String = dateFormatter1.string(from: date)
                    print("formatted date is =  \(dateString)")
                    
                    let myUID = UserDefaults.standard.string(forKey: "LoggedInUserUID")
                    let isSelf : Bool
                    
                    if(myUID == myData.sender?.uid){
                        
                        isSelf = true
                        
                    }else {
                        
                        isSelf = false
                    }
                    
                    if(myData.receiverType == .group){
                        
                        messageDict["isGroup"] = true
                        
                    }else {
                        
                        messageDict["isGroup"] = false
                        
                    }
                    
                    let myMessage = (myData as? MediaMessage)
                    let urlString = myMessage?.url?.decodeUrl()
                    print("myMessage is \(String(describing: myMessage?.url))")
                    messageDict["userID"] = myMessage?.sender?.uid
                    messageDict["userName"] = myMessage?.sender?.name
                    messageDict["messageText"] = urlString
                    messageDict["messageType"] = "image" //
                    messageDict["isSelf"] = isSelf
                    messageDict["time"] = dateString
                    messageDict["avatarURL"] = myMessage?.sender?.avatar
                    print("myDict is \(messageDict)")
                    guard let message = Message(dict: messageDict) else { continue }
                    print("MyMessage is 22222 \(message)")
                    messages.append(message)
                    
                case .video:
                    
                    let date = Date(timeIntervalSince1970: TimeInterval(myData.sentAt))
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.dateFormat = "HH:mm:a"
                    
                    dateFormatter1.timeZone = NSTimeZone.local
                    let dateString : String = dateFormatter1.string(from: date)
                    print("formatted date is =  \(dateString)")
                    
                    let myUID = UserDefaults.standard.string(forKey: "LoggedInUserUID")
                    let isSelf : Bool
                    
                    if(myUID == myData.sender?.uid){
                        
                        isSelf = true
                        
                    }else {
                        
                        isSelf = false
                    }
                    
                    if(myData.receiverType == .group){
                        
                        messageDict["isGroup"] = true
                        
                    }else {
                        
                        messageDict["isGroup"] = false
                        
                    }
                    
                    let myMessage = (myData as? MediaMessage)
                    let urlString = myMessage?.url?.decodeUrl()
                    print("myMessage is \(String(describing: myMessage?.url))")
                    messageDict["userID"] = myMessage?.sender?.uid
                    messageDict["userName"] = myMessage?.sender?.name
                    messageDict["messageText"] = urlString
                    messageDict["messageType"] = "video" //
                    messageDict["isSelf"] = isSelf
                    messageDict["time"] = dateString
                    messageDict["avatarURL"] = myMessage?.sender?.avatar
                    print("myDict is \(messageDict)")
                    guard let message = Message(dict: messageDict) else { continue }
                    print("MyMessage is 22222 \(message)")
                    messages.append(message)
                    
                case .audio:
                    
                    let date = Date(timeIntervalSince1970: TimeInterval(myData.sentAt))
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.dateFormat = "HH:mm:a"
                    
                    dateFormatter1.timeZone = NSTimeZone.local
                    let dateString : String = dateFormatter1.string(from: date)
                    print("formatted date is =  \(dateString)")
                    
                    let myUID = UserDefaults.standard.string(forKey: "LoggedInUserUID")
                    let isSelf : Bool
                    
                    if(myUID == myData.sender?.uid){
                        
                        isSelf = true
                        
                    }else {
                        
                        isSelf = false
                    }
                    
                    if(myData.receiverType == .group){
                        
                        messageDict["isGroup"] = true
                        
                    }else {
                        
                        messageDict["isGroup"] = false
                        
                    }
                    
                    let myMessage = (myData as? MediaMessage)
                    let urlString = myMessage?.url?.decodeUrl()
                    print("myMessage is \(String(describing: myMessage?.url))")
                    messageDict["userID"] = myMessage?.sender?.uid
                    messageDict["userName"] = myMessage?.sender?.name
                    messageDict["messageText"] = urlString
                    messageDict["messageType"] = "audio" //
                    messageDict["isSelf"] = isSelf
                    messageDict["time"] = dateString
                    messageDict["avatarURL"] = myMessage?.sender?.avatar
                    print("myDict is \(messageDict)")
                    guard let message = Message(dict: messageDict) else { continue }
                    print("MyMessage is 22222 \(message)")
                    messages.append(message)
                    
                case .file:
                    
                    let date = Date(timeIntervalSince1970: TimeInterval(myData.sentAt))
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.dateFormat = "HH:mm:a"
                    
                    dateFormatter1.timeZone = NSTimeZone.local
                    let dateString : String = dateFormatter1.string(from: date)
                    print("formatted date is =  \(dateString)")
                    
                    let myUID = UserDefaults.standard.string(forKey: "LoggedInUserUID")
                    let isSelf : Bool
                    
                    if(myUID == myData.sender?.uid){
                        
                        isSelf = true
                        
                    }else {
                        
                        isSelf = false
                    }
                    
                    if(myData.receiverType == .group){
                        
                        messageDict["isGroup"] = true
                        
                    }else {
                        
                        messageDict["isGroup"] = false
                        
                    }
                    
                    let myMessage = (myData as? MediaMessage)
                    let urlString = myMessage?.url?.decodeUrl()
                    print("myMessage is \(String(describing: myMessage?.url))")
                    messageDict["userID"] = myMessage?.sender?.uid
                    messageDict["userName"] = myMessage?.sender?.name
                    messageDict["messageText"] = urlString
                    messageDict["messageType"] = "file" //
                    messageDict["isSelf"] = isSelf
                    messageDict["time"] = dateString
                    messageDict["avatarURL"] = myMessage?.sender?.avatar
                    print("myDict is \(messageDict)")
                    guard let message = Message(dict: messageDict) else { continue }
                    print("MyMessage is 22222 \(message)")
                    messages.append(message)
                    
                case .custom:break
                    
                case .groupMember:break
                    
                }
                
                
            case .action:
                
                print("I am in Action Messages");
                let date = Date(timeIntervalSince1970: TimeInterval(myData.sentAt))
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "HH:mm:a"
                
                dateFormatter1.timeZone = NSTimeZone.local
                let dateString : String = dateFormatter1.string(from: date)
                print("formatted date is =  \(dateString)")
                
                let myUID = UserDefaults.standard.string(forKey: "LoggedInUserUID")
                let isSelf : Bool
                
                if(myUID == myData.sender?.uid){
                    
                    isSelf = true
                    
                }else {
                    
                    isSelf = false
                }
                
                if(myData.receiverType == .group){
                    
                    messageDict["isGroup"] = true
                    
                }else {
                    
                    messageDict["isGroup"] = false
                    
                }
                let myMessage = (myData as? ActionMessage)
                messageDict["userID"] = myMessage?.sender?.uid
                messageDict["userName"] = myMessage?.sender?.name
                messageDict["messageText"] = myMessage?.message
                messageDict["messageType"] = "action"
                messageDict["isSelf"] = isSelf
                messageDict["time"] = dateString
                messageDict["avatarURL"] = myMessage?.sender?.avatar
                print("myDict is \(messageDict)")
                guard let message = Message(dict: messageDict) else { continue }
                print("MyMessage is 22222 \(message)")
                messages.append(message)
                
            case .call:
                
                print("I am in Call Action Messages");
                
                let date = Date(timeIntervalSince1970: TimeInterval(myData.sentAt))
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "HH:mm:a"
                
                dateFormatter1.timeZone = NSTimeZone.local
                let dateString : String = dateFormatter1.string(from: date)
                print("formatted date is =  \(dateString)")
                
                let myUID = UserDefaults.standard.string(forKey: "LoggedInUserUID")
                let isSelf : Bool
                
                if(myUID == myData.sender?.uid){
                    
                    isSelf = true
                    
                }else {
                    
                    isSelf = false
                }
                
                if(myData.receiverType == .group){
                    
                    messageDict["isGroup"] = true
                    
                }else {
                    
                    messageDict["isGroup"] = false
                    
                }
                let myMessage = (myData as? ActionMessage)
                messageDict["userID"] = myMessage?.sender?.uid
                messageDict["userName"] = myMessage?.sender?.name
                messageDict["messageText"] = myMessage?.message
                messageDict["messageType"] = "action"
                messageDict["isSelf"] = isSelf
                messageDict["time"] = dateString
                messageDict["avatarURL"] = myMessage?.sender?.avatar
                print("myDict is \(messageDict)")
                guard let message = Message(dict: messageDict) else { continue }
                print("MyMessage is 22222 \(message)")
                messages.append(message)
            }
        }
        self.messages = messages
    }
}

struct getSendMessageResponse {
    
    let messages : Message
    
    init?(myMessageData : BaseMessage) throws{
        
        var messageDict = [String : Any]()
        
        if(myMessageData .isKind(of: TextMessage.self)){
            
            print("here my timestam \(myMessageData.sentAt)")
            print("here the senderUID \(myMessageData.sender?.uid)")
            print("here the receiverUID \(myMessageData.receiverUid)")
            print("here the user is \(String(describing: myMessageData.sender))")
            print("here the user name is: \(String(describing: myMessageData.sender?.name))")
            print("here the user name is: \(myMessageData.sender?.avatar)")
            
            let date = Date(timeIntervalSince1970: TimeInterval(myMessageData.sentAt))
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "HH:mm a"
            
            dateFormatter1.timeZone = NSTimeZone.local
            let dateString : String = dateFormatter1.string(from: date)
            print("formatted date is =  \(dateString)")
            
            let myMessage = (myMessageData as? TextMessage)
            print("myMessage is \(String(describing: myMessage?.text))")
            
            if(myMessageData.receiverType == .group){
                
                messageDict["isGroup"] = true
                
            }else {
                
                messageDict["isGroup"] = false
                
            }
            print("myMessage?.sender?.avatar: \(String(describing: myMessage?.sender?.avatar))")
            messageDict["userID"] = myMessage?.sender?.uid
            messageDict["userName"] = myMessage?.sender?.name
            messageDict["messageText"] = myMessage?.text
            messageDict["messageType"] = "text" //
            messageDict["isSelf"] = true
            messageDict["time"] = dateString
            messageDict["avatarURL"] = myMessage?.sender?.avatar
            print("myDict is \(messageDict)")
            guard let message = Message(dict: messageDict) else { return nil  }
            print("MyMessage is new 111\(message)")
            self.messages = message
            
        }else if(myMessageData .isKind(of: MediaMessage.self)) && myMessageData.messageType == .image {
            
            print("It is a type of Image message")
            
            print("here my timestam \(myMessageData.sentAt)")
            print("here the senderUID \(String(describing: myMessageData.sender?.uid))")
            print("here the receiverUID \(myMessageData.receiverUid)")
            print("here the user is \(String(describing: myMessageData.sender))")
            print("here the user name is: \(String(describing: myMessageData.sender?.name))")
            print("here the user name is: \(String(describing: myMessageData.sender?.avatar))")
            
            let date = Date(timeIntervalSince1970: TimeInterval(myMessageData.sentAt))
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "HH:mm a"
            
            dateFormatter1.timeZone = NSTimeZone.local
            let dateString : String = dateFormatter1.string(from: date)
            print("formatted date is =  \(dateString)")
            
            let myMessage = (myMessageData as? MediaMessage)
            let urlString = myMessage?.url?.decodeUrl()
            
            print("myMessage is \(String(describing: urlString))")
            
            if(myMessageData.receiverType == .group){
                
                messageDict["isGroup"] = true
                
            }else {
                
                messageDict["isGroup"] = false
                
            }
            print("myMessage?.sender?.avatar: \(String(describing: myMessage?.sender?.avatar))")
            messageDict["userID"] = myMessage?.sender?.uid
            messageDict["userName"] = myMessage?.sender?.name
            messageDict["messageText"] = urlString
            messageDict["messageType"] = "image" //
            messageDict["isSelf"] = true
            messageDict["time"] = dateString
            messageDict["avatarURL"] = myMessage?.sender?.avatar
            print("myDict is \(messageDict)")
            guard let message = Message(dict: messageDict) else { return nil  }
            print("MyMessage is new \(message)")
            self.messages = message
            
            
        }else if(myMessageData .isKind(of: MediaMessage.self)) && myMessageData.messageType == .video {
            
            print("It is a type of Video message")
            
            print("here my timestam \(myMessageData.sentAt)")
            print("here the senderUID \(String(describing: myMessageData.sender?.uid))")
            print("here the receiverUID \(myMessageData.receiverUid)")
            print("here the user is \(String(describing: myMessageData.sender))")
            print("here the user name is: \(String(describing: myMessageData.sender?.name))")
            print("here the user name is: \(String(describing: myMessageData.sender?.avatar))")
            
            let date = Date(timeIntervalSince1970: TimeInterval(myMessageData.sentAt))
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "HH:mm a"
            
            dateFormatter1.timeZone = NSTimeZone.local
            let dateString : String = dateFormatter1.string(from: date)
            print("formatted date is =  \(dateString)")
            
            let myMessage = (myMessageData as? MediaMessage)
            let urlString = myMessage?.url?.decodeUrl()
            
            print("myMessage is \(String(describing: urlString))")
            
            if(myMessageData.receiverType == .group){
                
                messageDict["isGroup"] = true
                
            }else {
                
                messageDict["isGroup"] = false
                
            }
            print("myMessage?.sender?.avatar: \(String(describing: myMessage?.sender?.avatar))")
            messageDict["userID"] = myMessage?.sender?.uid
            messageDict["userName"] = myMessage?.sender?.name
            messageDict["messageText"] = urlString
            messageDict["messageType"] = "video" //
            messageDict["isSelf"] = true
            messageDict["time"] = dateString
            messageDict["avatarURL"] = myMessage?.sender?.avatar
            print("myDict is \(messageDict)")
            guard let message = Message(dict: messageDict) else { return nil  }
            print("MyMessage is new \(message)")
            self.messages = message
            
        }else if(myMessageData .isKind(of: MediaMessage.self)) && myMessageData.messageType == .file {
            
            print("It is a type of File message")
            
            print("here my timestam \(myMessageData.sentAt)")
            print("here the senderUID \(String(describing: myMessageData.sender?.uid))")
            print("here the receiverUID \(myMessageData.receiverUid)")
            print("here the user is \(String(describing: myMessageData.sender))")
            print("here the user name is: \(String(describing: myMessageData.sender?.name))")
            print("here the user name is: \(String(describing: myMessageData.sender?.avatar))")
            
            let date = Date(timeIntervalSince1970: TimeInterval(myMessageData.sentAt))
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "HH:mm a"
            
            dateFormatter1.timeZone = NSTimeZone.local
            let dateString : String = dateFormatter1.string(from: date)
            print("formatted date is =  \(dateString)")
            
            let myMessage = (myMessageData as? MediaMessage)
            let urlString = myMessage?.url?.decodeUrl()
            
            print("myMessage is \(String(describing: urlString))")
            
            if(myMessageData.receiverType == .group){
                
                messageDict["isGroup"] = true
                
            }else {
                
                messageDict["isGroup"] = false
                
            }
            print("myMessage?.sender?.avatar: \(String(describing: myMessage?.sender?.avatar))")
            messageDict["userID"] = myMessage?.sender?.uid
            messageDict["userName"] = myMessage?.sender?.name
            messageDict["messageText"] = urlString
            messageDict["messageType"] = "file" //
            messageDict["isSelf"] = true
            messageDict["time"] = dateString
            messageDict["avatarURL"] = myMessage?.sender?.avatar
            print("myDict is \(messageDict)")
            guard let message = Message(dict: messageDict) else { return nil  }
            print("MyMessage is new \(message)")
            self.messages = message
            
            
        } else if(myMessageData .isKind(of: MediaMessage.self)) && myMessageData.messageType == .audio {
            
            print("It is a type of audio message")
            
            print("here my timestam \(myMessageData.sentAt)")
            print("here the senderUID \(String(describing: myMessageData.sender?.uid))")
            print("here the receiverUID \(myMessageData.receiverUid)")
            print("here the user is \(String(describing: myMessageData.sender))")
            print("here the user name is: \(String(describing: myMessageData.sender?.name))")
            print("here the user name is: \(String(describing: myMessageData.sender?.avatar))")
            
            let date = Date(timeIntervalSince1970: TimeInterval(myMessageData.sentAt))
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "HH:mm a"
            
            dateFormatter1.timeZone = NSTimeZone.local
            let dateString : String = dateFormatter1.string(from: date)
            print("formatted date is =  \(dateString)")
            
            let myMessage = (myMessageData as? MediaMessage)
            let urlString = myMessage?.url?.decodeUrl()
            
            print("myMessage is \(String(describing: urlString))")
            
            if(myMessageData.receiverType == .group){
                
                messageDict["isGroup"] = true
                
            }else {
                
                messageDict["isGroup"] = false
                
            }
            print("myMessage?.sender?.avatar: \(String(describing: myMessage?.sender?.avatar))")
            messageDict["userID"] = myMessage?.sender?.uid
            messageDict["userName"] = myMessage?.sender?.name
            messageDict["messageText"] = urlString
            messageDict["messageType"] = "audio" //
            messageDict["isSelf"] = true
            messageDict["time"] = dateString
            messageDict["avatarURL"] = myMessage?.sender?.avatar
            print("myDict is \(messageDict)")
            guard let message = Message(dict: messageDict) else { return nil  }
            print("MyMessage is new \(message)")
            self.messages = message
            
        }else{
            
            return nil
            
        }
    }
}




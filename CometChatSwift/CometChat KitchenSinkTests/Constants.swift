//
//  TestConstants.swift
//  CometChatProTests
//
//  Created by Inscripts11 on 22/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

import UIKit
import XCTest
import CometChatPro
//@testable import CometChatPro_swift_sampleApp

enum TestConstants {
    
    static let appId = "3009688bf1d217f"
    static let apiKey = "fd510a0c76e0155bb15ea9f3c13ac3fe552d3b09"
    static let authtokenUser1 = "superhero2_ddc09914861c29e57f404b1850e367302e2a55fc"
    static let user1 = "superhero1"
    static let user1name = "Iron Man"
    static let user2 = "superhero2"
    static let testuser1 = "test1"
    static let testuser2 = "test2"
    static let testuser3 = "test3"
    static let testuser4 = "test4"
    static let testuser5 = "test5"
    static let testuser6 = "test6"
    static let testuser7 = "test7"
    static let testuser8 = "test8"
    static let testuser9 = "test9"
    static let testuser10 = "test10"
    static let testuser11 = "test11"
    static let grpPublic1 = "supergroup"
    static let testGroup1 = "testGroup1"
    static let testGroup2 = "testGroup2"
    static let testGroup3 = "testGroup3"
    static let testGroup4 = "testGroup4"
    static let testGroup5 = "testGroup5"
    static let testGroup6 = "testGroup6"
    static let testGroup7 = "testGroup7"
    static let testGroup8 = "testGroup8"
    static let testGroup9 = "testGroup9"
    static let testGroup10 = "testGroup10"
    static let testGroup11 = "testGroup11"
    static let testGroup12 = "testGroup12"
    static let testGroup13 = "testGroup13"
    static let testGroup14 = "testGroup14"
    static let testGroup15 = "testGroup15"
    static let testGroup16 = "testGroup16"
    static let grpPublic2 = "MySuperPublicGroup"
    static let grpPrivate3 = "supergroup"
    static let grpPrivate4 = "supergroup"
    static let grpPwd5 = "12345"
    static let grpPwd6 = "12345"
    static var loggedInUser : User = User(uid: "superhero1", name: "Iron Man")
    static var testUserUIDArray = ["test1", "test2", "test3", "test4", "test5", "test6", "test7", "test8", "test9", "test10", "test11"]
    static var testGroupUIDArray = ["testGroup1", "testGroup2", "testGroup3", "testGroup4", "testGroup5", "testGroup6", "testGroup7", "testGroup8", "testGroup9", "testGroup10", "testGroup11", "testGroup12", "testGroup13", "testGroup14", "testGroup15", "testGroup16"]
}

public func userIsValid(user : User) {
    
    XCTAssertNotNil(user.uid)
    XCTAssertNotNil(user.name)
}

public func validatedCreatedUser(user : User, isavatar : Bool, ismetaData : Bool, islink : Bool, isStatusMessage : Bool, isRole : Bool){
    
    XCTAssertNotNil(user.uid)
    XCTAssertNotNil(user.name)
    
    if isavatar == true{
        
        XCTAssertNotNil(user.avatar)
    }
    
    if ismetaData == true{
        
        XCTAssertNotNil(user.metadata)
    }
    
    if islink == true{
        
        XCTAssertNotNil(user.link)
    }
    
    if isStatusMessage == true{
        
        XCTAssertNotNil(user.statusMessage)
    }
    
    if isRole == true{
        
        XCTAssertNotNil(user.role)
    }
    
//    if isCredit == true{
//        
//        XCTAssertNotNil(user.credits)
//    }
    
}

public func validateUserList(user : [User], isRole: Bool){
    
    for u in user {
        
        XCTAssertNotNil(u.uid)
        XCTAssertNotNil(u.name)
        
        if isRole == true {
            
            XCTAssertNotNil(u.role)
        }
    }
}

//joined only joinedAt scope
public func validateGroups(groups : [Group], hasJoinedOnlyGroups : Bool){
    
    for g in groups {

        XCTAssertNotNil(g.name)
        XCTAssertNotNil(g.guid)
        XCTAssertNotNil(g.groupType)
        XCTAssertNotNil(g.createdAt)
        XCTAssertNotNil(g.owner)
        
        if hasJoinedOnlyGroups {
            
            XCTAssertTrue(g.hasJoined)
            XCTAssertNotNil(g.joinedAt)
            XCTAssertNotNil(g.scope)
            
        }else {
            
            if g.hasJoined == true {
                
                XCTAssertNotNil(g.joinedAt)
                XCTAssertNotNil(g.scope)
            }
        }
    }
}

public func validateCreatedGroup(group : Group, ismetaData : Bool, isIcon : Bool, isDescription : Bool){
    
    XCTAssertNotNil(group.name)
    XCTAssertNotNil(group.guid)
    XCTAssertTrue(group.hasJoined)
    
    if ismetaData {
        XCTAssertNotNil(group.metadata)
    }
    
    if isIcon {
        XCTAssertNotNil(group.icon)
    }
    
    if isDescription {
        XCTAssertNotNil(group.description)
    }
}

public func validateChangeGroupType(group: Group, type: CometChat.groupType) {
    
    XCTAssertNotNil(group.name)
    XCTAssertNotNil(group.guid)
    XCTAssertTrue(group.hasJoined)
    
    XCTAssertEqual(group.groupType, type)
}

public func validateGroupMembers(members : [GroupMember]){
    
    for m in members {
        XCTAssertNotNil(m.name)
        XCTAssertNotNil(m.uid)
        XCTAssertNotNil(m.scope)
        XCTAssertNotNil(m.joinedAt)
        
    }
}

public func validateConversations(conversation : [Conversation], validateType : CometChat.ConversationType?){
    
    for conv in conversation {
        
        XCTAssertNotNil(conv.conversationId)
        XCTAssertNotNil(conv.conversationType)
        XCTAssertNotNil(conv.conversationWith)
        XCTAssertNotEqual(conv.updatedAt, 0.0)
        
        if (conv.conversationWith?.isKind(of: User.self))!{
            validateUserList(user: [(conv.conversationWith as? User)!], isRole: false )
        }else {
            validateGroups(groups: [(conv.conversationWith as? Group)!], hasJoinedOnlyGroups: true )
        }
        
        if conv.lastMessage != nil {
            validateMessage(message: conv.lastMessage!, messageType: nil, receiverType: nil, ismetaData: false, isMUID: false)
        }
        
        if validateType != nil {
            XCTAssertEqual(conv.conversationType, validateType)
        }
    }
}

public func validateMessage(message : BaseMessage, messageType : CometChat.MessageType?, receiverType : CometChat.ReceiverType?, ismetaData : Bool, isMUID : Bool){
    
    XCTAssertNotNil(message.id)
    XCTAssertNotNil(message.senderUid)
    XCTAssertNotNil(message.receiverUid)
    XCTAssertNotNil(message.messageCategory)
    
    if message.isKind(of: TextMessage.self){
        
        let myMessage  = message as! TextMessage
        XCTAssertNotNil(myMessage.text)
    }
    
    if message.isKind(of: CustomMessage.self){
        
        let myMessage = message as! CustomMessage
        print(myMessage.stringValue())
        if myMessage.deletedAt == 0 {
            
            XCTAssertNotNil(myMessage.customData)
        }
        
    }
    
    if message.isKind(of: MediaMessage.self) {
        
        let myMessage = message as! MediaMessage
        print(myMessage.stringValue())
        if myMessage.messageType == .image || myMessage.messageType == .audio || myMessage.messageType == .video || myMessage.messageType == .file {
            
            if myMessage.deletedAt == 0 {
            
                XCTAssertNotNil(myMessage.attachment?.fileUrl)
            }
        }
    }
    
    if ismetaData {
        XCTAssertNotNil(message.metaData)
    }
}

public func initialSetup(completion: (Bool) -> ()) {
    
    DispatchQueue.global().sync {
        
        let createUserArray : [User] = [User(uid: "test1", name: "test1"), User(uid: "test2", name: "test2"), User(uid: "test3", name: "test3"), User(uid: "test4", name: "test4"), User(uid: "test5", name: "test5"), User(uid: "test6", name: "test6"), User(uid: "test7", name: "test7"), User(uid: "test8", name: "test8"), User(uid: "test9", name: "test9"), User(uid: "test10", name: "test10"), User(uid: "test11", name: "test11")]
        
        let createGroupArray : [Group] = [Group(guid: "testGroup1", name: "testGroup1", groupType: .public, password: nil), Group(guid: "testGroup2", name: "testGroup2", groupType: .public, password: nil), Group(guid: "testGroup3", name: "testGroup3", groupType: .public, password: nil), Group(guid: "testGroup4", name: "testGroup4", groupType: .public, password: nil), Group(guid: "testGroup5", name: "testGroup5", groupType: .public, password: nil), Group(guid: "testGroup6", name: "testGroup6", groupType: .password, password: "123"), Group(guid: "testGroup7", name: "testGroup7", groupType: .password, password: "123"), Group(guid: "testGroup8", name: "testGroup8", groupType: .password, password: "123"), Group(guid: "testGroup9", name: "testGroup9", groupType: .password, password: "123"), Group(guid: "testGroup10", name: "testGroup10", groupType: .password, password: "123"), Group(guid: "testGroup11", name: "testGroup11", groupType: .public, password: nil), Group(guid: "testGroup12", name: "testGroup12", groupType: .public, password: nil), Group(guid: "testGroup13", name: "testGroup13", groupType: .public, password: nil), Group(guid: "testGroup14", name: "testGroup14", groupType: .password, password: "123"), Group(guid: "testGroup15", name: "testGroup15", groupType: .private, password: nil), Group(guid: "testGroup16", name: "testGroup16", groupType: .private, password: nil)]
        
        for user in createUserArray {
            
            CometChat.createUser(user: user, apiKey: TestConstants.apiKey, onSuccess: { (user) in
                
               print("User created Successfully")
                
            }) { (error) in
                
                print("Failed to create user")
            }
        }
        
        var count = 1
        let addMembersArray1 : [GroupMember] = [GroupMember(UID: TestConstants.testuser1, groupMemberScope: .admin), GroupMember(UID: TestConstants.testuser2, groupMemberScope: .admin), GroupMember(UID: TestConstants.testuser3, groupMemberScope: .moderator), GroupMember(UID: TestConstants.testuser4, groupMemberScope: .moderator), GroupMember(UID: TestConstants.testuser5, groupMemberScope: .participant), GroupMember(UID: TestConstants.testuser8, groupMemberScope: .participant)]
        
        let addMembersArray2 : [GroupMember] = [GroupMember(UID: TestConstants.testuser6, groupMemberScope: .participant), GroupMember(UID: TestConstants.testuser7, groupMemberScope: .participant), GroupMember(UID: TestConstants.testuser8, groupMemberScope: .admin), GroupMember(UID: TestConstants.testuser9, groupMemberScope: .admin), GroupMember(UID: TestConstants.testuser10, groupMemberScope: .moderator),  GroupMember(UID: TestConstants.testuser1, groupMemberScope: .admin), GroupMember(UID: TestConstants.testuser2, groupMemberScope: .admin), GroupMember(UID: TestConstants.testuser11, groupMemberScope: .participant)]
        
        let addMembersArray3 : [GroupMember] = [GroupMember(UID: TestConstants.testuser11, groupMemberScope: .moderator), GroupMember(UID: TestConstants.testuser3, groupMemberScope: .admin), GroupMember(UID: TestConstants.testuser4, groupMemberScope: .participant)]
        
        for group in createGroupArray {
            
            CometChat.createGroup(group: group, onSuccess: { (group) in
                
                if count <= 5 {
                 
                    CometChat.addMembersToGroup(guid: group.guid, groupMembers: addMembersArray1, bannedUIDs: [TestConstants.testuser6, TestConstants.testuser7, TestConstants.testuser8, TestConstants.testuser9],onSuccess: { (success) in
                        
                        print("success")
                        
                    }) { (error) in
                        
                        print("failure")
                    }
                    
                }else if count > 5 && count <= 10 {
                    
                    CometChat.addMembersToGroup(guid: group.guid, groupMembers: addMembersArray2, bannedUIDs: [TestConstants.testuser3, TestConstants.testuser4],onSuccess: { (success) in
                        
                        print("success")
                        
                    }) { (error) in
                        
                        print("failure")
                    }
                    
                }else if count > 10 {
                    
                    CometChat.addMembersToGroup(guid: group.guid, groupMembers: addMembersArray3, bannedUIDs: [TestConstants.testuser10, TestConstants.testuser11, TestConstants.testuser6, TestConstants.testuser7],onSuccess: { (success) in
                        
                        print("success")
                        
                    }) { (error) in
                        
                        print("failure")
                    }
                }
                
                print("group created successfully")
                
            }) { (error) in
                
                print("failed to create group")
            }
            
            count = count + 1
        }
        
        let myTextMessages = ["hey", "hii", "Hello", "how are you", "how you doin", "all is well"]
        
        
        for i in 0 ..< TestConstants.testUserUIDArray.count {
            
            let number = Int.random(in: 0 ..< myTextMessages.count)
            let myTextMessage = TextMessage(receiverUid: TestConstants.testUserUIDArray[i], text: myTextMessages[number], receiverType: .user)
            
            CometChat.sendTextMessage(message: myTextMessage, onSuccess: { (success) in
                
                print("message successfully sent")
            }) { (error) in
                
                print("message failed")
            }
            
            let myMediaMessage = MediaMessage(receiverUid: TestConstants.testUserUIDArray[i], fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .image, receiverType: .user)
            
            CometChat.sendMediaMessage(message: myMediaMessage, onSuccess: { (success) in
                
                print("message successfully sent")
            }) { (error) in
                
                print("message failed sent")
            }
            
            let myCustomMessage = CustomMessage(receiverUid: TestConstants.testUserUIDArray[i], receiverType: .user, customData: ["hello":"lksd"], type: "Testing")
            
            CometChat.sendCustomMessage(message: myCustomMessage, onSuccess: { (success) in
                
                print("Custom Message sent")
            }) { (error) in
                
                print("Failed message sent")
            }
        }
        
        for i in 0 ..< TestConstants.testGroupUIDArray.count {
            
            let number = Int.random(in: 0 ..< myTextMessages.count)
            let myTextMessage = TextMessage(receiverUid: TestConstants.testGroupUIDArray[i], text: myTextMessages[number], receiverType: .user)
            
            CometChat.sendTextMessage(message: myTextMessage, onSuccess: { (success) in
                
                print("message successfully sent")
            }) { (error) in
                
                print("message failed")
            }
            
            let myMediaMessage = MediaMessage(receiverUid: TestConstants.testGroupUIDArray[i], fileurl: "https://randomuser.me/api/portraits/women/18.jpg", messageType: .image, receiverType: .user)
            
            CometChat.sendMediaMessage(message: myMediaMessage, onSuccess: { (success) in
                
                print("message successfully sent")
            }) { (error) in
                
                print("message failed sent")
            }
            
            let myCustomMessage = CustomMessage(receiverUid: TestConstants.testGroupUIDArray[i], receiverType: .user, customData: ["hello":"lksd"], type: "Testing")
            
            CometChat.sendCustomMessage(message: myCustomMessage, onSuccess: { (success) in
                
                print("Custom Message sent")
            }) { (error) in
                
                print("Failed message sent")
            }
        }
        
        completion(true)
    }
}

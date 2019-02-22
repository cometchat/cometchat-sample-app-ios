//
//  Message.swift
//  CometChatPulse-swift-sampleApp
//
//  Created by Jeet Kapadia on 26/12/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import Foundation
import CometChatPro

struct Message{
    
    var messageText: String
    let userID: String
    let avatarURL : String
    let messageType : String
    let isSelf : Bool
    let isGroup : Bool
    let time : String
    let userName: String
    
    init?(dict: [String : Any]){
        
        guard let userID = dict["userID"] as? String,
            let messageText = dict["messageText"] as? String,
            let isSelf = dict["isSelf"] as? Bool,
            let messageType = dict["messageType"] as? String,
            let isGroup = dict["isGroup"] as? Bool,
            let avatarURL = dict["avatarURL"] as? String,
            let time = dict["time"] as? String,
            let userName = dict["userName"] as? String
            else { return nil }
        
        self.userID = userID
        self.messageText = messageText
        self.messageType = messageType
        self.isSelf = isSelf
        self.isGroup = isGroup
        self.time = time
        self.avatarURL = avatarURL
        self.userName = userName
        
    }

    
}

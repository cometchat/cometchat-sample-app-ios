//
//  Home + LaunchDelegate.swift
//  CometChatSwift
//
//  Created by admin on 12/10/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import Foundation
import CometChatPro
import CometChatUIKit
import UIKit

extension Home : LaunchDelegate {
    ///Chats
    func launchConversationsWithMessages() {
        let conversationsWithMessages = CometChatConversationsWithMessages()
        presentViewController(viewController: conversationsWithMessages, isNavigationController: true)
    }
    
    func launchConversations() {
        let conversations = CometChatConversations()
        presentViewController(viewController: conversations, isNavigationController: true)
    }
    
    func launchListItemForConversation() {
        let listItem = ListItem()
        listItem.listItemTypes = [.conversation]
        self.presentViewController(viewController: listItem, isNavigationController: false)
    }
    
    ///Calls
    func launchCallButtonComponent() {
        let callButtons = CallButtonsComponent()
        presentViewController(viewController: callButtons, isNavigationController: false)
    }
    
    ///Users
    func launchUsersWithMessages() {
        let usersWithMessages = CometChatUsersWithMessages()
        presentViewController(viewController: usersWithMessages, isNavigationController: true)
    }
    
    func launchUsers() {
        let users = CometChatUsers()
        presentViewController(viewController: users, isNavigationController: true)
    }

    func launchListItemForUser() {
        let listItem = ListItem()
        listItem.listItemTypes = [.user]
        self.presentViewController(viewController: listItem, isNavigationController: false)
    }
    
    func launchDetailsForUser() {
        CometChat.getUser(UID: "superhero1", onSuccess: { user in
            DispatchQueue.main.async {
                let detailsForUser = CometChatDetails()
                detailsForUser.set(user: user)
                self.presentViewController(viewController: detailsForUser, isNavigationController: true)
            }
        }, onError: { error in
            self.showAlert(title: "Error", msg: error?.errorDescription ?? "")
        })
    }
    
    ///Groups
    func launchGroupsWithMessages() {
        let groupsWithMessages = CometChatGroupsWithMessages()
        presentViewController(viewController: groupsWithMessages, isNavigationController: true)
    }
    
    func launchGroups() {
        let groups = CometChatGroups()
        presentViewController(viewController: groups, isNavigationController: true)
    }
    
    func launchListItemForGroup() {
        let listItem = ListItem()
        listItem.listItemTypes = [.group]
        self.presentViewController(viewController: listItem, isNavigationController: false)
    }
    
    func launchCreateGroup() {
        let createGroup = CometChatCreateGroup()
        self.presentViewController(viewController: createGroup, isNavigationController: true)
    }
    
    func launchJoinPasswordProtectedGroup() {
        CometChat.getGroup(GUID: "supergroup", onSuccess: { group in
            DispatchQueue.main.async {
                let joinProtectedGroup = CometChatJoinProtectedGroup()
                joinProtectedGroup.set(group: group)
                self.presentViewController(viewController: joinProtectedGroup, isNavigationController: true)
            }
        }, onError: { error in
            self.showAlert(title: "Error", msg: error?.errorDescription ?? "")
        })
    }
    
    func launchViewMembers() {
        CometChat.getGroup(GUID: "supergroup", onSuccess: { group in
            DispatchQueue.main.async {
                let groupMembers = CometChatGroupMembers(group: group)
                self.presentViewController(viewController: groupMembers, isNavigationController: true)
            }
        }, onError: { error in
            self.showAlert(title: "Error", msg: error?.errorDescription ?? "")
        })
    }
    
    func launchAddMembers() {
        CometChat.getGroup(GUID: "supergroup", onSuccess: { group in
            DispatchQueue.main.async {
                let addMembers = CometChatAddMembers(group: group)
                self.presentViewController(viewController: addMembers, isNavigationController: true)
            }
        }, onError: { error in
            self.showAlert(title: "Error", msg: error?.errorDescription ?? "")
        })
    }
    
    func launchBannedMembers() {
        CometChat.getGroup(GUID: "supergroup", onSuccess: { group in
            DispatchQueue.main.async {
                
                let bannedMembers =  CometChatBannedMembers(group: group)
                self.presentViewController(viewController: bannedMembers, isNavigationController: true)
            }
        }, onError: { error in
            self.showAlert(title: "Error", msg: error?.errorDescription ?? "")
        })
    }
    
    func launchTransferOwnership() {

        CometChat.getGroup(GUID: "supergroup", onSuccess: { group in
            DispatchQueue.main.async {
                let transferOwnerShip = CometChatTransferOwnership(group: group)
                self.presentViewController(viewController: transferOwnerShip, isNavigationController: true)
            }
        }, onError: { error in
            self.showAlert(title: "Error", msg: error?.errorDescription ?? "")
        })
    }
    
    func launchDetailsForGroup() {
        CometChat.getGroup(GUID: "supergroup", onSuccess: { group in
            DispatchQueue.main.async {
                let detailsForGroup = CometChatDetails()
                detailsForGroup.set(group: group)
                self.presentViewController(viewController: detailsForGroup, isNavigationController: true)
            }
        }, onError: { error in
            self.showAlert(title: "Error", msg: error?.errorDescription ?? "")
        })
    }
    
    ///Messages
    func launchMessages() {
        CometChat.getGroup(GUID: "supergroup", onSuccess: { group in
            DispatchQueue.main.async {
                let messages = CometChatMessages()
                messages.set(group: group)
                self.presentViewController(viewController: messages, isNavigationController: true)
            }
        }, onError: { error in
            self.showAlert(title: "Error", msg: error?.errorDescription ?? "")
        })
    }
    
    func launchMessageHeader() {
        let messageHeader = MessageHeaderComponent()
        presentViewController(viewController: messageHeader, isNavigationController: false)
    }
    
    func launchMessageList() {
        let messageList = MessageListComponent()
        presentViewController(viewController: messageList, isNavigationController: false)
    }
    
    func launchMessageComposer() {
        let messageComposer = MesaageComposerComponent()
        presentViewController(viewController: messageComposer, isNavigationController: false)
    }
    
    ///Shared
    func launchSoundManagerComponent() {
        
        let soundManager = SoundManagerComponent()
        self.presentViewController(viewController: soundManager, isNavigationController: false)
    }
    
    func launchThemeComponent() {
        let theme = ThemeComponent()
        self.presentViewController(viewController: theme, isNavigationController: false)
    }
    
    func launchLocalizeComponent() {
        let localize = LocalisationComponent()
        self.presentViewController(viewController: localize, isNavigationController: false)
    }
    
    func launchListItem() {
        let listItem = ListItem()
        listItem.listItemTypes = [.user,.group,.conversation]
        self.presentViewController(viewController: listItem, isNavigationController: false)
    }
    
    func launchAvatarComponent() {
        let avatarModification = AvatarModification()
        self.presentViewController(viewController: avatarModification, isNavigationController: false)
    }
    
    func launchBadgeCountComponent() {
        let badgeCountViewController = BadgeCountModification()
        self.presentViewController(viewController: badgeCountViewController, isNavigationController: false)
    }
    
    func launchStatusIndicatorComponent() {
        let statusIndicatorModification = StatusIndicatorModification()
        self.presentViewController(viewController: statusIndicatorModification, isNavigationController: false)
    }
    
    func launchMessageReceiptComponent() {
        let messageReceipt = MessageReceiptModification()
        self.presentViewController(viewController: messageReceipt, isNavigationController: false)
    }
        
    func launchTextBubbleComponent() {
        let textBubble = BubblesComponent()
        textBubble.bubbleType = .textBubble
        presentViewController(viewController: textBubble, isNavigationController: false)
    }
    
    func launchImageBubbleComponent() {
        let imageBubble = BubblesComponent()
        imageBubble.bubbleType = .imageBubble
        presentViewController(viewController: imageBubble, isNavigationController: false)
    }
    
    func launchVideoBubbleComponent() {
        let videoBubble = BubblesComponent()
        videoBubble.bubbleType = .videoBubble
        presentViewController(viewController: videoBubble, isNavigationController: false)
    }
    
    func launchAudioBubbleComponent() {
        let audioBubble = BubblesComponent()
        audioBubble.bubbleType = .audioBubble
        presentViewController(viewController: audioBubble, isNavigationController: false)
    }
    
    func launchFileBubbleComponent() {
        let fileBubble = BubblesComponent()
        fileBubble.bubbleType = .fileBubble
        presentViewController(viewController: fileBubble, isNavigationController: false)
    }
}

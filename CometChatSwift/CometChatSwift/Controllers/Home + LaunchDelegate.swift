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
    
    func launchCallHistoryWithDetails() {
        let callHistoryWithDetails = CometChatCallHistoryWithDetails()
        self.presentViewController(viewController: callHistoryWithDetails, isNavigationController: true)
        
    }
    func launchCallHistory() {
        let cometChatCallsHistory = CometChatCallsHistory()
        presentViewController(viewController: cometChatCallsHistory, isNavigationController: true)
    }
    
    func launchCallDetails() {
        CometChat.getUser(UID: "superhero2", onSuccess: { user in
            DispatchQueue.main.async {
                let callDetails = CometChatCallDetails()
                callDetails.set(user: user)
                self.presentViewController(viewController: callDetails, isNavigationController: true)
            }
        }, onError: { error in
            self.showAlert(title: "Error", msg: error?.errorDescription ?? "")
        })
    }
        
    func launchOutgoingCall() {
        let outgoingCall = CometChatOutgoingCall()
        let user = User(uid: "superhero4", name: "Wolverine")
        user.avatar = "https://data-us.cometchat.io/assets/images/avatars/wolverine.png"
        outgoingCall.set(user: user)
        outgoingCall.setOnCancelClick { call, controller in
            controller?.dismiss(animated: true)
        }
        presentViewController(viewController: outgoingCall, isNavigationController: false)
    }
    
    func launchIncomingCall() {
        let incomingCall = CometChatIncomingCall()
        let user = User(uid: "superhero4", name: "Wolverine")
        user.avatar = "https://data-us.cometchat.io/assets/images/avatars/wolverine.png"
        incomingCall.set(user: user)
        incomingCall.setOnCancelClick { call, controller in
            controller?.dismiss(animated: true)
            CometChatSoundManager().pause()
        }
        incomingCall.setOnAcceptClick { call, controller in
            controller?.dismiss(animated: true)
            CometChatSoundManager().pause()
        }
        presentViewController(viewController: incomingCall, isNavigationController: false)
    }
    
    func launchOngoingCall() {
        let ongoingCall = CometChatOngoingCall()
        ongoingCall.set(sessionId: "abc")
        presentViewController(viewController: ongoingCall, isNavigationController: false)
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
}

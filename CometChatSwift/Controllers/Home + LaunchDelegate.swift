//
//  Home + LaunchDelegate.swift
//  CometChatSwift
//
//  Created by admin on 12/10/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import Foundation
import CometChatSDK
import CometChatUIKitSwift
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
    
    func launchContacts() {
        let contact = CometChatContacts()

        contact.setSelectionMode(selectionMode: .none)
        
        let naviVC = UINavigationController(rootViewController: contact)
        
        presentViewController(viewController: naviVC, isNavigationController: false)
    }
    
    ///Calls
    func launchCallButtonComponent() {
        let callButtons = CallButtonsComponent()
        presentViewController(viewController: callButtons, isNavigationController: false)
    }
    
    func launchCallLogsComponent() {
        #if canImport(CometChatCallsSDK)
        let callLogs = CometChatCallLogs()
        presentViewController(viewController: callLogs, isNavigationController: true)
        #else
        self.showAlert(title: "Calls SDK is Installed", msg: "Calls SDK is required to access this class")
        #endif
    }
    
    func launchCallLogsWithDetailsComponent() {
        #if canImport(CometChatCallsSDK)
        let callLogsWithDetails = CometChatCallLogsWithDetails()
        presentViewController(viewController: callLogsWithDetails, isNavigationController: true)
        #else
        self.showAlert(title: "Calls SDK is Installed", msg: "Calls SDK is required to access this class")
        #endif
    }
    
    func launchCallLogDetailsComponent() {
        #if canImport(CometChatCallsSDK)
        let callLog = DummyObject.callLog(user: CometChat.getLoggedInUser())
        let callLogDetails = CometChatCallLogDetails()
        callLogDetails.set(callLog: callLog)
        presentViewController(viewController: callLogDetails, isNavigationController: true)
        #else
        self.showAlert(title: "Calls SDK is Installed", msg: "Calls SDK is required to access this class")
        #endif
    }
    
    func launchCallLogParticipantComponent() {
        #if canImport(CometChatCallsSDK)
        let callLogParticipant = CometChatCallLogParticipant()
            .set(callLog: DummyObject.callLog(user: CometChat.getLoggedInUser()))
        presentViewController(viewController: callLogParticipant, isNavigationController: true)
        #else
        self.showAlert(title: "Calls SDK is Installed", msg: "Calls SDK is required to access this class")
        #endif
    }
    
    func launchCallLogRecordingComponent() {
        #if canImport(CometChatCallsSDK)
        let callLogRecording = CometChatCallLogRecording()
            .set(recordings: DummyObject.callLog(user: CometChat.getLoggedInUser()).recordings)
        presentViewController(viewController: callLogRecording, isNavigationController: true)
        #else
        self.showAlert(title: "Calls SDK is Installed", msg: "Calls SDK is required to access this class")
        #endif
    }
    
    func launchCallLogHistoryComponent() {
        #if canImport(CometChatCallsSDK)
        let callLogHistory = CometChatCallLogHistory()
            .set(uid: CometChat.getLoggedInUser()?.uid != "superhero1" ? "superhero1" : "superhero2")
        presentViewController(viewController: callLogHistory, isNavigationController: true)
        #else
        self.showAlert(title: "Calls SDK is Installed", msg: "Calls SDK is required to access this class")
        #endif
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
    
    func launchMessageInformation() {
        var types = [String]()
        var categories = [String]()
        var templates = [(type: String, template: CometChatMessageTemplate)]()
        let messageTypes =  CometChatUIKit.getDataSource().getAllMessageTemplates()
        for template in messageTypes {
            if !(categories.contains(template.category)){
                categories.append(template.category)
            }
            if !(types.contains(template.type)){
                types.append(template.type)
            }
            templates.append((type: template.type, template: template))
        }
        
        let messageInformationController = CometChatMessageInformation()
        let navigationController = UINavigationController(rootViewController: messageInformationController)
        
        let message = TextMessage(receiverUid: CometChatUIKit.getLoggedInUser()?.uid ?? "", text: "Hi", receiverType: .user)
        message.readAt = Date().timeIntervalSince1970
        message.deliveredAt = Date().timeIntervalSince1970
        message.sender = CometChatUIKit.getLoggedInUser()
        message.receiver = CometChatUIKit.getLoggedInUser()
        messageInformationController.set(message: message)
        
        if let template = templates.filter({$0.template.type == MessageUtils.getDefaultMessageTypes(message: message) && $0.template.category == MessageUtils.getDefaultMessageCategories(message: message) }).first?.template {
            messageInformationController.set(template: template)
        }
        
        presentViewController(viewController: navigationController, isNavigationController: false)
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
    
    func launchFormBubbleComponent() {
        let formBubble = BubblesComponent()
        formBubble.bubbleType = .formBubble
        presentViewController(viewController: formBubble, isNavigationController: false)
    }
    
    func launchCardBubbleComponent() {
        let cardBubble = BubblesComponent()
        cardBubble.bubbleType = .cardBubble
        presentViewController(viewController: cardBubble, isNavigationController: false)
    }
    
    func launchSchedulerComponent() {
        let schedulerBubble = BubblesComponent()
        schedulerBubble.bubbleType = .schdulaBubble
        presentViewController(viewController: schedulerBubble, isNavigationController: false)
    }
    
    func launchMediaRecorderComponent() {
        let cometChatMediaRecorder = UIStoryboard(name: "CometChatMediaRecorder", bundle: CometChatUIKit.bundle).instantiateViewController(identifier: "CometChatMediaRecorder") as? CometChatMediaRecorder
        DispatchQueue.main.async {
            let blurredView = cometChatMediaRecorder?.blurView(view: cometChatMediaRecorder?.view ?? UIView())
            cometChatMediaRecorder?.view.addSubview(blurredView!)
            cometChatMediaRecorder?.view.sendSubviewToBack(blurredView!)
        }
        if let cometChatMediaRecorder = cometChatMediaRecorder {
            presentViewController(viewController: cometChatMediaRecorder, isNavigationController: false)
        }
    }
}

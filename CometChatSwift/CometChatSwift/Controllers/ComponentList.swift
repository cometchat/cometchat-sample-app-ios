//  ComponentList.swift
//  ios-chat-uikit-app
//  Created by CometChat Inc. on 18/12/19.
//  Copyright © 2020 CometChat Inc. All rights reserved.

import UIKit
import CometChatUIKitSwift
import CometChatSDK

protocol LaunchDelegate {

    ///Chats
    func launchConversationsWithMessages()
    func launchConversations()
    func launchListItemForConversation()
    func launchContacts()
    
    /// Calls
    func launchCallButtonComponent()

    ///Users
    func launchUsersWithMessages()
    func launchUsers()
    func launchListItemForUser()
    func launchDetailsForUser()
    
    ///Groups
    func launchGroupsWithMessages()
    func launchGroups()
    func launchListItemForGroup()
    func launchCreateGroup()
    func launchJoinPasswordProtectedGroup()
    func launchViewMembers()
    func launchAddMembers()
    func launchBannedMembers()
    func launchTransferOwnership()
    func launchDetailsForGroup()
    
    ///Messages
    func launchMessages()
    func launchMessageHeader()
    func launchMessageList()
    func launchMessageComposer()
    func launchMessageInformation()
    
    ///Shared
    ///Resources
    func launchSoundManagerComponent()
    func launchThemeComponent()
    func launchLocalizeComponent()
    

    ///View Componensts
    func launchAvatarComponent()
    func launchBadgeCountComponent()
    func launchStatusIndicatorComponent()
    func launchMessageReceiptComponent()
    func launchTextBubbleComponent()
    func launchImageBubbleComponent()
    func launchVideoBubbleComponent()
    func launchAudioBubbleComponent()
    func launchFileBubbleComponent()
    func launchMediaRecorderComponent()
    func launchListItem()
    
}

class ComponentList: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var componentsTable: UITableView!
    
    //MARK: VARIABLES
    var moduleType : moduleType = .chats
    var customData : CustomJSONModel?
    static var launchDelegate : LaunchDelegate?
    
    //MARK: LIFE CYLCE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getCustomData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavBar()
    }
    
    func setupTableView() {
        componentsTable.separatorStyle = .none
        componentsTable.delegate = self
        componentsTable.dataSource = self
        let UICompoenentCell  = UINib.init(nibName: "UIComponentsCell", bundle: nil)
        componentsTable.register(UICompoenentCell, forCellReuseIdentifier: "uiComponentsCell")
    }
    
    func getCustomData() {
        customData =  JsonDecoding.decodeJsonIntoCodable(jsonString: ModulesJson.jsonString)
        componentsTable.reloadData()
    }
    
    func setUpNavBar() {
        self.navigationItem.title = ""
        let backButton = UIBarButtonItem()
        switch moduleType {
        case .chats:
            backButton.title = "Chats"
        case .messages:
            backButton.title = "Messages"
        case .users:
            backButton.title = "Users"
        case .groups:
            backButton.title = "Groups"
        case .shared:
            backButton.title = "Shared"
        case .calls:
            backButton.title = "Calls"
        }
        backButton.setTitleTextAttributes([ NSAttributedString.Key.font:  UIFont.boldSystemFont(ofSize: 20)], for: .normal)
        backButton.tintColor = UIColor(named: "label1")
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.view.tintColor = UIColor.black
        self.navigationController?.navigationBar.isTranslucent = true
    }
}

extension ComponentList: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch moduleType {
        case .chats :
            return customData?.chat.count ?? 0
        case .messages:
            return customData?.message.count ?? 0
        case .groups:
            return customData?.groups.count ?? 0
        case .shared:
            return customData?.shared.count ?? 0
        case .users:
            return customData?.users.count ?? 0
        case .calls:
            return customData?.calls.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch moduleType {
        case .chats :
            return customData?.chat[section].count ?? 0
        case .messages:
            return customData?.message[section].count ?? 0
        case .groups:
            return customData?.groups[section].count ?? 0
        case .shared:
            return customData?.shared[section].count ?? 0
        case .users:
            return customData?.users[section].count ?? 0
        case .calls:
            return customData?.calls[section].count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let componentCell = tableView.dequeueReusableCell(withIdentifier: "uiComponentsCell") as? UIComponentsCell else { fatalError() }
        switch moduleType {
        case .chats :
            componentCell.setUpCell(customData: customData?.chat[indexPath.section] ?? [], indexPath: indexPath)
        case .messages:
            componentCell.setUpCell(customData: customData?.message[indexPath.section] ?? [], indexPath: indexPath)
        case .groups:
            componentCell.setUpCell(customData: customData?.groups[indexPath.section] ?? [], indexPath: indexPath)
        case .shared:
            componentCell.setUpCell(customData: customData?.shared[indexPath.section] ?? [], indexPath: indexPath)
        case .users:
            componentCell.setUpCell(customData: customData?.users[indexPath.section] ?? [], indexPath: indexPath)
        case .calls:
            componentCell.setUpCell(customData: customData?.calls[indexPath.section] ?? [], indexPath: indexPath)
        }
        return componentCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        launchComponent(section: indexPath.section, rowIndex: indexPath.row, moduleType: moduleType)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header  = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
        let lable = UILabel(frame: CGRect(x: 20, y: 0, width: header.frame.size.width, height: header.frame.size.height - 4))
        lable.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lable.textColor = .systemGray
        header.addSubview(lable)
        if moduleType == .shared {
            switch section {
            case 0:
                lable.text = "Resources"
            case 1:
                lable.text = "Views"
            default:
                break
            }
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if moduleType == .shared {
            return 30.0
        } else {
            return CGFloat.leastNonzeroMagnitude
        }
    }
}

///this method is used to launch componenets of the following modules: -
///Chats, Users, Messages, Groups, Shared
extension ComponentList {
    func launchComponent(section : Int , rowIndex: Int , moduleType: moduleType) {
        switch moduleType {
        case .chats:
            switch (section, rowIndex) {
            case (0,0):
                ComponentList.launchDelegate?.launchConversationsWithMessages()
            case (0, 1):
                ComponentList.launchDelegate?.launchConversations()
            case (0,2):
                ComponentList.launchDelegate?.launchListItemForConversation()
            case (0,3):
                ComponentList.launchDelegate?.launchContacts()
            case (_, _):
                break
            }

        case .messages:
            switch (section, rowIndex) {
            case (0,0):
                ComponentList.launchDelegate?.launchMessages()
            case (0, 1):
                ComponentList.launchDelegate?.launchMessageHeader()
            case (0,2):
                ComponentList.launchDelegate?.launchMessageList()
            case (0,3):
                ComponentList.launchDelegate?.launchMessageComposer()
            case (0,4):
                ComponentList.launchDelegate?.launchMessageInformation()
            case (_, _):
                break
            }
            
        case .users:
            switch (section, rowIndex) {
            case (0,0):
                ComponentList.launchDelegate?.launchUsersWithMessages()
            case (0, 1):
                ComponentList.launchDelegate?.launchUsers()
            case (0,2):
                ComponentList.launchDelegate?.launchListItemForUser()
            case (0,3):
                ComponentList.launchDelegate?.launchDetailsForUser()
            case (_, _):
                break
            }

        case .groups:
            switch (section, rowIndex) {
            case (0,0):
                ComponentList.launchDelegate?.launchGroupsWithMessages()
            case (0, 1):
                ComponentList.launchDelegate?.launchGroups()
            case (0,2):
                ComponentList.launchDelegate?.launchListItemForGroup()
            case (0,3):
                ComponentList.launchDelegate?.launchCreateGroup()
            case (0,4):
                ComponentList.launchDelegate?.launchJoinPasswordProtectedGroup()
            case (0, 5):
                ComponentList.launchDelegate?.launchViewMembers()
            case (0,6):
                ComponentList.launchDelegate?.launchAddMembers()
            case (0,7):
                ComponentList.launchDelegate?.launchBannedMembers()
            case (0,8):
                ComponentList.launchDelegate?.launchTransferOwnership()
            case (0,9):
                ComponentList.launchDelegate?.launchDetailsForGroup()
                
            case (_, _):
                break
            }
            
        case .shared:
            switch (section, rowIndex) {
            case (0,0):
                ComponentList.launchDelegate?.launchSoundManagerComponent()
            case (0, 1):
                ComponentList.launchDelegate?.launchThemeComponent()
            case (0,2):
                ComponentList.launchDelegate?.launchLocalizeComponent()
                
            case (1,0):
                ComponentList.launchDelegate?.launchAvatarComponent()
            case (1, 1):
                ComponentList.launchDelegate?.launchBadgeCountComponent()
            case (1,2):
                ComponentList.launchDelegate?.launchStatusIndicatorComponent()
            case (1,3):
                ComponentList.launchDelegate?.launchMessageReceiptComponent()
            case (1,4):
                ComponentList.launchDelegate?.launchTextBubbleComponent()
            case (1,5):
                ComponentList.launchDelegate?.launchImageBubbleComponent()
            case (1,6):
                ComponentList.launchDelegate?.launchVideoBubbleComponent()
            case (1,7):
                ComponentList.launchDelegate?.launchAudioBubbleComponent()
            case (1,8):
                ComponentList.launchDelegate?.launchFileBubbleComponent()
            case (1,9):
                ComponentList.launchDelegate?.launchMediaRecorderComponent()
                
            case (1,10):
                ComponentList.launchDelegate?.launchListItem()
       
            
            case (_, _):
                break
            }
            
        case .calls:
            switch (section, rowIndex) {
            case (0,0):
                ComponentList.launchDelegate?.launchCallButtonComponent()
            case (_, _):
                break
            }
        }
    }
}





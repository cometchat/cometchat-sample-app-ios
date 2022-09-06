//
//  UIComponentsController.swift
//  ios-chat-uikit-app
//
//  Created by CometChat Inc. on 18/12/19.
//  Copyright © 2020 CometChat Inc. All rights reserved.
//

import UIKit
import CometChatUIKit
import CometChatPro


class ComponentList: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var componentsTable: UITableView!
    
    var moduleType : moduleType = .chats
    var customData : CustomJSONModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getCustomData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavBar()
    }
    
    func setupTableView(){
        componentsTable.separatorStyle = .none
        componentsTable.delegate = self
        componentsTable.dataSource = self
        let UICompoenentCell  = UINib.init(nibName: "UIComponentsCell", bundle: nil)
        componentsTable.register(UICompoenentCell, forCellReuseIdentifier: "uiComponentsCell")
    }
    
    func getCustomData(){
        customData =  JsonDecoding.decodeJsonIntoCodable(jsonString: ModulesJson.jsonString)
        componentsTable.reloadData()
    }
    
    
    func setUpNavBar(){
        
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
        }

        backButton.setTitleTextAttributes([ NSAttributedString.Key.font:  UIFont.boldSystemFont(ofSize: 20)], for: .normal)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.view.tintColor = UIColor.black
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    
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
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let componentCell = tableView.dequeueReusableCell(withIdentifier: "uiComponentsCell") as! UIComponentsCell
        
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
                lable.text = "Primary"
            case 1:
                lable.text = "SDK Derived"
            case 2:
                lable.text = "Secondary"
            default:
                break
            }
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if moduleType == .shared {
            return 30.0
        }else {
            return CGFloat.leastNonzeroMagnitude

        }
        
    }
}



extension ComponentList {
    
    //this method is used to launch componenets of the following modules: -  Chats, Users, Messages, Groups, Shared
    func launchComponent(section : Int , rowIndex: Int , moduleType: moduleType){
        switch moduleType {
        case .chats where section == 0 && rowIndex == 0 :
            presentViewController(viewController: CometChatConversationsWithMessages(), isNavigationController: true)
        case .chats where section == 0 && rowIndex == 1 :
            presentViewController(viewController: CometChatConversations(), isNavigationController: true)
        case .chats where section == 0 && rowIndex == 2 :
            presentViewController(viewController: CometChatConversationListComponent(), isNavigationController: false)
        case .chats where section == 0 && rowIndex == 3 :
            presentViewController(viewController: CometChatConversationListItemComponent(), isNavigationController: false)
            
        case .messages where section == 0 && rowIndex == 0 :
            CometChat.getGroup(GUID: "supergroup", onSuccess: { group in
                DispatchQueue.main.async {
                    let messages = CometChatMessages()
                    messages.set(group: group)
                    self.presentViewController(viewController: messages, isNavigationController: true)
                }
            }, onError: { error in
                self.showAlert(title: "Error", msg: error?.errorDescription ?? "")
            })
            
        case .messages where section == 0 && rowIndex == 1 :
            let messageHeader = MessageHeaderComponent()
            presentViewController(viewController: messageHeader, isNavigationController: false)
        case .messages where section == 0 && rowIndex == 2 :
            CometChat.getGroup(GUID: "supergroup", onSuccess: { group in
                DispatchQueue.main.async {
                    let messageList = MessageListComponent()
                    messageList.group = group
                    self.presentViewController(viewController: messageList, isNavigationController: false)
                }
            }, onError: { error in
                self.showAlert(title: "Error", msg: error?.errorDescription ?? "")
            })
            
        case .messages where section == 0 && rowIndex == 3 :
            let messageComposer = MesaageComposerComponent()
            presentViewController(viewController: messageComposer, isNavigationController: false)
            
            
            
        case .users where section == 0 && rowIndex == 0 :
            presentViewController(viewController: CometChatUsersWithMessages(), isNavigationController: true)
        case .users where section == 0 && rowIndex == 1 :
            presentViewController(viewController: CometChatUsers(), isNavigationController: true)
        case .users where section == 0 && rowIndex == 2 :
            presentViewController(viewController: UsersListComponent(), isNavigationController: false)
        case .users where section == 0 && rowIndex == 3 :
            let userDataItem = UserDataItemComponent()
           // userDataItem.isUser = true
            presentViewController(viewController: userDataItem, isNavigationController: false)
            
            
        case .groups where section == 0 && rowIndex == 0 :
            presentViewController(viewController: CometChatGroupsWithMessages(), isNavigationController: true)
        case .groups where section == 0 && rowIndex == 1:
            presentViewController(viewController: CometChatGroups(), isNavigationController: true)
        case .groups where section == 0 && rowIndex == 2:
            presentViewController(viewController: GroupListComponent(), isNavigationController: false)
        case .groups where section == 0 && rowIndex == 3:
            let groupDataItem = GroupDataItem()
            presentViewController(viewController: groupDataItem, isNavigationController: false)
            
        case .shared where section == 0 && rowIndex == 0:
            self.presentViewController(viewController: SoundManagerComponent(), isNavigationController: false)
        case .shared where section == 0 && rowIndex == 1:
            let theme = ThemeComponent()
            self.presentViewController(viewController: theme, isNavigationController: false)
        case .shared where section == 0 && rowIndex == 2:
            self.presentViewController(viewController: LocalisationComponent(), isNavigationController: false)
            
        case .shared where section == 1 && rowIndex == 0:
            self.presentViewController(viewController: CometChatConversationListItemComponent(), isNavigationController: false)
            
        case .shared where section == 1 && rowIndex == 1:
            let userDataItem = DataItem()
            self.presentViewController(viewController: userDataItem, isNavigationController: false)
            
        case .shared where section == 2 && rowIndex == 0 :
            let avatarModification = AvatarModification()
            self.presentViewController(viewController: avatarModification, isNavigationController: false)
            
        case .shared where section == 2 && rowIndex == 1:
            let badgeCountViewController = BadgeCountModification()
            self.presentViewController(viewController: badgeCountViewController, isNavigationController: false)
            
        case .shared where section == 2 && rowIndex == 2:
            let statusIndicatorModification = StatusIndicatorModification()
            self.presentViewController(viewController: statusIndicatorModification, isNavigationController: false)
        
           
        case .shared where section == 2 && rowIndex == 3:
            let messageReceipt = MessageReceiptModification()
            self.presentViewController(viewController: messageReceipt, isNavigationController: false)

                        
        case .groups: break
        case .shared: break
        case .chats:  break
        case .messages: break
        case .users: break
        }
    }
    
}

extension ComponentList {
    func presentViewController(viewController : UIViewController,isNavigationController: Bool){
        if isNavigationController {
            let navigationController = UINavigationController(rootViewController: viewController)
            self.present(navigationController, animated: true)
        } else {
            self.present(viewController, animated: true)
        }
    }
    
}



//
//  UIComponentsController.swift
//  ios-chat-uikit-app
//
//  Created by CometChat Inc. on 18/12/19.
//  Copyright © 2020 CometChat Inc. All rights reserved.
//

import UIKit

class UIComponentController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var componentsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        setupTableView()
    }
    
    func setupTableView(){
        componentsTable.separatorStyle = .none
        componentsTable.delegate = self
        componentsTable.dataSource = self
        let UICompoenentCell  = UINib.init(nibName: "UIComponentsCell", bundle: nil)
        componentsTable.register(UICompoenentCell, forCellReuseIdentifier: "uiComponentsCell")
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let componentCell = tableView.dequeueReusableCell(withIdentifier: "uiComponentsCell") as! UIComponentsCell
            componentCell.componentName.text = "Avatar"
            componentCell.componentDescription.text = "This component will be the class of UIImageView which is customizable to display Avatar."
            return componentCell
            
        case 1:
            let componentCell = tableView.dequeueReusableCell(withIdentifier: "uiComponentsCell") as! UIComponentsCell
            componentCell.componentName.text = "Status Indicator"
            componentCell.componentDescription.text = "This component will be the class of UIImageView which is customizable to display the status of the user."
            return componentCell
            
        case 2:
            let componentCell = tableView.dequeueReusableCell(withIdentifier: "uiComponentsCell") as! UIComponentsCell
            componentCell.componentName.text = "Badge Count"
            componentCell.componentDescription.text = "This component will be the class of UILabel which is customizable to display the unread count of the messages in conversations."
            return componentCell
        case 3:
            
            let componentCell = tableView.dequeueReusableCell(withIdentifier: "uiComponentsCell") as! UIComponentsCell
            componentCell.componentName.text = "User View"
            componentCell.componentDescription.text = "This component will be the class of UITableViewCell which is customizable to display list of users."
            return componentCell
        case 4:
            
            let componentCell = tableView.dequeueReusableCell(withIdentifier: "uiComponentsCell") as! UIComponentsCell
            componentCell.componentName.text = "Group View"
            componentCell.componentDescription.text = "This component will be the class of UITableViewCell which is customizable to display list of groups."
            return componentCell
        case 5:
            
            let componentCell = tableView.dequeueReusableCell(withIdentifier: "uiComponentsCell") as! UIComponentsCell
            componentCell.componentName.text = "Conversation View"
            componentCell.componentDescription.text = "This component will be the class of UITableViewCell which is customizable to display list of recent conversation."
            return componentCell
            
        case 6:
            
            let componentCell = tableView.dequeueReusableCell(withIdentifier: "uiComponentsCell") as! UIComponentsCell
            componentCell.componentName.text = "Call View"
            componentCell.componentDescription.text = "This component will be the class of UITableViewCell which is customizable to display list of recent calls."
            return componentCell
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            
            let componentModificationsController = storyboard?.instantiateViewController(withIdentifier: "componentModificationsController") as? ComponentModificationsController
            componentModificationsController?.isAvatarView = true
            self.navigationController?.pushViewController(componentModificationsController!, animated: true)
            
        case 1:
            
            let componentModificationsController = storyboard?.instantiateViewController(withIdentifier: "componentModificationsController") as? ComponentModificationsController
            componentModificationsController?.isStatusIndicatorView = true
            self.navigationController?.pushViewController(componentModificationsController!, animated: true)
            
        case 2:
            let componentModificationsController = storyboard?.instantiateViewController(withIdentifier: "componentModificationsController") as? ComponentModificationsController
            
            componentModificationsController?.isBadgeCountView = true
            self.navigationController?.pushViewController(componentModificationsController!, animated: true)
        case 3:
            
            let userList = CometChatUserList()
            self.navigationController?.pushViewController(userList, animated: true)
            
        case 4:
            let groupList = CometChatGroupList()
            self.navigationController?.pushViewController(groupList, animated: true)
            
        case 5:
            let conversationList = CometChatConversationList()
            self.navigationController?.pushViewController(conversationList, animated: true)
            
        case 6:
            let callList = CometChatCallsList()
            self.navigationController?.pushViewController(callList, animated: true)
        default:break
        }
        
        
        
    }
    
    
}

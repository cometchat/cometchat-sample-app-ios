//
//  CCTabBarController.swift
//  CometChatUI
//
//  Created by pushpsen airekar on 18/11/18.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.
//

import UIKit
import CometChatPro

class CCTabBarController: UITabBarController,UITabBarControllerDelegate {
    
    //Variable Declaration
    var tab1:ConversationsNavigationController!
    var tab2:UsersNavigationController!
    var tab3:GroupNavigationController!
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Function Calling
        self.handleViewControllers()
//        self.getUnreadCountForConversations()
        self.getUnreadCountForGroup()
        self.getUnreadCountForUser()
    }
    
 
    func handleViewControllers(){
        
        //This function handles the view controller appearance in tabbars.
        
        tab1 = ConversationsNavigationController()
        tab2 = UsersNavigationController()
        tab3 = GroupNavigationController()
        
        tab1 = storyboard?.instantiateViewController(withIdentifier: "ConversationsNavigationController") as? ConversationsNavigationController
        tab2 = storyboard?.instantiateViewController(withIdentifier: "UsersNavigationController") as? UsersNavigationController
        tab3 = storyboard?.instantiateViewController(withIdentifier: "groupNavigationController") as? GroupNavigationController
        
        
        let ConversationsIcon = UITabBarItem(title: NSLocalizedString("Conversations", comment: ""), image: UIImage(named: "Conversations.png"), selectedImage: UIImage(named: "Conversations.png"))
        
        let contactIcon = UITabBarItem(title: NSLocalizedString("Users", comment: ""), image: UIImage(named: "contact.png"), selectedImage: UIImage(named: "contact.png"))
        
        let groupIcon = UITabBarItem(title: NSLocalizedString("Groups", comment: ""), image: UIImage(named: "Groups.png"), selectedImage: UIImage(named: "Groups.png"))
        
        tab1.tabBarItem = ConversationsIcon
        tab2.tabBarItem = contactIcon
        tab3.tabBarItem = groupIcon
        
        
        let controllers = [tab1,tab2,tab3] as [Any]  //array of the root view controllers displayed by the tab bar interface
        self.viewControllers = controllers as? [UIViewController]
        // tabBarController?.selectedIndex = 1
    }
    
    
 
    
    func getUnreadCountForConversations(){
        
        
        CometChat.getUnreadMessageCount(hideMessagesFromBlockedUsers: false, onSuccess: { (response) in
             print("get unread count for All Conversations...\(response)")
            let users = response["user"] as? [String:Any]
            let groups = response["group"] as? [String:Any]
            let count:Int = (users?.keys.count ?? 0) + (groups?.keys.count ?? 0)
            
            DispatchQueue.main.async {
                           if count == 0 {
                               self.tab1.tabBarItem.badgeValue = nil
                           }else{
                            self.tab1.tabBarItem.badgeValue = "\(String(describing: count))"
                           }
                     }
        }) { (error) in
           print("error in fetching unread count for all Conversations")
        }
    }
    
    func getUnreadCountForUser(){
        CometChat.getUnreadMessageCountForAllUsers(onSuccess: { response in
            
            print("get unread count for All users...\(response)")
            DispatchQueue.main.async {
                if response.count == 0 {
                    self.tab2.tabBarItem.badgeValue = nil
                }else{
                    self.tab2.tabBarItem.badgeValue = "\(response.count)"
                }
            }
        }) { (error) in
            
            print("error in fetching unread count for all users")
        }
    }
    
    func getUnreadCountForGroup(){
        
        CometChat.getUnreadMessageCountForAllGroups(onSuccess: { (response) in
            
            print("get unread count for All Group...\(response)")
            DispatchQueue.main.async {
                if response.count == 0 {
                     self.tab3.tabBarItem.badgeValue = nil
                }else{
                  self.tab3.tabBarItem.badgeValue = "\(response.count)"
                }
            }
        }) { (error) in
             print("error in fetching unread count for all Group")
        }
        
    }
    
    
    
    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(String(describing: viewController.title)) ?")
        return true;
    }
    
}

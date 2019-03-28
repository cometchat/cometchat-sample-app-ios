//
//  CCTabBarController.swift
//  CometChatUI
//
//  Created by pushpsen airekar on 18/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit

class CCTabBarController: UITabBarController,UITabBarControllerDelegate {
    
    //Variable Declaration
    var tab1:RecentNavigationController!
    var tab2:ContactsNavigationController!
    var tab3:GroupNavigationController!
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Function Calling
        self.handleViewControllers()
    }
    
    func handleViewControllers(){
        
        //This function handles the view controller appearance in tabbars.
        
        tab1 = RecentNavigationController()
        tab2 = ContactsNavigationController()
        tab3 = GroupNavigationController()
        
        tab1 = storyboard?.instantiateViewController(withIdentifier: "recentNavigationController") as? RecentNavigationController
        tab2 = storyboard?.instantiateViewController(withIdentifier: "contactsNavigationController") as? ContactsNavigationController
        tab3 = storyboard?.instantiateViewController(withIdentifier: "groupNavigationController") as? GroupNavigationController
        
        
        let recentIcon = UITabBarItem(title: "Chats", image: UIImage(named: "recent.png"), selectedImage: UIImage(named: "recent.png"))
        
        let contactIcon = UITabBarItem(title: "Contacts", image: UIImage(named: "contact.png"), selectedImage: UIImage(named: "contact.png"))
        
        let groupIcon = UITabBarItem(title: "Groups", image: UIImage(named: "Groups.png"), selectedImage: UIImage(named: "Groups.png"))
        
        tab1.tabBarItem = recentIcon
        tab2.tabBarItem = contactIcon
        tab3.tabBarItem = groupIcon
        
        
        let controllers = [tab3,tab2] as [Any]  //array of the root view controllers displayed by the tab bar interface
        self.viewControllers = controllers as? [UIViewController]
        // tabBarController?.selectedIndex = 1
    }
    
    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(String(describing: viewController.title)) ?")
        return true;
    }
    
}

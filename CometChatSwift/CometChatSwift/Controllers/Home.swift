//
//  mainController.swift
//  Demo
//
//  Created by CometChat Inc. on 17/12/19.
//  Copyright © 2020 CometChat Inc. All rights reserved.
//

import UIKit
import CometChatPro
import CometChatUIKit

enum moduleType {
    case chats
    case messages
    case users
    case groups
    case shared
}


class Home: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var arrayModuleType = [moduleType]()
    private var identifier = "uiComponentsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CometChatTheme.defaultAppearance()
        arrayModuleType = [.chats, .users , .groups,.messages, .shared]
        setupTableView()
        setUpNavBar()
        congigureBarButtonItem()
    }
    
    
    internal func setUpNavBar(){        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .clear
        navBarAppearance.shadowColor = .clear
        
        let title = UILabel()
        title.text = "UI Components"
        title.textColor = .label
        title.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        title.sizeToFit()
        let leftItem = UIBarButtonItem(customView: title)
        self.navigationItem.leftBarButtonItem = leftItem
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationController?.view.backgroundColor = .systemGray6
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func congigureBarButtonItem(){
        
        let menuBtn = UIButton(type: .custom)
        menuBtn.setImage(UIImage(named:"logout"), for: .normal)
        menuBtn.addTarget(self, action: #selector(barButtonPressed), for: UIControl.Event.touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        self.navigationItem.rightBarButtonItem = menuBarItem
        
    }
    
    
    internal func setupTableView(){
        mainTableView.separatorColor = .clear
        let modulesCell = UINib.init(nibName: "UIComponentsCell", bundle: Bundle.main)
        self.mainTableView.register(modulesCell, forCellReuseIdentifier: identifier)
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayModuleType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let modulesCell = tableView.dequeueReusableCell(withIdentifier: identifier) as? UIComponentsCell else { return UITableViewCell() }
        modulesCell.moduleType = arrayModuleType[indexPath.row]
        return modulesCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let componentList = storyboard?.instantiateViewController(withIdentifier: "ComponentList") as? ComponentList
        switch arrayModuleType[indexPath.row]{
        case .chats:
            componentList?.moduleType = .chats
            
        case .messages:
            componentList?.moduleType = .messages
            
        case .users:
            componentList?.moduleType = .users
            
        case .groups:
            componentList?.moduleType = .groups
        
        case .shared:
            componentList?.moduleType = .shared
          
        }
        self.navigationController?.delegate = self
        if let componentList = componentList {
            self.navigationController?.pushViewController(componentList, animated: true)
        }
       
    }
}

extension Home {
    
    @objc func barButtonPressed(){
        
        // Declare Alert
        let dialogMessage = UIAlertController(title: "⚠️ Warning!", message: "Are you sure you want to Logout?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            CometChat.logout(onSuccess: { (success) in
                DispatchQueue.main.async {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let main = mainStoryboard.instantiateViewController(withIdentifier: "Main") as! Main
                    UIApplication.shared.keyWindow?.rootViewController = main
                    CometChatSnackBoard.display(message:  "Logged out successfully.", mode: .error, duration: .short)
                }
            }) { (error) in
                DispatchQueue.main.async {
                    CometChatSnackBoard.display(message:  error.errorDescription, mode: .error, duration: .short)
                }
            }
        })
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
        }
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
}

///These methods removes gray background appearance while pushing view controller
extension Home: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        UIView.preventDimmingView()
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        UIView.allowDimmingView()
    }
}


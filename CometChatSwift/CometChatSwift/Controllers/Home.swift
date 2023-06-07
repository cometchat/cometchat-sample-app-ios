//  Home.swift
//  Created by CometChat Inc. on 17/12/19.
//  Copyright © 2020 CometChat Inc. All rights reserved.

import UIKit
import CometChatPro
import CometChatUIKitSwift

enum moduleType {
    case chats
    case calls
    case messages
    case users
    case groups
    case shared
}

class Home: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var mainTableView: UITableView!
    
    //MARK: VARIABLES
    var arrayModuleType = [moduleType]()
    private var identifier = "uiComponentsCell"
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        ComponentList.launchDelegate = self
        arrayModuleType = [.chats, .calls ,.users , .groups,.messages, .shared]
        setupTableView()
        setUpNavBar()
        congigureBarButtonItem()
    }
    
    internal func setUpNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .clear
        navBarAppearance.shadowColor = .clear
        navigationController?.isNavigationBarHidden = false
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
    
    func congigureBarButtonItem() {
        let logout = UIButton(type: .custom)
        logout.contentMode = .scaleAspectFit
        logout.setImage(UIImage(named:"logout"), for: .normal)
        logout.addTarget(self, action: #selector(barButtonPressed), for: UIControl.Event.touchUpInside)
        logout.tintColor = UIColor(named: "label1")
        let logoutButton = UIBarButtonItem(customView: logout)
        logoutButton.customView?.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.customView?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        logoutButton.customView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
        let themeChange = UIButton(type: .custom)
        themeChange.setImage(UIImage(named: self.traitCollection.userInterfaceStyle == .dark ? "darkMode": "lightMode"), for: .normal)
        themeChange.addTarget(self, action: #selector(themeChangePressed), for: UIControl.Event.touchUpInside)
        themeChange.tintColor = UIColor(named: "label1")
        let themeChangeButton = UIBarButtonItem(customView: themeChange)
        themeChangeButton.customView?.translatesAutoresizingMaskIntoConstraints = false
        themeChangeButton.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        themeChangeButton.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        self.navigationItem.rightBarButtonItems = [logoutButton, themeChangeButton]
    }
    
    internal func setupTableView() {
        mainTableView.separatorColor = .clear
        let modulesCell = UINib.init(nibName: "UIComponentsCell", bundle: Bundle.main)
        self.mainTableView.register(modulesCell, forCellReuseIdentifier: identifier)
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        reloadInputViews()
        congigureBarButtonItem()
    }
}
    
extension Home: UITableViewDelegate, UITableViewDataSource  {
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
        switch arrayModuleType[indexPath.row] {
        case .chats: componentList?.moduleType = .chats
        case .messages: componentList?.moduleType = .messages
        case .users: componentList?.moduleType = .users
        case .groups: componentList?.moduleType = .groups
        case .shared: componentList?.moduleType = .shared
        case .calls: componentList?.moduleType = .calls
 
        }
        self.navigationController?.delegate = self
        if let componentList = componentList {
            self.navigationController?.pushViewController(componentList, animated: true)
        }
    }
}


extension Home {
    func presentViewController(viewController : UIViewController,isNavigationController: Bool, modalPresentationStyle: UIModalPresentationStyle? = .custom ) {
        if isNavigationController {
            let navigationController = UINavigationController(rootViewController: viewController)
            self.present(navigationController, animated: true)
        } else {
            viewController.modalPresentationStyle = modalPresentationStyle ?? .custom
            self.present(viewController, animated: false)
        }
    }
}

extension Home {
    
    @objc func themeChangePressed() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            switch self.traitCollection.userInterfaceStyle {
            case .unspecified:
                CometChatTheme.set(mode: .light, for: appDelegate.window)
            case .light:
                CometChatTheme.set(mode: .dark, for: appDelegate.window)
            case .dark:
                CometChatTheme.set(mode: .light, for: appDelegate.window)
            @unknown default:
                CometChatTheme.set(mode: .light, for: appDelegate.window)
            }
        }
    }
    
    
    @objc func barButtonPressed() {
        let dialogMessage = UIAlertController(title: "⚠️ Warning!", message: "Are you sure you want to Logout?", preferredStyle: .alert)
       
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            if let currentUser = CometChat.getLoggedInUser() {
            CometChatUIKit.logout(user: currentUser, result: { (result) in
                    switch result {
                    case .success(_):
                        DispatchQueue.main.async {
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let main = mainStoryboard.instantiateViewController(withIdentifier: "navbar")
                            UIApplication.shared.keyWindow?.rootViewController = main
                            self.showAlert(title: "", msg: "Logged out Successfully")
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.showAlert(title: "Error", msg: error.errorDescription)
                        }
                    }
                })
            }
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
        }
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
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


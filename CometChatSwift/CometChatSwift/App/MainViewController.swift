//
//  mainController.swift
//  Demo
//
//  Created by CometChat Inc. on 17/12/19.
//  Copyright © 2020 CometChat Inc. All rights reserved.
//

import UIKit
import CometChatPro

class MainViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupTableView()
        if #available(iOS 13.0, *) {
            view.backgroundColor = UIColor.systemBackground
        } else {}
        navigationItem.hidesBackButton = true
        self.modalPresentationStyle = .fullScreen
        
    }
    
    
    internal func setupTableView(){
        mainTableView.separatorColor = .clear
        let UnifiedCell  = UINib.init(nibName: "CometChatUICell", bundle: nil)
        self.mainTableView.register(UnifiedCell, forCellReuseIdentifier: "CometChatUICell")
        
        let UIComponentCell  = UINib.init(nibName: "CometChatUIComponentsCell", bundle: nil)
        self.mainTableView.register(UIComponentCell, forCellReuseIdentifier: "cometChatUIComponentsCell")
        
        let UIScreenCell  = UINib.init(nibName: "CometChatUIScreenCell", bundle: nil)
        self.mainTableView.register(UIScreenCell, forCellReuseIdentifier: "cometChatUIScreenCell")
        
        let callingCell  = UINib.init(nibName: "CometChatCallingCell", bundle: nil)
        self.mainTableView.register(callingCell, forCellReuseIdentifier: "cometChatCallingCell")
        
        let logoutCell  = UINib.init(nibName: "LogoutCell", bundle: nil)
        self.mainTableView.register(logoutCell, forCellReuseIdentifier: "logoutCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let launcherCell = tableView.dequeueReusableCell(withIdentifier: "CometChatUICell") as! CometChatUICell
            launcherCell.delegate = self
            return launcherCell
        }else if indexPath.row == 1 {
            let UIScreenCell = tableView.dequeueReusableCell(withIdentifier: "cometChatUIScreenCell") as! CometChatUIScreenCell
            UIScreenCell.delegate = self
            return UIScreenCell
        }else if indexPath.row == 2 {
            let UIComponentsCell = tableView.dequeueReusableCell(withIdentifier: "cometChatUIComponentsCell") as! CometChatUIComponentsCell
            UIComponentsCell.delegate = self
            return UIComponentsCell
        }else if indexPath.row == 3 {
            let callingCell = tableView.dequeueReusableCell(withIdentifier: "cometChatCallingCell") as! CometChatCallingCell
            callingCell.delegate = self
            return callingCell
        }else if indexPath.row == 4 {
            let LogoutCell = tableView.dequeueReusableCell(withIdentifier: "logoutCell") as! LogoutCell
            LogoutCell.delegate = self
            return LogoutCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 330
        }else if indexPath.row == 1{
             return 370
        }else if indexPath.row == 2{
            return 290
        }else if indexPath.row == 3{
             return 430
        } else{
            return 80
        }
    }
}

extension MainViewController: CometChatUICellDelegate {
    
    
    func didlaunchButtonPressed(_ sender: UIButton, segmentControl: UISegmentedControl) {
        let cometChatUI = CometChatUI()
        if segmentControl.selectedSegmentIndex == 0 {
            cometChatUI.setup(withStyle: .fullScreen)
        }else{
            cometChatUI.setup(withStyle: .popover)
        }
        self.present(cometChatUI, animated: true, completion: nil)
    }
    
}

extension MainViewController: CometChatUIComponentsCellDelegate {
   
    func didlaunchButtonPressed(_ sender: UIButton) {
        let UIComponents = storyboard?.instantiateViewController(withIdentifier: "uiComponentController") as? UIComponentController
        UIComponents?.navigationController?.title = "UIComponents"
        self.navigationController?.pushViewController(UIComponents!, animated: true)
    }
}

extension MainViewController: CometChatUIScreenCellDelegate {
    
    func didlaunchButtonPressed(_ sender: UIButton, with screenSegment: UISegmentedControl, styleSegment: UISegmentedControl) {
        
        let selectedStyle = styleSegment.selectedSegmentIndex
        let selectedScreen = screenSegment.selectedSegmentIndex
        let conversationList = CometChatConversationList()
        let callsList = CometChatCallsList()
        let userList = CometChatUserList()
        let groupList = CometChatGroupList()
        let messageList = CometChatMessageList()
        let userInfo = CometChatUserProfile()
        
        switch selectedStyle{
        case 0 where selectedScreen == 0:
            launchList(list: conversationList,title: "Chats",  mode: .fullScreen)
        case 0 where selectedScreen == 1:
            launchList(list: callsList,title: "Calls",  mode: .fullScreen)
        case 0 where selectedScreen == 2:
            launchList(list: userList,title: "Contacts",  mode: .fullScreen)
        case 0 where selectedScreen == 3:
            launchList(list: groupList,title: "Groups",  mode: .fullScreen)
        case 0 where selectedScreen == 4:
            launchList(list: messageList,title: "",  mode: .fullScreen)
        case 0 where selectedScreen == 5:
            launchList(list: userInfo,title: "More Info",  mode: .fullScreen)
            
        case 1 where selectedScreen == 0:
            launchList(list: conversationList,title: "Chats",  mode: .popover)
        case 1 where selectedScreen == 1:
            launchList(list: callsList,title: "Calls",  mode: .popover)
        case 1 where selectedScreen == 2:
            launchList(list: userList,title: "Contacts",  mode: .popover)
        case 1 where selectedScreen == 3:
            launchList(list: groupList,title: "Groups",  mode: .popover)
        case 1 where selectedScreen == 4:
            launchList(list: messageList,title: "",  mode: .popover)
        case 1 where selectedScreen == 5:
            launchList(list: userInfo,title: "More Info",  mode: .popover)
            
        default: break
        }
    }
    
    private func launchList(list: UIViewController,title: String, mode: UIModalPresentationStyle) {
           let navigationController = UINavigationController(rootViewController: list)
           navigationController.modalPresentationStyle = mode
           if let conversationList = list as? CometChatConversationList {
               conversationList.set(title: title, mode: .automatic)
               self.present(navigationController, animated: true, completion: nil)
           }
           if let calls = list as? CometChatCallsList {
               calls.set(title: title, mode: .automatic)
               self.present(navigationController, animated: true, completion: nil)
           }
           if let users = list as? CometChatUserList {
               users.set(title: title, mode: .automatic)
               self.present(navigationController, animated: true, completion: nil)
           }
           if let groups = list as? CometChatGroupList {
               groups.set(title: title, mode: .automatic)
               self.present(navigationController, animated: true, completion: nil)
           }
           
        if let messages = list as? CometChatMessageList {
            CometChat.joinGroup(GUID: "supergroup", groupType: .public, password: nil , onSuccess: { (group) in
                DispatchQueue.main.async {
                    messages.set(conversationWith: group, type: .group)
                    self.present(navigationController, animated: true, completion: nil)
                }
            }) { (error) in
                DispatchQueue.main.async {
                    if error?.errorCode == "ERR_ALREADY_JOINED" {
                        CometChat.getGroup(GUID: "supergroup", onSuccess: { (group) in
                            DispatchQueue.main.async {
                                messages.set(conversationWith: group, type: .group)
                                self.present(navigationController, animated: true, completion: nil)
                            }
                        }) { (error) in
                            DispatchQueue.main.async {
                                if let errorMessage = error?.errorDescription {
                                    CometChatSnackBoard.display(message:  errorMessage, mode: .error, duration: .short)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        if let info = list as? CometChatUserProfile {
            info.set(title: title, mode: .automatic)
            self.present(navigationController, animated: true, completion: nil)
        }
       }
}

extension MainViewController: CometChatCallingCellDelegate {
    
    
    func didMakeCallButtonPressed(_ sender: UIButton, with userSegment: UISegmentedControl, typeSegment: UISegmentedControl, callTypeSegment: UISegmentedControl) {
        
        let selectedUser = userSegment.selectedSegmentIndex
        let selectedType = typeSegment.selectedSegmentIndex
        let selectedCall = callTypeSegment.selectedSegmentIndex
        
        switch selectedType {
        case 0 where selectedCall == 0:
            switch selectedUser {
            case 0: self.initiateCall(to: "superhero1", type: .user, callType: .audio)
            case 1: self.initiateCall(to: "superhero2", type: .user, callType: .audio)
            case 2: self.initiateCall(to: "superhero3", type: .user, callType: .audio)
            case 3: self.initiateCall(to: "superhero4", type: .user, callType: .audio)
            case 4: self.initiateCall(to: "superhero5", type: .user, callType: .audio)
            default: break
            }
        case 0 where selectedCall == 1:
            switch selectedUser {
            case 0: self.initiateCall(to: "superhero1", type: .user, callType: .video)
            case 1: self.initiateCall(to: "superhero2", type: .user, callType: .video)
            case 2: self.initiateCall(to: "superhero3", type: .user, callType: .video)
            case 3: self.initiateCall(to: "superhero4", type: .user, callType: .video)
            case 4: self.initiateCall(to: "superhero4", type: .user, callType: .video)
            default: break
            }
        case 1 where selectedCall == 0:
            self.initiateCall(to: "supergroup", type: .group, callType: .audio)
        case 1 where selectedCall == 1:
             self.initiateCall(to: "supergroup", type: .group, callType: .video)
        default:
            break
        }
    }
    
    
    fileprivate func initiateCall(to: String, type: CometChat.ReceiverType, callType: CometChat.CallType){
        switch type {
        case .user:
            CometChat.getUser(UID: to, onSuccess: { (user) in
                if let user = user {
                    DispatchQueue.main.async {
                        CometChatCallManager().makeCall(call: .video, to: user)
                    }
                }
            }) { (error) in
                DispatchQueue.main.async {
                    if let errorMessage = error?.errorDescription {
                        CometChatSnackBoard.display(message:  errorMessage, mode: .error, duration: .short)
                    }
                }
            }
        case .group:
            CometChat.getGroup(GUID: to, onSuccess: { (group) in
                DispatchQueue.main.async {
                    CometChatCallManager().makeCall(call: callType, to: group)
                }
            }) { (error) in
                DispatchQueue.main.async {
                    if let errorMessage = error?.errorDescription {
                        CometChatSnackBoard.display(message:  errorMessage, mode: .error, duration: .short)
                    }
                }
            }
        @unknown default: break
        }
    }
}

extension MainViewController: LogoutCellDelegate {
   
    func didlogoutButtonPressed(_ sender: UIButton) {
        
        // Declare Alert
        let dialogMessage = UIAlertController(title: "⚠️ Warning!", message: "Are you sure you want to Logout?", preferredStyle: .alert)

        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 CometChat.logout(onSuccess: { (success) in
                     DispatchQueue.main.async {
                         let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                         let viewController = mainStoryboard.instantiateViewController(withIdentifier: "loginWithDemoUsers") as! LoginWithDemoUsers
                         UIApplication.shared.keyWindow?.rootViewController = viewController
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

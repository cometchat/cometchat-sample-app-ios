//
//  BlockedUsersVC.swift
//  CometChatPro-swift-sampleApp
//
//  Created by MacMini-03 on 27/05/19.
//  Copyright © 2019 Admin1. All rights reserved.
//

import UIKit
import CometChatPro

class BlockedUsersVC: UITableViewController {
    
    var addusers = [User]()
    var blockedUsers:[User] = []
    var unbanUsers:[GroupMember] = []
    var selectedUsers:[String] = []
    var selectedUsersToAdd:[GroupMember] = []
    var selectedUsersToUnban:[GroupMember] = []
    let blockedUserRequest = BlockedUserRequest.BlockedUserRequestBuilder(limit: 20).build()
    var userRequest = UsersRequest.UsersRequestBuilder(limit: 100).build()
    var doneBTN =  UIBarButtonItem()
    var groupMember:GroupMember?
    var isBlockedUser:Bool?
    var isUnbanUser:Bool?
    var guid:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Function Calling
        self.handleBlockUsersVCAppearance()
        if isBlockedUser == true{
            self.fetchBlockedUsersList()
            self.tableView.reloadData()
        }else if isUnbanUser == true{

            self.tableView.reloadData()
        }else{
            self.fetchAddUsersList()
            self.tableView.reloadData()
        }
        
    }
    func fetchAddUsersList(){
        // This Method fetch the users from the Server.
        userRequest.fetchNext(onSuccess: { (userList) in
            self.addusers.append(contentsOf: userList)
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
            })
        }) { (exception) in
            
            DispatchQueue.main.async(execute: {
                self.view .makeToast("\(String(describing: exception!.errorDescription))")
            })
            CometChatLog.print(items:exception?.errorDescription as Any)
        }
    }
    
    internal func fetchBlockedUsersList(){
        
        blockedUserRequest.fetchNext(onSuccess : { (users) in
            print("blocked users : \(users!)")
            
            guard let blockedUsers = users else{
                return
            }
            self.blockedUsers.append(contentsOf: blockedUsers)
            DispatchQueue.main.async {self.tableView.reloadData()}
        }, onError : { (error) in
            
            print("error while fetching the blocked user request :  \(String(describing: error?.errorDescription))")
            
        })
    }
    
    

    
    internal func handleBlockUsersVCAppearance(){

        let blockedUserNib  = UINib.init(nibName: "BlockedUserCell", bundle: nil)
        self.tableView.register(blockedUserNib, forCellReuseIdentifier: "blockedUserCell")
        tableView.tableFooterView = UIView()
        tableView.allowsMultipleSelection = true
        
        let backButtonImage = UIImageView(image: UIImage(named: "back_arrow"))
        backButtonImage.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let backBTN = UIBarButtonItem(image: backButtonImage.image,
                                      style: .plain,
                                      target: self,
                                      action: #selector(backButtonPressed))
        
        
        navigationItem.leftBarButtonItem = backBTN
        backBTN.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
       
        if isBlockedUser == true{
             doneBTN = UIBarButtonItem(title: "Unblock", style: .plain, target: self, action: #selector(unblockAction))
        }else{
             doneBTN = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addMemberAction))
        }
      
    }
    
    @objc func backButtonPressed(){
        
        print(#function)
        DispatchQueue.main.async {
         self.navigationController?.popViewController(animated: true)
        }
    }
    
     @objc fileprivate func addMemberAction() {
        
        CometChat.addMembersToGroup(guid: guid, groupMembers: selectedUsersToAdd, onSuccess: { (response) in
            CometChatLog.print(items: "response from addMembersGroup : \(response)")
            
            DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
            }
        }, onError : { (error) in
            
            print("error in adding member in a group failed with error : \(error!.errorDescription)")
            
        })
     }
    @objc fileprivate func unblockAction() {
        
        CometChat.unblockUsers(selectedUsers, onSuccess: { (sucess) in
            DispatchQueue.main.async {
                CometChatLog.print(items: "Users unblocked sucessfully. \(sucess)")
                self.view.makeToast("Users unblocked sucessfully.")
                if let vc = self.navigationController?.viewControllers.filter({$0.isKind(of: OneOnOneListViewController.self)}).first as? OneOnOneListViewController {
                    self.navigationController?.popViewController(animated: true, completion: {
                    vc.refreshUserList()
                })
                }}
            
        }) { (error) in
            CometChatLog.print(items: "unable to unblock. \(String(describing: error))")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if(isBlockedUser == true){
            if blockedUsers.count == 0 {
                self.tableView.setEmptyMessage("No blocked users found.")
            } else {
                self.tableView.restore()
            }
            return blockedUsers.count
        }else if isUnbanUser == true{
            if unbanUsers.count == 0 {
                self.tableView.setEmptyMessage("No banned users found.")
            } else {
                self.tableView.restore()
            }
            return unbanUsers.count
        }else{
            return addusers.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var blockedUserCell = BlockedUserCell()
        blockedUserCell = tableView.dequeueReusableCell(withIdentifier: "blockedUserCell", for: indexPath) as! BlockedUserCell
        let user: User?
        if isBlockedUser == true{
            user = blockedUsers[indexPath.row]
        }else if isUnbanUser == true{
            blockedUserCell.check.isHidden = true
            user = unbanUsers[indexPath.row]
        }else{
            user = addusers[indexPath.row]
        }
       
        blockedUserCell.buddyName.text = user!.name
        blockedUserCell.user = user
        blockedUserCell.selectionStyle = .none
        switch user!.status {
        case .online:
             blockedUserCell.buddyStatus.text = "Online"
        case .offline:
             blockedUserCell.buddyStatus.text = "Offline"
        @unknown default:
             blockedUserCell.buddyStatus.text = "Offline"
        }
        let url = NSURL(string: ((user?.avatar) ?? nil) ?? " ")
        blockedUserCell.buddyAvtar.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_user"))
        return blockedUserCell
    }
    
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:BlockedUserCell = tableView.cellForRow(at: indexPath) as! BlockedUserCell
        
        groupMember = GroupMember(UID: selectedCell.user!.uid!, groupMemberScope: .participant)
        
        if isBlockedUser == true{
            if !selectedUsers.contains(selectedCell.user!.uid!){
                selectedUsers.append(selectedCell.user!.uid!)
            }
            self.navigationItem.rightBarButtonItem = self.doneBTN
        }else if isUnbanUser == true{
            
            let selectedCell:BlockedUserCell = tableView.cellForRow(at: indexPath) as! BlockedUserCell
            
            let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let banAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Unban", comment: ""), style: .default) { action -> Void in
                
                CometChat.unbanGroupMember(UID: selectedCell.user!.uid!, GUID: self.guid, onSuccess: { (sucess) in
                    DispatchQueue.main.async {
                         self.navigationController?.popViewController(animated: true)
                    }
                   
                }, onError: { (error) in
                    print("unbanGroupMember error \(error?.errorDescription)")
                })
            }
            let cancelAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
                
            }
            
            actionSheetController.addAction(banAction)
            actionSheetController.addAction(cancelAction)
            if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ){
                
                if let currentPopoverpresentioncontroller = actionSheetController.popoverPresentationController{
                    currentPopoverpresentioncontroller.sourceView = self.view
                    currentPopoverpresentioncontroller.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                    currentPopoverpresentioncontroller.permittedArrowDirections = []
                }
                self.present(actionSheetController, animated: true, completion: nil)
            }else{
                self.present(actionSheetController, animated: true, completion: nil)
            }
            
        }else{
            if !selectedUsersToAdd.contains(groupMember!){
                selectedUsersToAdd.append(groupMember!)
            }
            print("seleted Users to Add: \(selectedUsersToAdd)")
            selectedCell.isUserInteractionEnabled = false
            self.navigationItem.rightBarButtonItem = self.doneBTN
            self.title = "\(selectedUsersToAdd.count) users Selected"
        }
    }
    

    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedCell:BlockedUserCell = tableView.cellForRow(at: indexPath) as! BlockedUserCell
        
         if isBlockedUser == true{
            if selectedUsers.contains(selectedCell.user!.uid!){
                selectedUsers.remove(at: indexPath.row)
            }
        }else{
            if selectedUsersToAdd.contains(groupMember!){
                selectedUsersToAdd.remove(at: indexPath.row)
            }
            print("seleted Users to Add 11: \(selectedUsersToAdd)")
        }
        }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
}

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
    
    var blockedUsers:[User] = []
    var selectedUsers:[String] = []
    let blockedUserRequest = BlockedUserRequest.BlockedUserRequestBuilder(limit: 20).build()
    var doneBTN =  UIBarButtonItem()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Function Calling
        self.handleBlockUsersVCAppearance()
        self.fetchBlockedUsersList()
        self.tableView.reloadData()
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
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBTN
        backBTN.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        
       doneBTN = UIBarButtonItem(title: "Unblock", style: .plain, target: self, action: #selector(unblockAction))
    }
    
    @objc fileprivate func unblockAction() {
        print("action triggerd")
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
       
        if blockedUsers.count == 0 {
            self.tableView.setEmptyMessage("No blocked users found.")
        } else {
            self.tableView.restore()
        }
        return blockedUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var blockedUserCell = BlockedUserCell()
        let blockedUser = blockedUsers[indexPath.row]
        blockedUserCell = tableView.dequeueReusableCell(withIdentifier: "blockedUserCell", for: indexPath) as! BlockedUserCell
        blockedUserCell.buddyName.text = blockedUser.name
        blockedUserCell.user = blockedUser
        blockedUserCell.selectionStyle = .none
        switch blockedUser.status {
        case .online:
             blockedUserCell.buddyStatus.text = "Online"
        case .offline:
             blockedUserCell.buddyStatus.text = "Offline"
        @unknown default:
             blockedUserCell.buddyStatus.text = "Offline"
        }
        let url = NSURL(string: ((blockedUser.avatar) ?? nil) ?? " ")
        blockedUserCell.buddyAvtar.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_user"))
        return blockedUserCell
    }
    
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:BlockedUserCell = tableView.cellForRow(at: indexPath) as! BlockedUserCell
            if !selectedUsers.contains(selectedCell.user!.uid!){
                selectedUsers.append(selectedCell.user!.uid!)
            }
            self.navigationItem.rightBarButtonItem = self.doneBTN
        
        }
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedCell:BlockedUserCell = tableView.cellForRow(at: indexPath) as! BlockedUserCell
        
            if selectedUsers.contains(selectedCell.user!.uid!){
                selectedUsers.remove(at: indexPath.row)
            }
        
        }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
}

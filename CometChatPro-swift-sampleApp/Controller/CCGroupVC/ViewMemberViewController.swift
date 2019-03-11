//
//  ViewMemberViewController.swift
//  CometChatPro-swift-sampleApp
//
//  Created by Inscripts mac mini  on 03/02/19.
//  Copyright © 2019 Admin1. All rights reserved.
//

import UIKit
import CometChatPro

class ViewMemberViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //Outlets Declarations
    
    @IBOutlet weak var viewMemberTableView: UITableView!
    
    
    //Variable Declarations
    var buddyName:[String]!
    var guid:String!
    var members:[GroupMember]!
    var myUID:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myUID = UserDefaults.standard.string(forKey: "LoggedInUserUID")
        print("members are: \(members)")
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.handleMoreSettingsVCAppearance()
    }
    
    func  handleMoreSettingsVCAppearance(){
        
        // ViewController Appearance
        self.title = "View Member"
        viewMemberTableView.tableFooterView = UIView()
        self.hidesBottomBarWhenPushed = true
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        }
        
        // NavigationBar Buttons Appearance
        
        let backButtonImage = UIImageView(image: UIImage(named: "back_arrow"))
        backButtonImage.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let backBTN = UIBarButtonItem(image: backButtonImage.image,
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBTN
        backBTN.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let groupMember:GroupMember = self.members[indexPath.row]
        
     let cell = viewMemberTableView.dequeueReusableCell(withIdentifier: "viewMemberCell", for: indexPath) as! ViewMemberTableViewCell
        
        if(groupMember.scope == CometChat.GroupMemberScopeType.admin){
             cell.buddyScope.text = "Admin"
        }else if(groupMember.scope == CometChat.GroupMemberScopeType.moderator){
            cell.buddyScope.text = "Moderator"
        }else if(groupMember.scope == CometChat.GroupMemberScopeType.participant){
            cell.buddyScope.text = "Participant"
        }
        if(groupMember.uid == myUID){
             cell.buddyName.text = "You"
        }else{
               cell.buddyName.text = groupMember.user?.name
        }
        let url = NSURL(string: groupMember.user?.avatar ?? "")
        cell.buddyAvtar.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_user"))
        cell.buddyAvtar.downloaded(from: (groupMember.user?.avatar ?? ""))
        cell.memberScope = groupMember.scope
        cell.uid = groupMember.user?.uid
        print("groupMember.scope: \(groupMember.scope)")
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var groupMember:GroupMember = self.members[indexPath.row]
        
        let selectedCell:ViewMemberTableViewCell = tableView.cellForRow(at: indexPath) as! ViewMemberTableViewCell
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let banAction: UIAlertAction = UIAlertAction(title: "Ban User", style: .default) { action -> Void in
            
            CometChat.banGroupMember(UID: selectedCell.uid, GUID: self.guid, onSuccess: { (response) in
                 print("banGroupMember onSuccess\(response)")
            }, onError: { (error) in
                print("banGroupMember onError\(String(describing: error))")
            })
        }
//        ban.setValue(UIImage(named: "camera.png"), forKey: "image")
        
        let kickAction: UIAlertAction = UIAlertAction(title: "Kick User", style: .default) { action -> Void in
            
            CometChat.kickGroupMember(UID: selectedCell.uid, GUID: self.guid, onSuccess: { (response) in
                
                print("kickGroupMember onSuccess\(response)")
                
            }) { (error) in
                
                // Error
                print("Group member kicking failed with exception:  " + error!.errorDescription);
            }
        }
        //kickAction.setValue(UIImage(named: "gallery.png"), forKey: "image")
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        actionSheetController.addAction(banAction)
        actionSheetController.addAction(kickAction)
        actionSheetController.addAction(cancelAction)
        
        if(groupMember.scope == CometChat.GroupMemberScopeType.admin){
            if(selectedCell.memberScope == CometChat.GroupMemberScopeType.admin){
                print("Cannot kick or ban admin")
            }else{
                present(actionSheetController, animated: true, completion: nil)
            }
        }else{
            print("You're not admin")
        }    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70
    }
}

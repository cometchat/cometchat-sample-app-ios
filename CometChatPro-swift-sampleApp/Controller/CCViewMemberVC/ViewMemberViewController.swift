//
//  ViewMemberViewController.swift
//  CometChatPro-swift-sampleApp
//
//  Created by Inscripts mac mini  on 03/02/19.
//  Copyright © 2019 Pushpsen Airekar. All rights reserved.
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
    var isViewMember:Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myUID = UserDefaults.standard.string(forKey: "LoggedInUserUID")
        CometChatLog.print(items:"members are: \(String(describing: members))")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.handleViewMembersVCAppearance()
    }
    
    func  handleViewMembersVCAppearance(){
        
        // ViewController Appearance
        self.title =  NSLocalizedString("View Member", comment: "")
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
            cell.buddyScope.text = NSLocalizedString("Admin", comment: "")
        }else if(groupMember.scope == CometChat.GroupMemberScopeType.moderator){
            cell.buddyScope.text = NSLocalizedString("Moderator", comment: "")
        }else if(groupMember.scope == CometChat.GroupMemberScopeType.participant){
            cell.buddyScope.text = NSLocalizedString("Participant", comment: "")
        }
        if(groupMember.uid == myUID){
            cell.buddyName.text = NSLocalizedString("You", comment: "")
        }else{
            cell.buddyName.text = groupMember.name
        }
        let url = NSURL(string: groupMember.avatar ?? "")
        cell.buddyAvtar.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_user"))
        cell.buddyAvtar.downloaded(from: (groupMember.avatar ?? ""))
        cell.memberScope = groupMember.scope
        cell.uid = groupMember.uid
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewMemberTableView.deselectRow(at: indexPath, animated: true)
        
        let groupMember:GroupMember = self.members[indexPath.row]
        
        let selectedCell:ViewMemberTableViewCell = tableView.cellForRow(at: indexPath) as! ViewMemberTableViewCell
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let banAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Ban User", comment: ""), style: .default) { action -> Void in
            
            CometChat.banGroupMember(UID: selectedCell.uid, GUID: self.guid, onSuccess: { (response) in
                
                DispatchQueue.main.async(execute: { self.view.makeToast("\(response)")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {self.navigationController?.popViewController(animated: true)}
                })
            }, onError: { (error) in
                DispatchQueue.main.async(execute: {
                    DispatchQueue.main.async(execute: { self.view.makeToast("\(String(describing: error!.errorDescription))") })
                })
            })
        }
        //        ban.setValue(UIImage(named: "camera.png"), forKey: "image")
        
        let kickAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Kick User", comment: ""), style: .default) { action -> Void in
            
            CometChat.kickGroupMember(UID: selectedCell.uid, GUID: self.guid, onSuccess: { (response) in
                DispatchQueue.main.async(execute: { self.view.makeToast("\(response)")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {self.navigationController?.popViewController(animated: true)}
                })
            }) { (error) in
                DispatchQueue.main.async(execute: { self.view.makeToast("\(String(describing: error!.errorDescription))") })
            }
        }
        //kickAction.setValue(UIImage(named: "gallery.png"), forKey: "image")
        let updateScope: UIAlertAction = UIAlertAction(title: NSLocalizedString("Update Scope", comment: ""), style: .default) { action -> Void in
            
            let updateScopeAction: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let admin: UIAlertAction = UIAlertAction(title: NSLocalizedString("Admin", comment: ""), style: .default) { action -> Void in
                
                CometChat.updateGroupMemberScope(UID: selectedCell.uid, GUID: self.guid, scope: .admin, onSuccess: { (sucess) in
                    DispatchQueue.main.async(execute: { self.view.makeToast("\(sucess)")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {self.navigationController?.popViewController(animated: true)}
                    })
                }, onError: { (error) in
                    DispatchQueue.main.async(execute: { self.view.makeToast("\(String(describing: error!.errorDescription))") })
                })
                
            }
            let modorator: UIAlertAction = UIAlertAction(title: NSLocalizedString("Moderator", comment: ""), style: .default) { action -> Void in
                CometChat.updateGroupMemberScope(UID: selectedCell.uid, GUID: self.guid, scope: .moderator, onSuccess: { (sucess) in
                    DispatchQueue.main.async(execute: { self.view.makeToast("\(sucess)")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {self.navigationController?.popViewController(animated: true)}
                    })
                }, onError: { (error) in
                    DispatchQueue.main.async(execute: { self.view.makeToast("\(String(describing: error!.errorDescription))") })
                })
            }
            let participant: UIAlertAction = UIAlertAction(title: NSLocalizedString("Participant", comment: ""), style: .default) { action -> Void in
                CometChat.updateGroupMemberScope(UID: selectedCell.uid, GUID: self.guid, scope: .participant, onSuccess: { (sucess) in
                    DispatchQueue.main.async(execute: { self.view.makeToast("\(sucess)")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {self.navigationController?.popViewController(animated: true)}
                    })
                }, onError: { (error) in
                    DispatchQueue.main.async(execute: { self.view.makeToast("\(String(describing: error!.errorDescription))") })
                })
            }
            let cancelAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
            }
            updateScopeAction.addAction(admin)
            updateScopeAction.addAction(modorator)
            updateScopeAction.addAction(participant)
            updateScopeAction.addAction(cancelAction)
            if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ){
                
                if let currentPopoverpresentioncontroller = updateScopeAction.popoverPresentationController{
                    currentPopoverpresentioncontroller.sourceView = self.view
                    currentPopoverpresentioncontroller.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                    currentPopoverpresentioncontroller.permittedArrowDirections = []
                }
                self.present(updateScopeAction, animated: true, completion: nil)
            }else{
                self.present(updateScopeAction, animated: true, completion: nil)
            }
        }
        
        
        let cancelAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
        }
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        actionSheetController.addAction(banAction)
        actionSheetController.addAction(kickAction)
        actionSheetController.addAction(updateScope)
        actionSheetController.addAction(cancelAction)
        
        if(isViewMember == true){
            if(groupMember.scope == CometChat.GroupMemberScopeType.admin || groupMember.scope == CometChat.GroupMemberScopeType.moderator){
                DispatchQueue.main.async(execute: {
                    self.view.makeToast(NSLocalizedString("Cannot kick or ban Modarator", comment: ""))
                })
            }else if groupMember.uid == myUID{
                self.view.makeToast(NSLocalizedString("Cannot perform action on Yourself.", comment: ""))
            }else{
                
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
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70
    }
}



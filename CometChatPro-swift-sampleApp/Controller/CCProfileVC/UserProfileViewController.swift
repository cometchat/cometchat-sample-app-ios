//
//  UserProfileViewController.swift
//  CometChatPro-swift-sampleApp
//
//  Created by pushpsen airekar on 08/12/18.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.
//

import UIKit
import CometChatPro

class UserProfileCell {
    static let AUDIO_CALL_CELL = 0
    static let VIDEO_CALL_CELL = 1
    static let MY_STATUS_MESSAGE_CELL = 2
    static let MY_SET_STATUS_CELL = 3
    static let VIEW_MEMBER_CELL = 4
    static let ADD_MEMBER_CELL = 5
    static let UNBAN_MEMBERS_CELL = 6
    static let RENAME_GROUPS_CELL = 7
    static let LEAVE_GROUP_CELL = 8
    static let DELETE_GROUP_CELL = 9
}

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //Outlets Declarations
    @IBOutlet weak var userProfileAvtar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userStatus: UILabel!
    @IBOutlet weak var userProfileTableView: UITableView!
    @IBOutlet weak var profileAvtarBackground: UIView!
    
    //Variable Declarations
    var getUserProfileAvtar:UIImage!
    var getUserName:String!
    var getUserStatus:String!
    var profileItems:[Int]!
    var isDisplayType:String!
    var myInfo:Data!
    var guid:String!
    var groupScope:Int!
    var groupMember:[GroupMember]!
    var userInfo:[String:Any]!
    var url: NSURL!
    var data: NSData!
    var user:User!
    typealias CompletionHandler = (_ success:Bool) -> Void
    var isViewMyProfile:Bool!
    var groupMemberRequest:GroupMembersRequest!
    var bannedGroupMembersRequest:BannedGroupMembersRequest!
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isDisplayType == "MoreSettingViewProfile"{
            
            user = CometChat.getLoggedInUser()
            getUserName = user.name
           
            switch user.status {
                
            case .online:
                getUserStatus = NSLocalizedString("Online", comment: "")
            case .offline:
                getUserStatus = NSLocalizedString("Online", comment: "")
            }
            
            url = NSURL(string: user.avatar ?? "")
            userProfileAvtar.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_user"))
        }
        
        // Assigning Delegates
        userProfileTableView.delegate = self
        userProfileTableView.dataSource = self
        
        profileItems = []
        self.handleProfileItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Function Calling
        self.handleCCProfileAvtarVCAppearance()
    }
    
    //This method handles the UI customization for WebVC
    func handleProfileItems()
    {
        if isDisplayType == "OneOneOneViewProfile"{
            profileItems.append(UserProfileCell.AUDIO_CALL_CELL)
            profileItems.append(UserProfileCell.VIDEO_CALL_CELL)
        }
        else if isDisplayType == "MoreSettingViewProfile"{
            profileItems.append(UserProfileCell.MY_STATUS_MESSAGE_CELL)
            profileItems.append(UserProfileCell.MY_SET_STATUS_CELL)
        }
        else if isDisplayType == "GroupView"{
            profileItems.append(UserProfileCell.VIEW_MEMBER_CELL)
            if(groupScope! == 0 || groupScope! == 1){
                profileItems.append(UserProfileCell.UNBAN_MEMBERS_CELL)
            }
            profileItems.append(UserProfileCell.LEAVE_GROUP_CELL)
            if(groupScope! == 0 || groupScope! == 1){
                profileItems.append(UserProfileCell.DELETE_GROUP_CELL)
            }
        }
    }
    
    
    func  handleCCProfileAvtarVCAppearance(){
        
        // ViewController Appearance
        
        self.hidesBottomBarWhenPushed = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes  = [NSAttributedStringKey.foregroundColor: UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_TITLE_COLOR)]
        guard (UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView) != nil else {
            return
        }
        
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        } else {
            
        }
        
        // NavigationBar Buttons Appearance
        
        let backButtonImage = UIImageView(image: UIImage(named: "back_arrow"))
        backButtonImage.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let backBTN = UIBarButtonItem(image: backButtonImage.image,
                                      style: .plain,
                                      target: self,
                                      action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backBTN
        backBTN.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
        // User Profile BAckground
        
        switch AppAppearance {
        case .AzureRadiance:
            profileAvtarBackground.backgroundColor = UIColor.init(hexFromString: "F3F3F3")
        case .MountainMeadow:
            profileAvtarBackground.backgroundColor = UIColor.init(hexFromString: "F3F3F3")
        case .PersianBlue:
            profileAvtarBackground.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_COLOR)
        case .Custom:
            profileAvtarBackground.backgroundColor = UIColor.init(hexFromString: "F3F3F3")
        }
        
        
        
        
        // UserProfile Name
        userName.text = getUserName
        
        //UserProfile Status
        userStatus.text = getUserStatus
        
        // Profile Avtar
        userProfileAvtar.image = getUserProfileAvtar
        userProfileAvtar.cornerRadius = 100
        userProfileAvtar.clipsToBounds = true
        
        //TableView APpearance
        // self.userProfileTableView.separatorColor = UIColor.clear
        userProfileTableView.tableFooterView = UIView()
        userProfileTableView.backgroundColor = UIColor.clear
        userProfileTableView.tintColor = UIColor.clear
        userProfileTableView.showsHorizontalScrollIndicator = false
        userProfileTableView.showsVerticalScrollIndicator = false
        
        let tapOnProfileAvtar = UITapGestureRecognizer(target: self, action: #selector(UserAvtarClicked(tapGestureRecognizer:)))
        userProfileAvtar.isUserInteractionEnabled = true
        userProfileAvtar.addGestureRecognizer(tapOnProfileAvtar)
        
    }
    
    @objc func UserAvtarClicked(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileAvtarViewController = storyboard.instantiateViewController(withIdentifier: "ccprofileAvtarViewController") as! CCprofileAvtarViewController
        navigationController?.pushViewController(profileAvtarViewController, animated: true)
        profileAvtarViewController.title = getUserName
        profileAvtarViewController.profileAvtar = userProfileAvtar.image
        profileAvtarViewController.hidesBottomBarWhenPushed = true
    }
    
    @objc func backButtonPressed(){
        navigationController?.popViewController(animated: true)
    }
    
    
    // TableView Methods:
    
    //numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileItems.count
    }
    
    //cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = userProfileTableView.dequeueReusableCell(withIdentifier: "userProfileViewCell") as! UserProfileViewCell
        print("Count in index\(profileItems[indexPath.row])")
        switch profileItems[indexPath.row]{
        case UserProfileCell.AUDIO_CALL_CELL:
            cell.CellRightImage.isHidden = false
            cell.CellTitle.text = "          " + NSLocalizedString("Audio Call", comment: "")
            cell.CellLeftImage.image = UIImage(named: "audio_call")
            cell.leftIconBackgroundView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
            cell.CellLeftImage.tintColor = UIColor.white
            
        case UserProfileCell.VIDEO_CALL_CELL:
            cell.CellRightImage.isHidden = false
            cell.CellTitle.text = "          " + NSLocalizedString("Video Call", comment: "")
            cell.CellLeftImage.image = UIImage(named: "video_call")
            cell.leftIconBackgroundView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
            cell.CellLeftImage.tintColor = UIColor.white
            
        case UserProfileCell.MY_STATUS_MESSAGE_CELL:
            cell.CellRightImage.isHidden=true
            cell.CellTitle.text = NSLocalizedString("Status Message", comment: "")
            cell.CellLeftImage.image = UIImage(named: "status_message")
            cell.leftIconBackgroundView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
            cell.CellLeftImage.tintColor = UIColor.white
            
        case UserProfileCell.MY_SET_STATUS_CELL:
            cell.CellRightImage.isHidden=true
            cell.CellTitle.text = NSLocalizedString("Set Status", comment: "")
            cell.CellLeftImage.image = UIImage(named: "set_status")
            cell.leftIconBackgroundView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
            cell.CellLeftImage.tintColor = UIColor.white
            
        case UserProfileCell.VIEW_MEMBER_CELL:
            cell.CellRightImage.isHidden = true
            cell.CellTitle.text = NSLocalizedString("View Member", comment: "")
            cell.CellLeftImage.image = UIImage(named: "view_member")
            cell.leftIconBackgroundView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
            
            
        case UserProfileCell.ADD_MEMBER_CELL:
            cell.CellRightImage.isHidden=true
            cell.CellTitle.text = NSLocalizedString("Add Member", comment: "")
            let image = UIImage(named: "add_member")!.withRenderingMode(.alwaysTemplate)
            cell.CellLeftImage.image = image
            cell.leftIconBackgroundView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
            cell.CellLeftImage.tintColor = UIColor.white
            
        case UserProfileCell.UNBAN_MEMBERS_CELL:
            cell.CellRightImage.isHidden=true
            cell.CellTitle.text = NSLocalizedString("Unban Member", comment: "")
            let image = UIImage(named: "unban")!.withRenderingMode(.alwaysTemplate)
            cell.CellLeftImage.image = image
            cell.leftIconBackgroundView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
            cell.CellLeftImage.tintColor = UIColor.white
            
        case UserProfileCell.RENAME_GROUPS_CELL:
            cell.CellRightImage.isHidden=true
            cell.CellTitle.text = NSLocalizedString("Rename Group", comment: "")
            let image = UIImage(named: "rename_group")!.withRenderingMode(.alwaysTemplate)
            cell.CellLeftImage.image = image
            cell.leftIconBackgroundView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
            cell.CellLeftImage.tintColor = UIColor.white
            
            
        case UserProfileCell.LEAVE_GROUP_CELL:
            cell.CellRightImage.isHidden=true
            cell.CellTitle.text = NSLocalizedString("Leave Group", comment: "")
            let image = UIImage(named: "leave")!.withRenderingMode(.alwaysTemplate)
            cell.CellLeftImage.image = image
            cell.leftIconBackgroundView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
            cell.CellLeftImage.tintColor = UIColor.white
            
        case UserProfileCell.DELETE_GROUP_CELL:
            cell.CellRightImage.isHidden=true
            cell.CellTitle.text = NSLocalizedString("Delete Group", comment: "")
            let image = UIImage(named: "delete_group")!.withRenderingMode(.alwaysTemplate)
            cell.CellLeftImage.image = image
            cell.leftIconBackgroundView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
            cell.CellLeftImage.tintColor = UIColor.white
            
        default:
            cell.CellTitle.text = ""
            
        }
        
        let totalRow = tableView.numberOfRows(inSection: indexPath.section)
        if(indexPath.row == totalRow - 1){
            cell.roundCorners([.layerMaxXMaxYCorner,.layerMinXMaxYCorner], radius: 15, borderColor: UIColor.clear, borderWidth: 0, withBackgroundColor: "FFFFFF")
            cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        userProfileTableView.deselectRow(at: indexPath, animated: true)
        switch profileItems[indexPath.row]
        {
        case UserProfileCell.VIEW_MEMBER_CELL:
            self.onViewMember()
        case UserProfileCell.AUDIO_CALL_CELL:
            self.audioCallAction()
        case UserProfileCell.VIDEO_CALL_CELL:
            self.videoCallAction()
        case UserProfileCell.ADD_MEMBER_CELL:break
        case UserProfileCell.UNBAN_MEMBERS_CELL:
            self.UnbanUsers()
        case UserProfileCell.RENAME_GROUPS_CELL:break
        case UserProfileCell.LEAVE_GROUP_CELL:
            self.leaveGroup()
        case UserProfileCell.MY_SET_STATUS_CELL:
            self.setStatus()
        case UserProfileCell.MY_STATUS_MESSAGE_CELL:
            self.statusMessage()
            
            
        default: break
            
        }
    }
    
    func setStatus(){
        
         DispatchQueue.main.async { self.view.makeToast(NSLocalizedString("This feature has not been added yet.", comment: ""))}
    }
    
    func statusMessage(){
        
          DispatchQueue.main.async { self.view.makeToast(NSLocalizedString("This feature has not been added yet.", comment: ""))}
    }
    
    func audioCallAction(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CallingViewController = storyboard.instantiateViewController(withIdentifier: "callingViewController") as! CallingViewController
        CallingViewController.isAudioCall = "1"
        CallingViewController.isIncoming = false
        CallingViewController.userAvtarImage = userProfileAvtar.image
        CallingViewController.userNameString = userName.text
        CallingViewController.callingString = NSLocalizedString("Calling ...", comment: "")
        CallingViewController.callerUID = guid
        CallingViewController.isGroupCall = false
        self.present(CallingViewController, animated: true, completion: nil)
        
    }
    
    func videoCallAction(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CallingViewController = storyboard.instantiateViewController(withIdentifier: "callingViewController") as! CallingViewController
        CallingViewController.isAudioCall = "0"
        CallingViewController.isIncoming = false
        CallingViewController.userAvtarImage = userProfileAvtar.image
        CallingViewController.userNameString = userName.text
        CallingViewController.callingString = NSLocalizedString("Calling ...", comment: "")
        CallingViewController.callerUID = guid
        CallingViewController.isGroupCall = false
        self.present(CallingViewController, animated: true, completion: nil)
    }
    
    
    func leaveGroup(){
        print("Im in leave group")
        CometChat.leaveGroup(GUID: guid, onSuccess: { (sucess) in
            print("leaveGroup \(sucess)")
            
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self
                    else { return }
                strongSelf.view.makeToast(NSLocalizedString("Group left Sucessfully.", comment: ""))
                UserDefaults.standard.set("1", forKey: "leaveGroupAction")
                if strongSelf.presentingViewController != nil {
                    strongSelf.dismiss(animated: false, completion: {
                        strongSelf.navigationController!.popToRootViewController(animated: true)
                    })
                }
                else {
                    strongSelf.navigationController!.popToRootViewController(animated: true)
                }
                
            }
        }) { (CometChatException) in
            DispatchQueue.main.async { self.view.makeToast(NSLocalizedString("Fail to leave Group.", comment: ""))}
        }
    }
    
    func deleteGroup(){
        
        CometChat.deleteGroup(GUID: guid, onSuccess: { (sucess) in
            
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self
                    else { return }
                strongSelf.view.makeToast(NSLocalizedString("Group deleted Sucessfully.", comment: ""))
                print("\(sucess)")
                UserDefaults.standard.set("1", forKey: "leaveGroupAction")
                if strongSelf.presentingViewController != nil {
                    strongSelf.dismiss(animated: false, completion: {
                        strongSelf.navigationController!.popToRootViewController(animated: true)
                    })
                }
                else {
                    strongSelf.navigationController!.popToRootViewController(animated: true)
                }
            }
        }) { (CometChatException) in
            DispatchQueue.main.async {
                self.view.makeToast(NSLocalizedString("Fail to delete Group.", comment: ""))
            }
        }
        
    }
    
    func onViewMember(){
        
        fetchGroupMembers(guid: guid) { (sucess) in
            if(sucess == true){
                let storyboard = UIStoryboard(name:"Main", bundle:nil)
                let viewMemberViewController = storyboard.instantiateViewController(withIdentifier: "viewMemberViewController") as! ViewMemberViewController
                viewMemberViewController.guid = self.guid
                viewMemberViewController.members = self.groupMember
                viewMemberViewController.isViewMember = true
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(viewMemberViewController, animated: true)
                }
            }
            
        }
        
    }
    
    func UnbanUsers(){
        print("UnbanUsers")
        getUnbanGroupMembers(guid: guid) { (sucess) in
            if(sucess == true){
                let storyboard = UIStoryboard(name:"Main", bundle:nil)
                let unbanUserListController = storyboard.instantiateViewController(withIdentifier: "viewMemberViewController") as! ViewMemberViewController
                unbanUserListController.members = self.groupMember
                unbanUserListController.title = NSLocalizedString("Unban Members", comment: "")
                unbanUserListController.isViewMember = false
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(unbanUserListController, animated: true)
                }
            }
        }
    }
    
    
    func fetchGroupMembers(guid:String,  success completionHandler: @escaping CompletionHandler){
        
        groupMember = [GroupMember]()
        groupMemberRequest = GroupMembersRequest.GroupMembersRequestBuilder(guid: guid).set(limit: 20).build()
        groupMemberRequest.fetchNext(onSuccess: { (groupMember) in
            
            for member in groupMember {
                self.groupMember.append(member)
            }
            let flag = true
            completionHandler(flag)
            
        }) { (error) in
            
            print("Group Member list fetching failed with exception:" + error!.errorDescription);
        }
    }
    
    
    
    func getUnbanGroupMembers(guid:String,  success completionHandler: @escaping CompletionHandler){
        
        groupMember = [GroupMember]()
        let bannedGroupMembersRequest = BannedGroupMembersRequest.BannedGroupMembersRequestBuilder(guid: guid).set(limit: 20).build()
        
        bannedGroupMembersRequest.fetchNext(onSuccess: { (groupMembers) in
            
            // received banned group members
            
            for bannedMember in groupMembers {
                self.groupMember.append(bannedMember)
            }
            let flag = true
            completionHandler(flag)
            
        }) { (error) in
            // Error
            print("Banned Group Member list fetching failed with exception: " + error!.errorDescription);
        }
    }
}



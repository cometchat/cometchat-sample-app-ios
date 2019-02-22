//
//  UserProfileViewController.swift
//  CometChatPulse-swift-sampleApp
//
//  Created by pushpsen airekar on 08/12/18.
//  Copyright © 2018 Admin1. All rights reserved.
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
    var groupMember:[GroupMember]!
    var userInfo:[String:Any]!
    var url: NSURL!
    var data: NSData!
    typealias CompletionHandler = (_ success:Bool) -> Void
    var isViewMyProfile:Bool!
   
    
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isDisplayType == "MoreSettingViewProfile"{
        userInfo = UserDefaults.standard.object(forKey: "LoggedInUserInfo") as? [String : Any]
            getUserName = userInfo["username"] as? String
            getUserStatus = userInfo["userStatus"] as? String
            url = NSURL(string: userInfo?["userAvtar"] as! String)
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: self.url! as URL) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.userProfileAvtar.image = UIImage(data: data!)
                }
            }

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
    print("IS display  \(isDisplayType)")
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
            profileItems.append(UserProfileCell.ADD_MEMBER_CELL)
            profileItems.append(UserProfileCell.UNBAN_MEMBERS_CELL)
            profileItems.append(UserProfileCell.RENAME_GROUPS_CELL)
            profileItems.append(UserProfileCell.LEAVE_GROUP_CELL)
            profileItems.append(UserProfileCell.DELETE_GROUP_CELL)
            
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
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBTN
        backBTN.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
        // User Profile BAckground
        profileAvtarBackground.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_COLOR)
        
        // UserProfile Name
        userName.text = getUserName
        
        //UserProfile Status
        userStatus.text = getUserStatus
        
        // Profile Avtar
        userProfileAvtar.image = getUserProfileAvtar
        userProfileAvtar.cornerRadius = 100
        userProfileAvtar.clipsToBounds = true
        
        //TableView APpearance
        self.userProfileTableView.separatorColor = UIColor.clear
        userProfileTableView.backgroundColor = UIColor.clear
        userProfileTableView.tintColor = UIColor.clear
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
            cell.CellLeftImage.isHidden = true
            cell.CellTitle.text = "Audio Call"
            let image = UIImage(named: "audio_call")!.withRenderingMode(.alwaysTemplate)
            cell.CellRightImage.image = image
            cell.CellRightImage.tintColor = UIColor.init(hexFromString: UIAppearanceColor.BACKGROUND_COLOR)
            
        case UserProfileCell.VIDEO_CALL_CELL:
            cell.CellLeftImage.isHidden = true
            cell.CellTitle.text = "Video Call"
            let image = UIImage(named: "video_call")!.withRenderingMode(.alwaysTemplate)
            cell.CellRightImage.image = image
            cell.CellRightImage.tintColor = UIColor.init(hexFromString: UIAppearanceColor.BACKGROUND_COLOR)
            
        case UserProfileCell.MY_STATUS_MESSAGE_CELL:
            cell.CellRightImage.isHidden=true
            cell.CellTitle.text = "Status Message"
            let image = UIImage(named: "status_message")!.withRenderingMode(.alwaysTemplate)
            cell.CellLeftImage.image = image
            cell.CellLeftImage.tintColor = UIColor.init(hexFromString: UIAppearanceColor.BACKGROUND_COLOR)
            
        case UserProfileCell.MY_SET_STATUS_CELL:
            cell.CellRightImage.isHidden=true
            cell.CellTitle.text = "Set Status"
            let image = UIImage(named: "set_status")!.withRenderingMode(.alwaysTemplate)
            cell.CellLeftImage.image = image
            cell.CellLeftImage.tintColor = UIColor.init(hexFromString: UIAppearanceColor.BACKGROUND_COLOR)
            
        case UserProfileCell.VIEW_MEMBER_CELL:
            cell.CellRightImage.isHidden=true
            cell.CellTitle.text = "View Member"
            let image = UIImage(named: "view_member")!.withRenderingMode(.alwaysTemplate)
            cell.CellLeftImage.image = image
            cell.CellLeftImage.tintColor = UIColor.init(hexFromString: UIAppearanceColor.BACKGROUND_COLOR)
            
            
        case UserProfileCell.ADD_MEMBER_CELL:
            cell.CellRightImage.isHidden=true
            cell.CellTitle.text = "Add Member"
            let image = UIImage(named: "add_member")!.withRenderingMode(.alwaysTemplate)
            cell.CellLeftImage.image = image
            cell.CellLeftImage.tintColor = UIColor.init(hexFromString: UIAppearanceColor.BACKGROUND_COLOR)
        
        case UserProfileCell.UNBAN_MEMBERS_CELL:
            cell.CellRightImage.isHidden=true
            cell.CellTitle.text = "Unban Member"
            let image = UIImage(named: "add_member")!.withRenderingMode(.alwaysTemplate)
            cell.CellLeftImage.image = image
            cell.CellLeftImage.tintColor = UIColor.init(hexFromString: UIAppearanceColor.BACKGROUND_COLOR)
       
        case UserProfileCell.RENAME_GROUPS_CELL:
            cell.CellRightImage.isHidden=true
            cell.CellTitle.text = "Rename Group"
            let image = UIImage(named: "rename_group")!.withRenderingMode(.alwaysTemplate)
            cell.CellLeftImage.image = image
            cell.CellLeftImage.tintColor = UIColor.init(hexFromString: UIAppearanceColor.BACKGROUND_COLOR)
            
            
        case UserProfileCell.LEAVE_GROUP_CELL:
            cell.CellRightImage.isHidden=true
            cell.CellTitle.text = "Leave Group"
            let image = UIImage(named: "leave_group")!.withRenderingMode(.alwaysTemplate)
            cell.CellLeftImage.image = image
            cell.CellLeftImage.tintColor = UIColor.init(hexFromString: UIAppearanceColor.BACKGROUND_COLOR)
       
        case UserProfileCell.DELETE_GROUP_CELL:
            cell.CellRightImage.isHidden=true
            cell.CellTitle.text = "Delete Group"
            let image = UIImage(named: "delete_group")!.withRenderingMode(.alwaysTemplate)
            cell.CellLeftImage.image = image
            cell.CellLeftImage.tintColor = UIColor.init(hexFromString: UIAppearanceColor.BACKGROUND_COLOR)
            
        default:
            cell.CellTitle.text = ""
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch profileItems[indexPath.row]
        {
        case UserProfileCell.VIEW_MEMBER_CELL:
            self.onViewMember()
        default:
            onViewMember()
        }
    }
    func onViewMember()
    {
        
        print ("Here 1122211")
        fetchGroupMembers { (sucess) in
            
            if(sucess == true){
                let storyboard = UIStoryboard(name:"Main", bundle:nil)
                let viewMemberViewController = storyboard.instantiateViewController(withIdentifier: "viewMemberViewController") as! ViewMemberViewController
                viewMemberViewController.guid = self.guid
                viewMemberViewController.members = self.groupMember
                DispatchQueue.main.async {
                self.navigationController?.pushViewController(viewMemberViewController, animated: true)
                }
            }
        }
    }
    
   
    
    func fetchGroupMembers(success completionHandler: @escaping CompletionHandler){
        
        groupMember = [GroupMember]()
    
        fetchGroupData().fetchGroupMembers(guid: guid) { (groupMembers, error) in
            
            guard groupMembers != nil else
            {
                print(error!.errorDescription)
                return
            }
            for members in groupMembers! {
                print("Im in groupMembers: \(String(describing: members))")
                self.groupMember.append(members)
            }
            
            let flag = true
            completionHandler(flag)
        }
    }
}

class fetchGroupData {
    
    private var groupMemberRequest:GroupMembersRequest!
    public typealias groupMemberResponse = (_ group:[GroupMember]? , _ error:CometChatException?) ->Void
    
    func fetchGroupMembers(guid:String, completionHandler:@escaping groupMemberResponse){
        
        groupMemberRequest = GroupMembersRequest.GroupMembersRequestBuilder(guid: guid).setLimit(limit: 20).build()
        
        groupMemberRequest.fetchNext(onSuccess: { (groupMembers) in
            
            let groupMembersArray = groupMembers
            completionHandler(groupMembersArray,nil)
        }) { (error) in
            completionHandler(nil,error)
        }
    }
}


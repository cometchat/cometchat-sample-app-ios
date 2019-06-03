//
//  OneOnOneListViewController.swift
//  CometChatUI
//
//  Created by pushpsen airekar on 18/11/18.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.
//

import UIKit
import CometChatPro

class OneOnOneListViewController: UIViewController,UITableViewDelegate , UITableViewDataSource , CometChatUserDelegate, UISearchBarDelegate {
   
    
    //Outlets Declarations
    @IBOutlet weak var oneOneOneTableView: UITableView!
    @IBOutlet weak var notifyButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var leftPadding: NSLayoutConstraint!
    @IBOutlet weak var rightPadding: NSLayoutConstraint!
    
    //Variable Declarations
    private var _blurView: UIVisualEffectView?
    var usersArray = [User]()
    var userRequest = UsersRequest.UsersRequestBuilder(limit: 20).build()
    var buddyData:User!
    let data:NSData! = nil
    var url:NSURL!
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Function Calling
        self.fetchUsersList()
        oneOneOneTableView.reloadData()
        
        //Assigning Delegates
        CometChat.userdelegate = self
        oneOneOneTableView.delegate = self
        oneOneOneTableView.dataSource = self

    }
    
    func onUserOnline(user: User) {
        
        if let row = self.usersArray.firstIndex(where: {$0.uid == user.uid}) {
            usersArray[row] = user
            let indexPath = IndexPath(row: row, section: 0)
            oneOneOneTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func onUserOffline(user: User) {
        if let row = self.usersArray.firstIndex(where: {$0.uid == user.uid}) {
            usersArray[row] = user
            let indexPath = IndexPath(row: row, section: 0)
            oneOneOneTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        
        //Function Calling
        self.handleContactListVCAppearance()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func fetchUsersList(){
        // This Method fetch the users from the Server.
        userRequest.fetchNext(onSuccess: { (userList) in
           self.usersArray.append(contentsOf: userList)
           DispatchQueue.main.async(execute: {
            self.oneOneOneTableView.reloadData()
           }) 
        }) { (exception) in
            
            DispatchQueue.main.async(execute: {
                self.view .makeToast("\(String(describing: exception!.errorDescription))")
            })
            CometChatLog.print(items:exception?.errorDescription as Any)
        }
    }
    
    func refreshUserList(){
    
        self.usersArray.removeAll()
        userRequest = UsersRequest.UsersRequestBuilder(limit: 20).build()
        userRequest.fetchNext(onSuccess: { (userList) in
            
            self.usersArray.append(contentsOf: userList)
            DispatchQueue.main.async(execute: {
                self.oneOneOneTableView.reloadData()
            })
            
        }) { (exception) in
            
            DispatchQueue.main.async(execute: {
                self.view .makeToast("\(String(describing: exception!.errorDescription))")
            })
            CometChatLog.print(items:exception?.errorDescription as Any)
        }
    }
    
    //This method handles the UI customization for ContactListVC
    func  handleContactListVCAppearance(){
        
        // ViewController Appearance
        view.backgroundColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_COLOR)
        
        //TableView Appearance
        self.oneOneOneTableView.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        oneOneOneTableView.tableFooterView = UIView(frame: .zero)
        self.leftPadding.constant = CGFloat(UIAppearanceSize.Padding)
        self.rightPadding.constant = CGFloat(UIAppearanceSize.Padding)
        
        switch AppAppearance{
        case .AzureRadiance:self.oneOneOneTableView.separatorStyle = .none
        case .MountainMeadow:break
        case .PersianBlue:break
        case .Custom:break
        }
        

        // NavigationBar Appearance
        
        navigationItem.title = NSLocalizedString("Contacts", comment: "")
        let normalTitleforNavigationBar = [
            NSAttributedString.Key.foregroundColor: UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_TITLE_COLOR),
            NSAttributedString.Key.font: UIFont(name: SystemFont.regular.value, size: 21)!]
        navigationController?.navigationBar.titleTextAttributes = normalTitleforNavigationBar
        navigationController?.navigationBar.barTintColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_COLOR)
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            let letlargeTitleforNavigationBar = [
                NSAttributedString.Key.foregroundColor: UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_TITLE_COLOR),
                NSAttributedString.Key.font: UIFont(name: SystemFont.bold.value, size: 40)!]
            navigationController?.navigationBar.largeTitleTextAttributes = letlargeTitleforNavigationBar
        } else {
            
        }
        
        // NavigationBar Buttons Appearance
        // notifyButton.setImage(UIImage(named: "bell.png"), for: .normal)
        createButton.setImage(UIImage(named: "new.png"), for: .normal)
        createButton.isHidden = true
        moreButton.setImage(UIImage(named: "more_vertical.png"), for: .normal)
        
        // notifyButton.tintColor = UIColor(hexFromString: UIAppearance.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        createButton.tintColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        moreButton.tintColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
 
    }
    
    
    //TableView Methods
    
    //numberOfRowsInSection:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if usersArray.isEmpty{
            DispatchQueue.main.async(execute: {
                AMShimmer.start(for: self.oneOneOneTableView)
            })
            return 15
        }else{
            DispatchQueue.main.async(execute: {
                AMShimmer.stop(for: self.oneOneOneTableView)
            })
            return usersArray.count
        }
        
        // return 0
    }
    
    //cellForRowAt indexPath :
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = oneOneOneTableView.dequeueReusableCell(withIdentifier: "oneOnOneTableViewCell") as! OneOnOneTableViewCell
        
        if !usersArray.isEmpty {
            
            buddyData = self.usersArray[indexPath.row]
            //User Name:
            cell.buddyName.text = buddyData.name
            
            //User Status:
             cell.buddyStatus.text = buddyData.status == .online ? NSLocalizedString("Online", comment: "") : NSLocalizedString("Offline", comment: "")
            cell.UID = buddyData.uid
            //User status Icon:
            switch buddyData.status{
                
            case .online:
                 cell.buddyStatusIcon.backgroundColor = UIColor.init(hexFromString: "9ACD32")
            case .offline:
                cell.buddyStatusIcon.backgroundColor = UIColor.init(hexFromString: "#F5C11F")
            }
            let url  = NSURL(string: buddyData.avatar ?? "")
            cell.buddyAvtar.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_user"))
        }else{
            
        }
        return cell
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            self.fetchUsersList()
        }
    }
    
    
    //didSelectRowAt indexPath
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        oneOneOneTableView.deselectRow(at: indexPath, animated: true)
        let selectedCell:OneOnOneTableViewCell = tableView.cellForRow(at: indexPath) as! OneOnOneTableViewCell
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chatViewController = storyboard.instantiateViewController(withIdentifier: "chatViewController") as! ChatViewController
        chatViewController.buddyStatusString = selectedCell.buddyStatus.text
        chatViewController.buddyAvtar = selectedCell.buddyAvtar.image
        chatViewController.buddyNameString = selectedCell.buddyName.text
        chatViewController.buddyUID = selectedCell.UID
        chatViewController.isGroup = "0"
        navigationController?.pushViewController(chatViewController, animated: true)
    }
    
    
    //heightForRowAt indexPath
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    //trailingSwipeActionsConfigurationForRowAt indexPath
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        
        let blockAction =  UIContextualAction(style: .normal, title: "Files1", handler: { (deleteAction,view,completionHandler ) in
            
            var blockUsers = [String]()
            let selectedCell:OneOnOneTableViewCell = tableView.cellForRow(at: indexPath) as! OneOnOneTableViewCell
            blockUsers.append(selectedCell.UID)
            CometChat.blockUsers(blockUsers, onSuccess: { (User) in
               // if !self.usersArray.isEmpty{
                    DispatchQueue.main.async {
                         self.view.makeToast("User blocked sucessfully.")
                         self.usersArray.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                         self.oneOneOneTableView.reloadData()
                        blockUsers.removeAll()
                    }
                //}
            }, onError: { (Error) in
               DispatchQueue.main.async { self.view.makeToast("Unable to block user") }
            })
            completionHandler(true)
        })
        
        blockAction.image = UIImage(named: "block.png")
        blockAction.backgroundColor = .red
    
        let confrigation = UISwipeActionsConfiguration(actions: [blockAction])
        return confrigation
    }
    
    
    //leadingSwipeActionsConfigurationForRowAt indexPath
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let selectedCell:OneOnOneTableViewCell = tableView.cellForRow(at: indexPath) as! OneOnOneTableViewCell
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CallingViewController = storyboard.instantiateViewController(withIdentifier: "callingViewController") as! CallingViewController
        
        let videoCall =  UIContextualAction(style: .normal, title: "Files", handler: { (action,view,completionHandler ) in
            completionHandler(true)
            CallingViewController.isAudioCall = "0"
            CallingViewController.isIncoming = false
            CallingViewController.userAvtarImage = selectedCell.buddyAvtar.image
            CallingViewController.userNameString = selectedCell.buddyName.text
            CallingViewController.callingString = NSLocalizedString("Calling ...", comment: "")
            CallingViewController.callerUID = selectedCell.UID
            CallingViewController.isGroupCall = false
            self.present(CallingViewController, animated: true, completion: nil)
            
        })
        videoCall.image = UIImage(named: "video_call.png")
        videoCall.backgroundColor = .green
        
        let audioCall =  UIContextualAction(style: .normal, title: "Files1", handler: { (deleteAction,view,completionHandler ) in
            completionHandler(true)
            CallingViewController.isAudioCall = "1"
            CallingViewController.isIncoming = false
            CallingViewController.userAvtarImage = selectedCell.buddyAvtar.image
            CallingViewController.userNameString = selectedCell.buddyName.text
            CallingViewController.callingString = NSLocalizedString("Calling ...", comment: "")
            CallingViewController.callerUID = selectedCell.UID
            CallingViewController.isGroupCall = false
            self.present(CallingViewController, animated: true, completion: nil)
        })
        audioCall.image = UIImage(named: "audio_call.png")
        audioCall.backgroundColor = .blue
        
        let confrigation:UISwipeActionsConfiguration!
        if AMShimmer.isAnimating == false{
            confrigation  = UISwipeActionsConfiguration(actions: [videoCall,audioCall])
        }else{
            confrigation = UISwipeActionsConfiguration(actions: [])
        }
        
        return confrigation
    }
    
    
    //announcement button Pressed
    @IBAction func announcementPressed(_ sender: Any) {
        
        
        
        
        
    }
    
    //More button Pressed
    @IBAction func morePressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CCMoreViewController = storyboard.instantiateViewController(withIdentifier: "moreSettingsViewController") as! MoreSettingsViewController
        navigationController?.pushViewController(CCMoreViewController, animated: true)
        CCMoreViewController.title = NSLocalizedString("More", comment: "")
        CCMoreViewController.hidesBottomBarWhenPushed = true
        
    }
    
    
    //createContact button Pressed
    @IBAction func createContactPressed(_ sender: Any) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let firstAction: UIAlertAction = UIAlertAction(title: "Create Contact", style: .default) { action -> Void in
        }
        firstAction.setValue(UIImage(named: "createContact.png"), forKey: "image")
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(cancelAction)
        present(actionSheetController, animated: true, completion: nil)
    }
    
}

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
    var searchController:UISearchController!
    var usersArray = [User]()
    var userRequest = UsersRequest.UsersRequestBuilder(limit: 20).build()
    var buddyData:User!
    let data:NSData! = nil
    var url:NSURL!
    var refreshControl: UIRefreshControl!
    
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
        
        if let row = self.usersArray.index(where: {$0.uid == user.uid}) {
            usersArray[row] = user
            let indexPath = IndexPath(row: row, section: 0)
            oneOneOneTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func onUserOffline(user: User) {
        if let row = self.usersArray.index(where: {$0.uid == user.uid}) {
            usersArray[row] = user
            let indexPath = IndexPath(row: row, section: 0)
            oneOneOneTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc func refresh(_ sender: Any){
        
        if(usersArray.isEmpty){
            fetchUsersList()
        }
        refreshControl.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
   
        oneOneOneTableView.reloadData()
        
        //Function Calling
        self.handleContactListVCAppearance()
        
    }
    
    
    
    func fetchUsersList(){
        // This Method fetch the users from the Server.
        userRequest.fetchNext(onSuccess: { (userList) in
            
           self.usersArray.append(contentsOf: userList)
           DispatchQueue.main.async(execute: { self.oneOneOneTableView.reloadData()
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
        
        // Refresh control
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        if #available(iOS 10.0, *) {
            oneOneOneTableView.refreshControl = refreshControl
        } else {
            oneOneOneTableView.addSubview(refreshControl)
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
        refreshControl.tintColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        
        
        // SearchBar Apperance
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_TITLE_COLOR)
        
        if(UIAppearanceColor.SEARCH_BAR_STYLE_LIGHT_CONTENT == true){
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Search Name", comment: ""), attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(white: 1, alpha: 0.5)])
        }else{
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Search Name", comment: ""), attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(white: 0, alpha: 0.5)])
        }
        
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        
        let SearchImageView = UIImageView.init()
        let SearchImage = UIImage(named: "icons8-search-30")!.withRenderingMode(.alwaysTemplate)
        SearchImageView.image = SearchImage
        SearchImageView.tintColor = UIColor.init(white: 1, alpha: 0.5)
        
        searchController.searchBar.setImage(SearchImageView.image, for: UISearchBarIcon.search, state: .normal)
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.white
            if let backgroundview = textfield.subviews.first{
                
                // Background color
                backgroundview.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
                // Rounded corner
                backgroundview.layer.cornerRadius = 10
                backgroundview.clipsToBounds = true;
            }
        }
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            
        }
        
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
        let oneOnOneChatViewController = storyboard.instantiateViewController(withIdentifier: "oneOnOneChatViewController") as! OneOnOneChatViewController
        oneOnOneChatViewController.buddyStatusString = selectedCell.buddyStatus.text
        oneOnOneChatViewController.buddyAvtar = selectedCell.buddyAvtar.image
        oneOnOneChatViewController.buddyNameString = selectedCell.buddyName.text
        oneOnOneChatViewController.buddyUID = selectedCell.UID
        oneOnOneChatViewController.isGroup = "0"
        navigationController?.pushViewController(oneOnOneChatViewController, animated: true)
    }
    
    
    //heightForRowAt indexPath
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    //trailingSwipeActionsConfigurationForRowAt indexPath
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action =  UIContextualAction(style: .normal, title: "Files", handler: { (action,view,completionHandler ) in
            completionHandler(true)
            
            
            // Here you can perform the action 
        })
        action.image = UIImage(named: "delete.png")
        action.backgroundColor = .red
        
        let deleteAction =  UIContextualAction(style: .normal, title: "Files1", handler: { (deleteAction,view,completionHandler ) in
            completionHandler(true)
        })
        
        deleteAction.image = UIImage(named: "block.png")
        deleteAction.backgroundColor = .orange
        let confrigation = UISwipeActionsConfiguration(actions: [])
        // let confrigation = UISwipeActionsConfiguration(actions: [action,deleteAction])
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

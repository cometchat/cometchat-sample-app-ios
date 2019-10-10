//
//  OneOnOneListViewController.swift
//  CometChatUI
//
//  Created by pushpsen airekar on 18/11/18.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.
//

import UIKit
import CometChatPro

///////////////////////////////////////////////////////////////////////////////////////////////

class OneOnOneListViewController: UIViewController {
    
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
    var filteredUsersArray = [User]()
    var userRequest = UsersRequest.UsersRequestBuilder(limit: 20).build()
    var buddyData:User!
    let data:NSData! = nil
    var url:NSURL!
    var tabBadgeCount:Int = 0
    var unreadCount = [String]()
    var searchController:UISearchController = UISearchController(searchResultsController: nil)
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Function Calling
        self.fetchUsersList()
        oneOneOneTableView.reloadData()
        
        //Assigning Delegates
        oneOneOneTableView.delegate = self
        oneOneOneTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.refreshUserList()
        //Function Calling
        self.handleContactListVCAppearance()
        
        //Assigning Delegates
        CometChat.userdelegate = self
        CometChat.messagedelegate = self
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        searchController.searchBar.resignFirstResponder()
        searchController.searchBar.endEditing(true)
        searchController.isActive = false
        searchController.searchBar.delegate = nil
        searchController.searchResultsUpdater = nil
        super.viewDidDisappear(true)
    }
    
    func fetchUsersList(){
        // This Method fetch the users from the Server.
        userRequest.fetchNext(onSuccess: { (userList) in
            if !userList.isEmpty {
                self.usersArray.append(contentsOf: userList)
                DispatchQueue.main.async(execute: {
                    self.oneOneOneTableView.reloadData()
                })
            }
        }) { (exception) in
            DispatchQueue.main.async(execute: {
                self.view .makeToast("\(String(describing: exception!.errorDescription))")
            })
            CometChatLog.print(items:exception?.errorDescription as Any)
        }
    }
    
    func refreshUserList(){
        self.usersArray.removeAll()
        self.unreadCount.removeAll()
        userRequest = UsersRequest.UsersRequestBuilder(limit: 20).build()
        userRequest.fetchNext(onSuccess: { (userList) in
            if !userList.isEmpty {
                self.usersArray.append(contentsOf: userList)
                DispatchQueue.main.async(execute: {
                    self.oneOneOneTableView.reloadData()
                })
            }
        }) { (exception) in
            DispatchQueue.main.async(execute: {
                self.view .makeToast("\(String(describing: exception!.errorDescription))")
            })
            CometChatLog.print(items:exception?.errorDescription as Any)
        }
    }
    
    func setTabbarCount(){
        if let tabItems = tabBarController?.tabBar.items {
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[0]
            tabItem.badgeValue = "\(tabBadgeCount)"
            if tabBadgeCount == 0 {
                tabItem.badgeValue = nil
            }}
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
        case .Custom:break}
        
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
        } else {}
        
        // NavigationBar Buttons Appearance
        createButton.setImage(UIImage(named: "new.png"), for: .normal)
        createButton.isHidden = true
        moreButton.setImage(UIImage(named: "more_vertical.png"), for: .normal)
        createButton.tintColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        moreButton.tintColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        
        // SearchBar Apperance
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_TITLE_COLOR)
        
        if(UIAppearanceColor.SEARCH_BAR_STYLE_LIGHT_CONTENT == true){
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Search User", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.5)])
        }else{
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Search User", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 0, alpha: 0.5)])
        }
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let SearchImageView = UIImageView.init()
        let SearchImage = UIImage(named: "icons8-search-30")!.withRenderingMode(.alwaysTemplate)
        SearchImageView.image = SearchImage
        SearchImageView.tintColor = UIColor.init(white: 1, alpha: 0.5)
        
        searchController.searchBar.setImage(SearchImageView.image, for: UISearchBar.Icon.search, state: .normal)
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
        } else {}
    }
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height && usersArray.count > 7{
            self.fetchUsersList()
        }
    }
    
    //announcement button Pressed
    @IBAction func announcementPressed(_ sender: Any) {}
    
    //More button Pressed
    @IBAction func morePressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CCMoreViewController = storyboard.instantiateViewController(withIdentifier: "moreSettingsViewController") as! MoreSettingsViewController
        navigationController?.pushViewController(CCMoreViewController, animated: true)
        CCMoreViewController.title = NSLocalizedString("More", comment: "")
        CCMoreViewController.hidesBottomBarWhenPushed = true
    }
    
    //createContact button Pressed:
    @IBAction func createContactPressed(_ sender: Any) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let firstAction: UIAlertAction = UIAlertAction(title: "Create Contact", style: .default) { action -> Void in
        }
        firstAction.setValue(UIImage(named: "createContact.png"), forKey: "image")
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
        }
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(cancelAction)
        present(actionSheetController, animated: true, completion: nil)
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////

//TableView Methods
extension OneOnOneListViewController : UITableViewDelegate, UITableViewDataSource {
    
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
            if isFiltering(){
                if filteredUsersArray.isEmpty {
                    self.oneOneOneTableView.setEmptyMessage("No users found.")
                } else {
                    self.oneOneOneTableView.restore()
                }
                return filteredUsersArray.count
            }else{
                self.oneOneOneTableView.restore()
            }
            return usersArray.count
        }
    }
    
    //cellForRowAt indexPath :
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = oneOneOneTableView.dequeueReusableCell(withIdentifier: "oneOnOneTableViewCell") as! OneOnOneTableViewCell
        if !usersArray.isEmpty {
            
            if isFiltering() {
                buddyData = self.filteredUsersArray[indexPath.row]
            } else {
                buddyData = self.usersArray[indexPath.row]
            }
            
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
            
            if buddyData.blockedByMe == true{
                cell.blockedLabel.isHidden = false
            }else{
                cell.blockedLabel.isHidden = true
            }
            
            let url  = NSURL(string: buddyData.avatar ?? "")
            cell.buddyAvtar.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_user"))
            cell.getUnreadCountForAllUsers(UID: buddyData.uid!) { (count, error) in
                
                DispatchQueue.main.async {
                    if count == 0 {
                        cell.unreadCountBadge.isHidden = true
                    }else{
                        cell.unreadCountBadge.isHidden = false
                        if !self.unreadCount.contains(cell.UID){
                            self.unreadCount.append(cell.UID)
                            self.tabBadgeCount = self.unreadCount.count
                            print("array: \(self.unreadCount)")
                            print("arrayCount: \(self.unreadCount.count)")
                            self.setTabbarCount() }
                        cell.unreadCountLabel.text = "\(String(describing: count!))"
                    }
                }
            }
        }else{}
        return cell
    }
    
    //didSelectRowAt indexPath
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        oneOneOneTableView.deselectRow(at: indexPath, animated: true)
        let selectedCell:OneOnOneTableViewCell = tableView.cellForRow(at: indexPath) as! OneOnOneTableViewCell
        selectedCell.unreadCountLabel.text = "0"
        selectedCell.unreadCountBadge.isHidden = true
        
        if(unreadCount.contains(selectedCell.UID)){
            unreadCount.removeFirstElementEqual(to: selectedCell.UID)
            tabBadgeCount = unreadCount.count
            setTabbarCount()
        }
        
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
            
            if selectedCell.blockedLabel.isHidden == true{
                blockUsers.append(selectedCell.UID)
                CometChat.blockUsers(blockUsers, onSuccess: { (User) in
                    DispatchQueue.main.async {
                        selectedCell.blockedLabel.isHidden = false
                        self.view.makeToast("User blocked sucessfully.")
                        blockUsers.removeAll()
                    }
                }, onError: { (Error) in
                    DispatchQueue.main.async { self.view.makeToast("Unable to block user") }
                })
            }else{
                self.view.makeToast("This user is blocked already.")
            }
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
    
}


///////////////////////////////////////////////////////////////////////////////////////////////

// MARK: - UISearchResultsUpdating Delegate
extension OneOnOneListViewController : UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        userRequest = UsersRequest.UsersRequestBuilder(limit: 20).set(searchKeyword: searchController.searchBar.text ?? "").build()
        userRequest.fetchNext(onSuccess: { (userList) in
            
            self.filteredUsersArray = userList
            
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
}

///////////////////////////////////////////////////////////////////////////////////////////////

extension OneOnOneListViewController : CometChatUserDelegate {
    
    func onUserOnline(user: User) {
        if let row = self.usersArray.firstIndex(where: {$0.uid == user.uid}) {
            usersArray[row] = user
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                self.oneOneOneTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func onUserOffline(user: User) {
        if let row = self.usersArray.firstIndex(where: {$0.uid == user.uid}) {
            usersArray[row] = user
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                self.oneOneOneTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////

extension OneOnOneListViewController : CometChatMessageDelegate {
    
    func onTextMessageReceived(textMessage: TextMessage) {
        if let row = self.usersArray.firstIndex(where: {$0.uid == textMessage.senderUid}) {
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                let cell = self.oneOneOneTableView.cellForRow(at: indexPath) as! OneOnOneTableViewCell
                if let cellCount:String = cell.unreadCountLabel.text, let count = Int(cellCount){
                    cell.unreadCountLabel.text = "\(count + 1)"
                    if cell.unreadCountBadge.isHidden {
                        cell.unreadCountBadge.isHidden = false
                    }
                    cell.reloadInputViews()
                }
            }
        }
    }
    
    func onMediaMessageReceived(mediaMessage: MediaMessage) {
        if let row = self.usersArray.firstIndex(where: {$0.uid == mediaMessage.senderUid}) {
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                let cell = self.oneOneOneTableView.cellForRow(at: indexPath) as! OneOnOneTableViewCell
                if let cellCount:String = cell.unreadCountLabel.text, let count = Int(cellCount){
                    cell.unreadCountLabel.text = "\(count + 1)"
                    if cell.unreadCountBadge.isHidden {
                        cell.unreadCountBadge.isHidden = false
                    }
                    cell.reloadInputViews()
                }
            }
        }
    }
    
    func onCustomMessageReceived(customMessage: CustomMessage) {
        if let row = self.usersArray.firstIndex(where: {$0.uid == customMessage.senderUid}) {
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                let cell = self.oneOneOneTableView.cellForRow(at: indexPath) as! OneOnOneTableViewCell
                if let cellCount:String = cell.unreadCountLabel.text, let count = Int(cellCount){
                    cell.unreadCountLabel.text = "\(count + 1)"
                    if cell.unreadCountBadge.isHidden {
                        cell.unreadCountBadge.isHidden = false
                    }
                    cell.reloadInputViews()
                }
            }
        }
    }
    
    func onTypingStarted(_ typingDetails: TypingIndicator) {
        if let row = self.usersArray.firstIndex(where: {$0.uid == typingDetails.sender?.uid}) {
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                let cell = self.oneOneOneTableView.cellForRow(at: indexPath) as! OneOnOneTableViewCell
                cell.buddyStatus.text = "Typing..."
                cell.buddyStatus.textColor = UIColor.init(hexFromString: "9ACD32")
                cell.buddyStatus.font = UIFont.italicSystemFont(ofSize: 15.0)
                cell.reloadInputViews()
            }
        }
    }
    
    func onTypingEnded(_ typingDetails: TypingIndicator) {
        
        if let row = self.usersArray.firstIndex(where: {$0.uid == typingDetails.sender?.uid}) {
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                let cell = self.oneOneOneTableView.cellForRow(at: indexPath) as! OneOnOneTableViewCell
                cell.buddyStatus.text = "Online"
                cell.buddyStatus.textColor = UIColor.init(hexFromString: "434343")
                cell.buddyStatus.font = UIFont.systemFont(ofSize: 15.0)
                cell.reloadInputViews()
            }
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////

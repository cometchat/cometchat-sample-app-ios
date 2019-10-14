//
//  GroupListViewController.swift
//  CometChatUI
//
//  Created by pushpsen airekar on 18/11/18.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.
//

import UIKit
import CometChatPro


class GroupListViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate {
    
    //Outlets Declarations
    @IBOutlet weak var groupTableView: UITableView!
    @IBOutlet weak var notifyButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var leftPadding: NSLayoutConstraint!
    @IBOutlet weak var rightPadding: NSLayoutConstraint!
    
    
    //Variable Declarations
    var joinedChatRoomList = [Group]()
    var othersChatRoomList = [Group]()
    var filteredGroupList = [Group]()
    var tabBadgeCount:Int = 0
    var unreadCount = [String]()
    var groupRequest = GroupsRequest.GroupsRequestBuilder(limit: 10).build()
    var refreshControl: UIRefreshControl!
    var searchController:UISearchController = UISearchController(searchResultsController: nil)
    
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Notification Observer
        NotificationCenter.default.addObserver(self, selector: #selector(self.createGroupObserver(notification:)), name: Notification.Name("com.newGroupData"), object: nil)
        
        //Function Calling
        self.fetchGroupList()
        groupTableView.reloadData()
        
        //Assigning Delegates
        groupTableView.delegate = self
        groupTableView.dataSource = self
        CometChat.groupdelegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Assigning Delegates
        CometChat.groupdelegate = self
        CometChat.messagedelegate = self
        
        self.refreshGroupList()
        if((UserDefaults.standard.value(forKey: "changeLanguageAction")) != nil){
            groupTableView.reloadData()
        }
        
        var isGroupLeave:String!
        if((UserDefaults.standard.value(forKey: "leaveGroupAction")) != nil){
            isGroupLeave = (UserDefaults.standard.value(forKey: "leaveGroupAction") as! String)
        }else{
            isGroupLeave = "0"
        }
        if(isGroupLeave == "1"){
            self.fetchGroupList()
            UserDefaults.standard.removeObject(forKey: "leaveGroupAction")
        }
        
        //Calling Function
        self.handleGroupListVCAppearance()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UserDefaults.standard.removeObject(forKey: "changeLanguageAction")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        searchController.searchBar.resignFirstResponder()
        searchController.searchBar.endEditing(true)
        searchController.isActive = false
        searchController.searchBar.delegate = nil
        searchController.searchResultsUpdater = nil
        super.viewDidDisappear(true)
    }
    
    @objc func refresh(_ sender: Any) {
        refreshGroupList()
        refreshControl.endRefreshing()
    }
    
    
    func fetchGroupList(){
        //This method fetches the grouplist from the server
        groupRequest.fetchNext(onSuccess: { (groupList) in
            if !groupList.isEmpty{
                for group in groupList {
                    if(group.hasJoined == true){
                        self.joinedChatRoomList.append(group)
                        CometChatLog.print(items: "joinedChatRoomList is:",self.joinedChatRoomList)
                    }else{
                        self.othersChatRoomList.append(group)
                        CometChatLog.print(items:"othersChatRoomList is:",self.othersChatRoomList)
                    }
                }
                DispatchQueue.main.async(execute: { self.groupTableView.reloadData()
                })
            }
        }) { (exception) in
            DispatchQueue.main.async(execute: {
                self.view.makeToast("\(String(describing: exception!.errorDescription))")
            })
            CometChatLog.print(items:exception?.errorDescription as Any)
        }
    }
    
    func refreshGroupList(){
        //This method fetches the grouplist from the server
        self.joinedChatRoomList.removeAll()
        self.othersChatRoomList.removeAll()
        self.unreadCount.removeAll()
        groupRequest = GroupsRequest.GroupsRequestBuilder(limit: 20).build()
        groupRequest.fetchNext(onSuccess: { (groupList) in
            if !groupList.isEmpty{
                for group in groupList {
                    if(group.hasJoined == true){
                        self.joinedChatRoomList.append(group)
                        CometChatLog.print(items: "joinedChatRoomList is:",self.joinedChatRoomList)
                        
                    }else{
                        self.othersChatRoomList.append(group)
                        CometChatLog.print(items:"othersChatRoomList is:",self.othersChatRoomList)
                    }
                }
                DispatchQueue.main.async(execute: { self.groupTableView.reloadData()
                })
            }
        }) { (exception) in
            DispatchQueue.main.async(execute: {
                self.view.makeToast("\(String(describing: exception!.errorDescription))")
            })
            CometChatLog.print(items:exception?.errorDescription as Any)
        }
    }
    
    func setTabbarCount(){
        if let tabItems = tabBarController?.tabBar.items {
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[1]
            tabItem.badgeValue = "\(tabBadgeCount)"
            if tabBadgeCount == 0{
                tabItem.badgeValue = nil
            }
        }
    }
    
    
    @objc func createGroupObserver(notification: Notification) {
        let newGroup:Group = notification.userInfo?["groupData"] as! Group
        CometChatLog.print(items:"new group is: \(newGroup.stringValue())")
        joinedChatRoomList.append(newGroup)
        DispatchQueue.main.async {self.groupTableView.reloadData()}
    }
    
    
    //This method handles the UI customization for handleGroupListVC
    func  handleGroupListVCAppearance(){
        
        // ViewController Appearance
        view.backgroundColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_COLOR)
        
        //TableView Appearance
        self.groupTableView.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        groupTableView.tableFooterView = UIView(frame: .zero)
        self.leftPadding.constant = CGFloat(UIAppearanceSize.Padding)
        self.rightPadding.constant = CGFloat(UIAppearanceSize.Padding)
        
        switch AppAppearance{
        case .AzureRadiance:self.groupTableView.separatorStyle = .none
        case .MountainMeadow:break
        case .PersianBlue:break
        case .Custom:break
        }
        
        // NavigationBar Appearance
        navigationItem.title = NSLocalizedString("Groups", comment: "")
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
        }
        //Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        if #available(iOS 10.0, *) {
            groupTableView.refreshControl = refreshControl
        } else {
            groupTableView.addSubview(refreshControl)
        }
        
        // NavigationBar Buttons Appearance
        
        // notifyButton.setImage(UIImage(named: "bell.png"), for: .normal)
        createButton.setImage(UIImage(named: "new.png"), for: .normal)
        moreButton.setImage(UIImage(named: "more_vertical.png"), for: .normal)
        
        //notifyButton.tintColor = UIColor(hexFromString: UIAppearance.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        createButton.tintColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        moreButton.tintColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        refreshControl.tintColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        
        // SearchBar Apperance
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_TITLE_COLOR)
        
        if(UIAppearanceColor.SEARCH_BAR_STYLE_LIGHT_CONTENT == true){
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Search Group", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 1, alpha: 0.5)])
        }else{
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Search Group", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(white: 0, alpha: 0.5)])
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
        } else {
            
        }
    }
    
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && (!searchBarIsEmpty())
    }
    
    //TableView Methods:
    
    //numberOfSections -->
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if isFiltering(){
            return 1
        }else{
            return 2
        }
    }
    
    //numberOfRowsInSection -->
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if joinedChatRoomList.isEmpty && othersChatRoomList.isEmpty{
            AMShimmer.start(for: groupTableView)
            return 15
        }else{
            AMShimmer.stop(for: groupTableView)
            
            if isFiltering(){
                if filteredGroupList.count == 0 {
                    self.groupTableView.setEmptyMessage("No groups found.")
                } else {
                    self.groupTableView.restore()
                }
                return filteredGroupList.count
            }else{
                self.groupTableView.restore()
            }
            
            if (section == 0) {
                return joinedChatRoomList.count
            } else {
                return othersChatRoomList.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if (section == 0) {
            if(joinedChatRoomList.count == 0)
            {
                return 0
            } else {
                return 40
            }
        } else {
            if(othersChatRoomList.count == 0)
            {
                return 0
            } else {
                return 40
            }
        }
    }
    
    //cellForRowAt indexPath -->
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = groupTableView.dequeueReusableCell(withIdentifier: "groupTableViewCell") as! GroupTableViewCell
        
        if !joinedChatRoomList.isEmpty  || !othersChatRoomList.isEmpty {
            
            var group:Group?
            
            if isFiltering() {
                group = self.filteredGroupList.item(at: indexPath.row)
            } else {
                if(indexPath.section == 0){
                    group = joinedChatRoomList.item(at: indexPath.row)
                }else{
                    group = othersChatRoomList.item(at: indexPath.row)
                }
            }
            
            if(group?.groupType == .password){
                cell.passwordProtected.isHidden = false
            }else{
                cell.passwordProtected.isHidden = true
            }
            cell.group = group
            cell.groupScope = group?.scope.rawValue
            cell.groupName.text = group?.name
            let groupIconURL = NSURL(string: group?.icon ?? "")
            cell.groupAvtar.sd_setImage(with: groupIconURL as URL?, placeholderImage: #imageLiteral(resourceName: "default_user_icon"))
            cell.groupParticipants.text = group?.groupDescription
            cell.UID = group?.guid
            cell.groupType = group?.groupType.rawValue
            cell.getUnreadCountForAllGroups(UID: group?.guid ?? "0") { (count, error) in
                
                DispatchQueue.main.async {
                    if count == 0 {
                        cell.unreadCountBadge.isHidden = true
                    }else{
                        cell.unreadCountBadge.isHidden = false
                        
                        if !self.unreadCount.contains(cell.UID){
                            self.unreadCount.append(cell.UID)
                            self.tabBadgeCount = self.unreadCount.count
                            self.setTabbarCount()
                        }
                        cell.unreadCountLabel.text = "\(String(describing: count!))"
                    }
                }
            }
            
        }else{}
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        groupTableView.deselectRow(at: indexPath, animated: true)
        let selectedCell:GroupTableViewCell = tableView.cellForRow(at: indexPath) as! GroupTableViewCell
        selectedCell.unreadCountBadge.isHidden = true
        selectedCell.unreadCountLabel.text = "0"
        
        if(unreadCount.contains(selectedCell.UID)){
            unreadCount.removeFirstElementEqual(to: selectedCell.UID)
            tabBadgeCount = unreadCount.count
            setTabbarCount()
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chatViewController = storyboard.instantiateViewController(withIdentifier: "chatViewController") as! ChatViewController
        chatViewController.buddyAvtar = selectedCell.groupAvtar.image
        chatViewController.buddyNameString = selectedCell.groupName.text
        chatViewController.buddyUID = selectedCell.UID!
        chatViewController.isGroup = "1"
        
        if let scope = selectedCell.groupScope {
            chatViewController.groupScope = scope
        }
        
        if selectedCell.group.hasJoined == false{
            if(selectedCell.groupType == 2){
                let alertController = UIAlertController(title: NSLocalizedString("Enter Password", comment: ""), message:NSLocalizedString("Kindly, Enter the password to proceed.", comment: "") , preferredStyle: UIAlertController.Style.alert)
                alertController.addTextField { (textField : UITextField!) -> Void in
                    textField.placeholder = NSLocalizedString("Enter Password", comment: "")
                    textField.isSecureTextEntry = true
                }
                let saveAction = UIAlertAction(title: NSLocalizedString("Join", comment: ""), style: UIAlertAction.Style.default, handler: { alert -> Void in
                    let passwordTextfield = alertController.textFields![0] as UITextField
                    CometChat.joinGroup(GUID: selectedCell.UID, groupType: .password, password: passwordTextfield.text, onSuccess: { (success) in
                        
                        DispatchQueue.main.async{
                            
                            self.view.makeToast(NSLocalizedString("Group Joined Sucessfully.", comment: ""))
                            self.navigationController?.pushViewController(chatViewController, animated: true)
                            self.othersChatRoomList.remove(at: indexPath.row)
                            if !self.othersChatRoomList.isEmpty {
                                tableView.deleteRows(at: [indexPath], with: .fade)
                            }
                            self.joinedChatRoomList.append(selectedCell.group)
                            self.groupTableView.reloadData()
                        }
                    }) { (error) in
                        DispatchQueue.main.async {
                            self.view.makeToast(NSLocalizedString("Failed to join group", comment: ""))
                        }
                    }
                    self.navigationController?.pushViewController(chatViewController, animated: true)
                })
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.destructive, handler: {
                    (action : UIAlertAction!) -> Void in })
                
                alertController.addAction(cancelAction)
                alertController.addAction(saveAction)
                self.present(alertController, animated: true, completion: nil)
                
            }else{
                
                CometChat.joinGroup(GUID: selectedCell.UID, groupType: .public, password: nil, onSuccess: { (success) in
                    
                    DispatchQueue.main.async{
                        self.view.makeToast(NSLocalizedString("Group Joined Sucessfully.", comment: ""))
                        self.navigationController?.pushViewController(chatViewController, animated: true)
                        self.othersChatRoomList.remove(at: indexPath.row)
                        if !self.othersChatRoomList.isEmpty {
                            tableView.deleteRows(at: [indexPath], with: .fade)
                        }
                        self.joinedChatRoomList.append(selectedCell.group)
                        self.groupTableView.reloadData()
                    }
                }) { (error) in
                    DispatchQueue.main.async {
                        self.view.makeToast(NSLocalizedString("Failed to join group", comment: ""))
                    }
                }
            }
        }else{
            self.navigationController?.pushViewController(chatViewController, animated: true)
        }
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            self.fetchGroupList()
        }
        
    }
    
    //titleForHeaderInSection indexPath -->
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0) {
            if(isFiltering()){
                return NSLocalizedString("Searched Groups", comment: "")
            }else{
                return NSLocalizedString("Joined Groups", comment: "")
            }
        }
        else {
            return NSLocalizedString("Other Groups", comment: "")
        }
    }
    
    //heightForRowAt indexPath -->
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    
    
    //trailingSwipeActionsConfigurationForRowAt indexPath -->
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let selectedCell:GroupTableViewCell = tableView.cellForRow(at: indexPath) as! GroupTableViewCell
        
        let deleteAction =  UIContextualAction(style: .normal, title: "Files", handler: { (action,view,completionHandler ) in
            
            CometChat.deleteGroup(GUID: selectedCell.UID, onSuccess: { (sucess) in
                DispatchQueue.main.async {
                    self.view.makeToast("\(sucess)")
                    self.joinedChatRoomList.remove(at: indexPath.row)
                    if !self.joinedChatRoomList.isEmpty{
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                    self.groupTableView.reloadData()
                }
            }, onError: { (error) in
                DispatchQueue.main.async {
                    self.view.makeToast("\(error.debugDescription)")
                }
            })
            completionHandler(true)
        })
        deleteAction.image = UIImage(named: "delete.png")
        deleteAction.backgroundColor = .red
        
        
        let leaveAction =  UIContextualAction(style: .normal, title: "Files1", handler: { (deleteAction,view,completionHandler ) in
            
            CometChat.leaveGroup(GUID: selectedCell.UID, onSuccess: { (sucess) in
                DispatchQueue.main.async {
                    self.view.makeToast("\(sucess)")
                    self.joinedChatRoomList.remove(at: indexPath.row)
                    
                    if !self.joinedChatRoomList.isEmpty {
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                    self.othersChatRoomList.insert(selectedCell.group, at: 0)
                    self.groupTableView.reloadData()
                }
            }, onError: { (error) in
                DispatchQueue.main.async {
                    self.view.makeToast("\(error.debugDescription)")
                }
            })
            completionHandler(true)
        })
        leaveAction.image = UIImage(named: "leaveGroup.png")
        leaveAction.backgroundColor = .orange
        
        var confrigation:UISwipeActionsConfiguration?
        if AMShimmer.isAnimating == false {
            if(indexPath.section == 0){
                if(selectedCell.groupScope == 0){
                    confrigation = UISwipeActionsConfiguration(actions: [deleteAction,leaveAction])
                }else{
                    confrigation = UISwipeActionsConfiguration(actions: [leaveAction])
                }
            }else{
                confrigation = UISwipeActionsConfiguration(actions: [])
            }
        }else{
            confrigation = UISwipeActionsConfiguration(actions: [])
            
        }
        return confrigation
    }
    
    //leadingSwipeActionsConfigurationForRowAt indexPath -->
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let selectedCell:GroupTableViewCell = tableView.cellForRow(at: indexPath) as! GroupTableViewCell
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CallingViewController = storyboard.instantiateViewController(withIdentifier: "callingViewController") as! CallingViewController
        
        let videoCall =  UIContextualAction(style: .normal, title: "Files", handler: { (action,view,completionHandler ) in
            completionHandler(true)
            CallingViewController.isAudioCall = "0"
            CallingViewController.isIncoming = false
            CallingViewController.userAvtarImage = selectedCell.groupAvtar.image
            CallingViewController.userNameString = selectedCell.groupName.text
            CallingViewController.callingString = NSLocalizedString("Calling ...", comment: "")
            CallingViewController.callerUID = selectedCell.UID
            CallingViewController.isGroupCall = true
            self.present(CallingViewController, animated: true, completion: nil)
        })
        videoCall.image = UIImage(named: "video_call.png")
        videoCall.backgroundColor = .green
        
        
        let audioCall =  UIContextualAction(style: .normal, title: "Files1", handler: { (deleteAction,view,completionHandler ) in
            completionHandler(true)
            CallingViewController.isAudioCall = "1"
            CallingViewController.isIncoming = false
            CallingViewController.userAvtarImage = selectedCell.groupAvtar.image
            CallingViewController.userNameString = selectedCell.groupName.text
            CallingViewController.callingString = NSLocalizedString("Calling ...", comment: "")
            CallingViewController.callerUID = selectedCell.UID
            CallingViewController.isGroupCall = true
            self.present(CallingViewController, animated: true, completion: nil)
        })
        audioCall.image = UIImage(named: "audio_call.png")
        audioCall.backgroundColor = .blue
        
        var confrigation:UISwipeActionsConfiguration?
        if AMShimmer.isAnimating == false {
            if(indexPath.section == 0){
                confrigation = UISwipeActionsConfiguration(actions: [videoCall,audioCall])
            }
        }else{
            confrigation = UISwipeActionsConfiguration(actions: [])
        }
        return confrigation
    }
    
    //Announcement Button Pressed
    @IBAction func announcementPressed(_ sender: Any) {
        
        
        
    }
    
    //MoreSettinngs  Button Pressed
    @IBAction func morePressed(_ sender: UIView) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CCWebviewController = storyboard.instantiateViewController(withIdentifier: "moreSettingsViewController") as! MoreSettingsViewController
        navigationController?.pushViewController(CCWebviewController, animated: true)
        CCWebviewController.title = NSLocalizedString("More", comment: "")
        CCWebviewController.hidesBottomBarWhenPushed = true
    }
    
    private func showPopup(_ controller: UIViewController, sourceView: UIView) {
        let presentationController = AlwaysPresentAsPopover.configurePresentation(forController: controller)
        presentationController.sourceView = sourceView
        presentationController.sourceRect = sourceView.bounds
        presentationController.permittedArrowDirections = [.down, .up]
        self.present(controller, animated: true)
    }
    
    //CreateGroup Button Pressed
    @IBAction func createGroupPressed(_ sender: Any) {
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let createGroupAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Create Group", comment: ""), style: .default) { action -> Void in
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let createGroupcontroller = storyboard.instantiateViewController(withIdentifier: "createGroupcontroller") as! CreateGroupcontroller
            self.navigationController?.pushViewController(createGroupcontroller, animated: false)
            createGroupcontroller.title = NSLocalizedString("Create Group", comment: "")
            createGroupcontroller.hidesBottomBarWhenPushed = true
        }
        createGroupAction.setValue(UIImage(named: "createGroup.png"), forKey: "image")
        
        let cancelAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
        }
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        actionSheetController.addAction(createGroupAction)
        actionSheetController.addAction(cancelAction)
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ){
            
            if let currentPopoverpresentioncontroller = actionSheetController.popoverPresentationController{
                currentPopoverpresentioncontroller.sourceView = sender as? UIView
                currentPopoverpresentioncontroller.sourceRect = (sender as AnyObject).bounds
                self.present(actionSheetController, animated: true, completion: nil)
            }
        }else{
            self.present(actionSheetController, animated: true, completion: nil)
        }
    }
    
}

extension UIViewController {
    func reloadViewFromNib() {
        let parent = view.superview
        view.removeFromSuperview()
        view = nil
        parent?.addSubview(view) // This line causes the view to be reloaded
    }
}

extension GroupListViewController : UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        
        groupRequest = GroupsRequest.GroupsRequestBuilder(limit: 20).set(searchKeyword: searchController.searchBar.text!).build()
        
        groupRequest.fetchNext(onSuccess: { (groupList) in
            
            self.filteredGroupList = groupList
            DispatchQueue.main.async(execute: { self.groupTableView.reloadData()
            })
        }) { (exception) in
            DispatchQueue.main.async(execute: {
                self.view.makeToast("\(String(describing: exception!.errorDescription))")
            })
            CometChatLog.print(items:exception?.errorDescription as Any)
        }
    }
}

extension GroupListViewController : CometChatGroupDelegate {
    
    func onGroupMemberJoined(action: ActionMessage, joinedUser: User, joinedGroup: Group) {
        if let row = self.joinedChatRoomList.firstIndex(where: {$0.guid == action.receiverUid}) {
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                let cell = self.groupTableView.cellForRow(at: indexPath) as! GroupTableViewCell
                if let actionMessageText:String = action.message {
                    cell.groupParticipants.text = actionMessageText
                    cell.groupParticipants.font = UIFont.italicSystemFont(ofSize: 12.0)
                    cell.groupParticipants.textColor = UIColor.init(hexFromString: "434343")
                    cell.reloadInputViews()
                }
            }
        }
    }
    
    func onGroupMemberLeft(action: ActionMessage, leftUser: User, leftGroup: Group) {
        if let row = self.joinedChatRoomList.firstIndex(where: {$0.guid == action.receiverUid}) {
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                let cell = self.groupTableView.cellForRow(at: indexPath) as! GroupTableViewCell
                if let actionMessageText:String = action.message {
                    cell.groupParticipants.text = actionMessageText
                    cell.groupParticipants.font = UIFont.italicSystemFont(ofSize: 12.0)
                    cell.groupParticipants.textColor = UIColor.init(hexFromString: "434343")
                    cell.reloadInputViews()
                }
            }
        }
    }
    
    func onGroupMemberKicked(action: ActionMessage, kickedUser: User, kickedBy: User, kickedFrom: Group) {
        if let row = self.joinedChatRoomList.firstIndex(where: {$0.guid == action.receiverUid}) {
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                let cell = self.groupTableView.cellForRow(at: indexPath) as! GroupTableViewCell
                if let actionMessageText:String = action.message {
                    cell.groupParticipants.text = actionMessageText
                    cell.groupParticipants.font = UIFont.italicSystemFont(ofSize: 12.0)
                    cell.groupParticipants.textColor = UIColor.init(hexFromString: "434343")
                    cell.reloadInputViews()
                }
            }
        }
    }
    
    func onGroupMemberBanned(action: ActionMessage, bannedUser: User, bannedBy: User, bannedFrom: Group) {
        if let row = self.joinedChatRoomList.firstIndex(where: {$0.guid == action.receiverUid}) {
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                let cell = self.groupTableView.cellForRow(at: indexPath) as! GroupTableViewCell
                if let actionMessageText:String = action.message {
                    cell.groupParticipants.text = actionMessageText
                    cell.groupParticipants.font = UIFont.italicSystemFont(ofSize: 12.0)
                    cell.groupParticipants.textColor = UIColor.init(hexFromString: "434343")
                    cell.reloadInputViews()
                }
            }
        }
    }
    
    func onGroupMemberUnbanned(action: ActionMessage, unbannedUser: User, unbannedBy: User, unbannedFrom: Group) {
        if let row = self.joinedChatRoomList.firstIndex(where: {$0.guid == action.receiverUid}) {
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                let cell = self.groupTableView.cellForRow(at: indexPath) as! GroupTableViewCell
                if let actionMessageText:String = action.message {
                    cell.groupParticipants.text = actionMessageText
                    cell.groupParticipants.font = UIFont.italicSystemFont(ofSize: 12.0)
                    cell.groupParticipants.textColor = UIColor.init(hexFromString: "434343")
                    cell.reloadInputViews()
                }
            }
        }
    }
    
    func onGroupMemberScopeChanged(action: ActionMessage, scopeChangeduser: User, scopeChangedBy: User, scopeChangedTo: String, scopeChangedFrom: String, group: Group) {
        if let row = self.joinedChatRoomList.firstIndex(where: {$0.guid == action.receiverUid}) {
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                let cell = self.groupTableView.cellForRow(at: indexPath) as! GroupTableViewCell
                if let actionMessageText:String = action.message {
                    cell.groupParticipants.text = actionMessageText
                    cell.groupParticipants.font = UIFont.italicSystemFont(ofSize: 12.0)
                    cell.groupParticipants.textColor = UIColor.init(hexFromString: "434343")
                    cell.reloadInputViews()
                }
            }
        }
    }
    
    
    func onMemberAddedToGroup(action: ActionMessage, addedBy: User, addedUser: User, addedTo: Group) {
        if let row = self.joinedChatRoomList.firstIndex(where: {$0.guid == action.receiverUid}) {
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                let cell = self.groupTableView.cellForRow(at: indexPath) as! GroupTableViewCell
                if let actionMessageText:String = action.message {
                    cell.groupParticipants.text = actionMessageText
                    cell.groupParticipants.font = UIFont.italicSystemFont(ofSize: 12.0)
                    cell.groupParticipants.textColor = UIColor.init(hexFromString: "434343")
                    cell.reloadInputViews()
                }
            }
        }else{
            self.refreshGroupList()
        }
    }
    
}

///////////////////////////////////////////////////////////////////////////////////////////////


extension GroupListViewController : CometChatMessageDelegate {
    
    func onTextMessageReceived(textMessage: TextMessage) {
        if let row = self.joinedChatRoomList.firstIndex(where: {$0.guid == textMessage.receiverUid}) {
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                let cell = self.groupTableView.cellForRow(at: indexPath) as! GroupTableViewCell
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
        if let row = self.joinedChatRoomList.firstIndex(where: {$0.guid == mediaMessage.receiverUid}) {
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                let cell = self.groupTableView.cellForRow(at: indexPath) as! GroupTableViewCell
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
        if let row = self.joinedChatRoomList.firstIndex(where: {$0.guid == customMessage.receiverUid}) {
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                let cell = self.groupTableView.cellForRow(at: indexPath) as! GroupTableViewCell
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
        if let row = self.joinedChatRoomList.firstIndex(where: {$0.guid == typingDetails.receiverID}) {
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                let cell = self.groupTableView.cellForRow(at: indexPath) as! GroupTableViewCell
                let user = typingDetails.sender?.name
                cell.groupParticipants.text = NSLocalizedString("\(user!) is Typing...", comment: "")
                cell.groupParticipants.textColor = UIColor.init(hexFromString: "9ACD32")
                cell.groupParticipants.font = UIFont.italicSystemFont(ofSize: 15.0)
                cell.reloadInputViews()
            }
        }
    }
    
    func onTypingEnded(_ typingDetails: TypingIndicator) {
        
        if let row = self.joinedChatRoomList.firstIndex(where: {$0.guid == typingDetails.receiverID}) {
            let indexPath = IndexPath(row: row, section: 0)
            DispatchQueue.main.async {
                let cell = self.groupTableView.cellForRow(at: indexPath) as! GroupTableViewCell
                cell.groupParticipants.text = ""
                cell.groupParticipants.textColor = UIColor.init(hexFromString: "9ACD32")
                cell.groupParticipants.font = UIFont.italicSystemFont(ofSize: 15.0)
                cell.reloadInputViews()
            }
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////

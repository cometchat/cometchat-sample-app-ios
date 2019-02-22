//
//  GroupListViewController.swift
//  CometChatUI
//
//  Created by pushpsen airekar on 18/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit
import CometChatPro

class GroupListViewController: UIViewController , UITableViewDelegate , UITableViewDataSource, UISearchBarDelegate{

    //Outlets Declarations
    @IBOutlet weak var groupTableView: UITableView!
    @IBOutlet weak var notifyButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var leftPadding: NSLayoutConstraint!
    @IBOutlet weak var rightPadding: NSLayoutConstraint!
    
    //Variable Declarations
    var nameArray:[String]!
    var imageArray:[UIImage]!
    var statusArray:[String]!
    var groupArray:Array<Group>!
    var joinedChatRoomList = [Group]()
    var othersChatRoomList = [Group]()
    var  groupRequest = GroupsRequest.GroupsRequestBuilder(limit: 10).build()
    var searchController:UISearchController!
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Function Calling
        self.fetchGroupList()
        
        groupTableView.reloadData()
        
        //Assigning Delegates
        groupTableView.delegate = self
        groupTableView.dataSource = self
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        var isNewGroup:String!
        if((UserDefaults.standard.value(forKey: "newGroupCreated")) != nil){
            isNewGroup = (UserDefaults.standard.value(forKey: "newGroupCreated") as! String)
        }else{
          isNewGroup = "0"
        }
        if(isNewGroup == "1"){
           print("Calling froup isNewGroup")
            self.fetchGroupList()
            UserDefaults.standard.removeObject(forKey: "newGroupCreated")
        }

        //Calling Function
        self.handleGroupListVCAppearance()
        
        
    }
    
    func fetchGroupList(){

        //This method fetches the grouplist from the server

        groupRequest.fetchNext(onSuccess: { (groupList) in
            
            for group in groupList {
                if(group.hasJoined == true){
                    self.joinedChatRoomList.append(group)
                    print("joinedChatRoomList is:",self.joinedChatRoomList)
                }else{
                    self.othersChatRoomList.append(group)
                    print("othersChatRoomList is:",self.othersChatRoomList)
                }
            }
            DispatchQueue.main.async(execute: { self.groupTableView.reloadData() })
            
        }) { (exception) in
            
            print(exception?.errorDescription as Any)
        }
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
        navigationItem.title = "Groups"
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
        
        // NavigationBar Buttons Appearance
        
       // notifyButton.setImage(UIImage(named: "bell.png"), for: .normal)
        createButton.setImage(UIImage(named: "new.png"), for: .normal)
        moreButton.setImage(UIImage(named: "more_vertical.png"), for: .normal)
        
        //notifyButton.tintColor = UIColor(hexFromString: UIAppearance.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        createButton.tintColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        moreButton.tintColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        
        // SearchBar Apperance
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_TITLE_COLOR)
        
        if(UIAppearanceColor.SEARCH_BAR_STYLE_LIGHT_CONTENT == true){
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(white: 1, alpha: 0.5)])
        }else{
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(white: 0, alpha: 0.5)])
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
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            
        }
        
    }
    
//TableView Methods:
    
    //numberOfSections -->
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return 2
    }
    
    //numberOfRowsInSection -->
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0) {
            return joinedChatRoomList.count
        } else {
            return othersChatRoomList.count
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
        var group:Group!
        
        if(indexPath.section == 0){
            group = joinedChatRoomList[indexPath.row]
            print("joinedChatRoomList\(group.name)")
        }else{
            group = othersChatRoomList[indexPath.row]
            print("othersChatRoomList\(group.name)")
        }
        
        cell.groupName.text = group.name
        let groupIconURL:String = group.icon ?? "null"
        cell.groupAvtar.downloaded(from: groupIconURL)
        cell.groupParticipants.text = group.groupDescription
        cell.UID = group.guid
        cell.groupType = group.groupType.rawValue
        print("GUID of group\(group.guid)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell:GroupTableViewCell = tableView.cellForRow(at: indexPath) as! GroupTableViewCell
        
         if(indexPath.section != 0){
            
            CometChat.joinGroup(GUID: selectedCell.UID, groupType: .public, password: nil, onSuccess: { (success) in
                DispatchQueue.main.async{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let oneOnOneChatViewController = storyboard.instantiateViewController(withIdentifier: "oneOnOneChatViewController") as! OneOnOneChatViewController
                    // oneOnOneChatViewController.buddyStatusString = selectedCell.groupName.text
                    oneOnOneChatViewController.buddyAvtar = selectedCell.groupAvtar.image
                    oneOnOneChatViewController.buddyNameString = selectedCell.groupName.text
                    oneOnOneChatViewController.buddyUID = selectedCell.UID!
                    oneOnOneChatViewController.isGroup = "1"
                    self.navigationController?.pushViewController(oneOnOneChatViewController, animated: true)
                }
            }) { (error) in
                print("Failed to join group")
            }
         }else{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let oneOnOneChatViewController = storyboard.instantiateViewController(withIdentifier: "oneOnOneChatViewController") as! OneOnOneChatViewController
            // oneOnOneChatViewController.buddyStatusString = selectedCell.groupName.text
            oneOnOneChatViewController.buddyAvtar = selectedCell.groupAvtar.image
            oneOnOneChatViewController.buddyNameString = selectedCell.groupName.text
            print("uid of the group is \(String(describing: selectedCell.UID!))")
            oneOnOneChatViewController.buddyUID = selectedCell.UID
            oneOnOneChatViewController.isGroup = "1"
            self.navigationController?.pushViewController(oneOnOneChatViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        if(indexPath.row == (joinedChatRoomList.count + othersChatRoomList.count) - 2){
             self.fetchGroupList()
        }
}

    //titleForHeaderInSection indexPath -->
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if(section == 0) {
            return "Joined Groups"
        }
        else {
            return "Other Groups"
        }
    }
    
    //heightForRowAt indexPath -->
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    //trailingSwipeActionsConfigurationForRowAt indexPath -->
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action =  UIContextualAction(style: .normal, title: "Files", handler: { (action,view,completionHandler ) in
            //do stuff
            completionHandler(true)
        })
        action.image = UIImage(named: "delete.png")
        action.backgroundColor = .red
        
        
        let deleteAction =  UIContextualAction(style: .normal, title: "Files1", handler: { (deleteAction,view,completionHandler ) in
            //do stuff
            completionHandler(true)
        })
        deleteAction.image = UIImage(named: "block.png")
        deleteAction.backgroundColor = .orange
        
        let confrigation = UISwipeActionsConfiguration(actions: [action])
        
        return confrigation
    }
    
    //leadingSwipeActionsConfigurationForRowAt indexPath -->
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action =  UIContextualAction(style: .normal, title: "Files", handler: { (action,view,completionHandler ) in
            //do stuff
            completionHandler(true)
        })
        action.image = UIImage(named: "video_call.png")
        action.backgroundColor = .green
        
        
        let deleteAction =  UIContextualAction(style: .normal, title: "Files1", handler: { (deleteAction,view,completionHandler ) in
            //do stuff
            completionHandler(true)
        })
        deleteAction.image = UIImage(named: "audio_call.png")
        deleteAction.backgroundColor = .blue
        
        let confrigation = UISwipeActionsConfiguration(actions: [action,deleteAction])
        
        return confrigation
    }
    
    //Announcement Button Pressed
    @IBAction func announcementPressed(_ sender: Any) {
        
      
        
    }
    
    //MoreSettinngs  Button Pressed
    @IBAction func morePressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CCWebviewController = storyboard.instantiateViewController(withIdentifier: "moreSettingsViewController") as! MoreSettingsViewController
        navigationController?.pushViewController(CCWebviewController, animated: true)
        CCWebviewController.title = "More"
        CCWebviewController.hidesBottomBarWhenPushed = true
    }
    
    //CreateGroup Button Pressed
    @IBAction func createGroupPressed(_ sender: Any) {
        
    let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let createGroupAction: UIAlertAction = UIAlertAction(title: "Create Group", style: .default) { action -> Void in
               
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createGroupcontroller = storyboard.instantiateViewController(withIdentifier: "createGroupcontroller") as! CreateGroupcontroller
        self.navigationController?.pushViewController(createGroupcontroller, animated: false)
        createGroupcontroller.title = "Create Group"
        createGroupcontroller.hidesBottomBarWhenPushed = true
        }
        createGroupAction.setValue(UIImage(named: "createGroup.png"), forKey: "image")
        
    let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                print("Cancel")
        }
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        actionSheetController.addAction(createGroupAction)
        actionSheetController.addAction(cancelAction)
        present(actionSheetController, animated: true, completion: nil)
    }
    
    

}

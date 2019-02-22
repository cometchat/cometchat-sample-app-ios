//
//  OneOnOneListViewController.swift
//  CometChatUI
//
//  Created by pushpsen airekar on 18/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit
import CometChatPro
class OneOnOneListViewController: UIViewController,UITableViewDelegate , UITableViewDataSource , CometChatUserDelegate, UISearchBarDelegate{
    
    func onUserOnline(user: User) {
    
    }
    
    func onUserOffline(user: User) {

    }
    
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
    var nameArray:[String]!
    var imageArray:[UIImage]!
    var statusArray:[String]!
    var usersArray = [User]()
    var userRequest = UsersRequest.UsersRequestBuilder(limit: 10).build()
    var buddyData:User!
    let data:NSData! = nil
    var url:NSURL!
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Function Calling
        self.fetchUsersList()
        CometChat.userdelegate = self
        oneOneOneTableView.reloadData()
        
        //Assigning Delegates
        oneOneOneTableView.delegate = self
        oneOneOneTableView.dataSource = self
       // CometChat.userdelegate = self
   
    }
    
    override func viewWillAppear(_ animated: Bool) {

        //Function Calling
        self.handleContactListVCAppearance()
    }

    func fetchUsersList(){
        // This Method fetch the users from the Server.
        userRequest.fetchNext(onSuccess: { (userList) in
            
            for user in userList {
                print("Im in users: \(String(describing: userList))")
                self.usersArray.append(user)
            }
            DispatchQueue.main.async(execute: { self.oneOneOneTableView.reloadData() })
        }) { (exception) in
            
             print(exception?.errorDescription as Any)
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
        
        navigationItem.title = "Contacts"
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
        moreButton.setImage(UIImage(named: "more_vertical.png"), for: .normal)
        
       // notifyButton.tintColor = UIColor(hexFromString: UIAppearance.NAVIGATION_BAR_BUTTON_TINT_COLOR)
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
       return usersArray.count
       // return 0
    }
    
    //cellForRowAt indexPath :
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        buddyData = self.usersArray[indexPath.row]
    
        let cell = oneOneOneTableView.dequeueReusableCell(withIdentifier: "oneOnOneTableViewCell") as! OneOnOneTableViewCell
        
        //User Name:
        cell.buddyName.text = buddyData.name
        
         //User Status:
        cell.buddyStatus.text = buddyData.status
        cell.UID = buddyData.uid
        //User status Icon:
        if(buddyData.status == "offline"){
            cell.buddyStatusIcon.backgroundColor = UIColor.init(hexFromString: "808080")
        }else if(buddyData.status == "busy"){
             cell.buddyStatusIcon.backgroundColor = UIColor.init(hexFromString: "E45163")
        }else if(buddyData.status == "away"){
             cell.buddyStatusIcon.backgroundColor = UIColor.init(hexFromString: "EBC04F")
        }else if(buddyData.status == "online"){
             cell.buddyStatusIcon.backgroundColor = UIColor.init(hexFromString: "4AB680")
        }
        
        // User Avtar :
        
//        url = NSURL(string: buddyData.avatar as! String)
//
//        DispatchQueue.global().async {
//            let data = try? Data(contentsOf: self.url! as URL) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//            DispatchQueue.main.async {
//                cell.buddyAvtar.image = UIImage(data: data!)
//            }
//        }
        
     cell.buddyAvtar.downloaded(from: buddyData.avatar ?? "")
        
        return cell
    }
    
    //willDisplaycell
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if(indexPath.row == usersArray.count - 5){
            self.fetchUsersList()
        }
    }
    

    //didSelectRowAt indexPath
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

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
        })
        action.image = UIImage(named: "delete.png")
        action.backgroundColor = .red
        
        let deleteAction =  UIContextualAction(style: .normal, title: "Files1", handler: { (deleteAction,view,completionHandler ) in
            completionHandler(true)
        })
        
        deleteAction.image = UIImage(named: "block.png")
        deleteAction.backgroundColor = .orange
        
        let confrigation = UISwipeActionsConfiguration(actions: [action,deleteAction])
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
            CallingViewController.isAudioCall = false
            CallingViewController.isIncoming = false
            CallingViewController.userAvtarImage = selectedCell.buddyAvtar.image
            CallingViewController.userNameString = selectedCell.buddyName.text
            CallingViewController.callingString = "Calling ..."
            CallingViewController.callerUID = selectedCell.UID
            self.present(CallingViewController, animated: true, completion: nil)
            
        })
        videoCall.image = UIImage(named: "video_call.png")
        videoCall.backgroundColor = .green
        
        let audioCall =  UIContextualAction(style: .normal, title: "Files1", handler: { (deleteAction,view,completionHandler ) in
            completionHandler(true)
            CallingViewController.isAudioCall = true
            CallingViewController.isIncoming = false
            CallingViewController.userAvtarImage = selectedCell.buddyAvtar.image
            CallingViewController.userNameString = selectedCell.buddyName.text
            CallingViewController.callingString = "Calling ..."
            CallingViewController.callerUID = selectedCell.UID
            self.present(CallingViewController, animated: true, completion: nil)
        })
        audioCall.image = UIImage(named: "audio_call.png")
        audioCall.backgroundColor = .blue
        
        let confrigation = UISwipeActionsConfiguration(actions: [videoCall,audioCall])
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
        CCMoreViewController.title = "More"
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

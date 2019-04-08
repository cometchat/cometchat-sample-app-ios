//
//  MoreSettingsViewController.swift
//  CometChatUI
//
//  Created by Pushpsen Airekar on 19/11/18.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.
//

import UIKit
import CometChatPro

class MoreSettingsCell {
    
    static let VIEW_PROFILE_CELL = 0
    static let BOTS_CELL = 1
    static let CHAT_SETTINGS_CELL = 2
    static let NOTIFICATION_CELL = 3
    static let BLOCKED_USER_CELL = 4
    static let GAMES_CELL = 5
    static let LOGOUT_CELL = 6
    
}

class MoreSettingsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    //Outlets Declarations
    
    
    @IBOutlet weak var moreSettingsTableView: UITableView!
    //Variable Declarations
    var SettingsItems:[Int]!
    var buddyAvtar:UIImage!
    var buddyNameString:String!
    var buddyStatusString:String!
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        SettingsItems = []
        self.handleSettingsItems()
        
        CometChatLog.print(items: "LoggedIn: \(String(describing: UserDefaults.standard.object(forKey: "loggedInUserInfo")))")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Function Calling
        self.handleMoreSettingsVCAppearance()
    }
    //This method handles the cell to be added for MoreSettingsVC
    func handleSettingsItems()
    {
        SettingsItems.append(MoreSettingsCell.VIEW_PROFILE_CELL)
        //SettingsItems.append(MoreSettingsCell.BOTS_CELL)
        SettingsItems.append(MoreSettingsCell.CHAT_SETTINGS_CELL)
        SettingsItems.append(MoreSettingsCell.NOTIFICATION_CELL)
        SettingsItems.append(MoreSettingsCell.BLOCKED_USER_CELL)
        SettingsItems.append(MoreSettingsCell.GAMES_CELL)
        SettingsItems.append(MoreSettingsCell.LOGOUT_CELL)
    }
    
    //This method handles the UI customization for MoreSettingsVC
    func  handleMoreSettingsVCAppearance(){
        // ViewController Appearance
        
        moreSettingsTableView.tableFooterView = UIView()
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moreSettingsCell", for: indexPath) as! MoreSettingTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.settingsLogo.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
        switch SettingsItems[indexPath.row]
        {
        case MoreSettingsCell.VIEW_PROFILE_CELL:
            cell.settingsLabel.text = "View Profile"
            let image = UIImage(named: "view_profile")!.withRenderingMode(.alwaysTemplate)
            cell.settingsLogo.image = image
        case MoreSettingsCell.BOTS_CELL:
            cell.settingsLabel.text = "Bots"
            let image = UIImage(named: "video_call")!.withRenderingMode(.alwaysTemplate)
            cell.settingsLogo.image = image
        case MoreSettingsCell.CHAT_SETTINGS_CELL:
            cell.settingsLabel.text = "Chat Settings"
            let image = UIImage(named: "chat_settings")!.withRenderingMode(.alwaysTemplate)
            cell.settingsLogo.image = image
        case MoreSettingsCell.NOTIFICATION_CELL:
            cell.settingsLabel.text = "Notification"
            let image = UIImage(named: "notification")!.withRenderingMode(.alwaysTemplate)
            cell.settingsLogo.image = image
        case MoreSettingsCell.BLOCKED_USER_CELL:
            cell.settingsLabel.text = "Blocked User"
            let image = UIImage(named: "block_user")!.withRenderingMode(.alwaysTemplate)
            cell.settingsLogo.image = image
        case MoreSettingsCell.GAMES_CELL:
            cell.settingsLabel.text = "Games"
            let image = UIImage(named: "games")!.withRenderingMode(.alwaysTemplate)
            cell.settingsLogo.image = image
        case MoreSettingsCell.LOGOUT_CELL:
            cell.settingsLabel.text = "Logout"
            let image = UIImage(named: "logout")!.withRenderingMode(.alwaysTemplate)
            cell.settingsLogo.image = image
            
            
        default:
            cell.settingsLabel.text = ""
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsItems.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        moreSettingsTableView.deselectRow(at: indexPath, animated: true)
        switch SettingsItems[indexPath.row]
        {
        case MoreSettingsCell.VIEW_PROFILE_CELL:
            self.viewProfile()
            
        case MoreSettingsCell.BOTS_CELL:
            self.viewBots()
            
        case MoreSettingsCell.CHAT_SETTINGS_CELL:
            self.viewChatSettings()
            
        case MoreSettingsCell.NOTIFICATION_CELL:
            self.viewNotification()
            
        case MoreSettingsCell.BLOCKED_USER_CELL:
            self.viewBlockedUser()
            
        case MoreSettingsCell.GAMES_CELL:
            self.viewGames()
        case MoreSettingsCell.LOGOUT_CELL:
            self.onLogout()
            
            
        default:
            self.defaultCase()
            
        }
        
    }
    func defaultCase()
    {
    }
    
    func viewProfile()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let UserProfileViewController = storyboard.instantiateViewController(withIdentifier: "userProfileViewController") as! UserProfileViewController
        navigationController?.pushViewController(UserProfileViewController, animated: true)
        UserProfileViewController.title = "View Profile"
        UserProfileViewController.isDisplayType = "MoreSettingViewProfile"
        UserProfileViewController.hidesBottomBarWhenPushed = true
        
    }
    func viewBots()
    {
        DispatchQueue.main.async(execute: { self.view.makeToast("This feature has not been added yet")})
    }
    func viewChatSettings()
    {
        DispatchQueue.main.async(execute: { self.view.makeToast("This feature has not been added yet")})
    }
    func viewNotification()
    {
         DispatchQueue.main.async(execute: { self.view.makeToast("This feature has not been added yet")})
    }
    func viewBlockedUser()
    {
         DispatchQueue.main.async(execute: { self.view.makeToast("This feature has not been added yet")})
    }
    func viewGames()
    {
         DispatchQueue.main.async(execute: { self.view.makeToast("This feature has not been added yet")})
    }
    func onLogout()
    {
        
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to Logout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                
                CometChat.logout(onSuccess: { (sucess) in
                    CometChat.stopServices()
                    UserDefaults.standard.removeObject(forKey: "LoggedInUserUID")
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let CustomLaunchViewController = storyBoard.instantiateViewController(withIdentifier: "customLaunchViewController") as! CustomLaunchViewController
                    self.present(CustomLaunchViewController, animated:true, completion:nil)
                }, onError: { (error) in
                     DispatchQueue.main.async(execute: { self.view.makeToast("Fail to logout at this moment.")})
                })
                
            case .cancel: break
                
            case .destructive: break
            }}))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

}


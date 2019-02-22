//
//  RecentListViewController.swift
//  CometChatUI
//
//  Created by pushpsen airekar on 18/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit

class RecentListViewController: UIViewController ,UISearchControllerDelegate {
    
    //Outlets Declarations
    @IBOutlet weak var recentTableView: UITableView!
    @IBOutlet weak var notifyButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var leftPadding: NSLayoutConstraint!
    @IBOutlet weak var rightPadding: NSLayoutConstraint!
    
    
    //Variable Declarations
    private var shadowImageView: UIImageView?
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        print("i m in RecentListViewController")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Function Calling
        self.handleRecentListVCAppearance()
    }
    

    //This method handles the UI customization for RecentListVC
     func  handleRecentListVCAppearance(){

        // ViewController Appearance
         view.backgroundColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_COLOR)
        
        //TableView Appearance
        self.recentTableView.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        self.leftPadding.constant = CGFloat(UIAppearanceSize.Padding)
        self.rightPadding.constant = CGFloat(UIAppearanceSize.Padding)
        
        switch AppAppearance{
        case .AzureRadiance: self.recentTableView.separatorStyle = .none
        case .MountainMeadow:break
        case .PersianBlue:break
        case .Custom:break
        }
       
//        // NavigationBar Appearance
        navigationItem.title = "Recent"
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
//
//         // NavigationBar Buttons Appearance
//
         notifyButton.setImage(UIImage(named: "bell.png"), for: .normal)
         moreButton.setImage(UIImage(named: "more_vertical.png"), for: .normal)

         notifyButton.tintColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
         moreButton.tintColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
    }
    
    
    @IBAction func announcementPressed(_ sender: Any) {
        
        
    }
    
    @IBAction func morePressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CCWebviewController = storyboard.instantiateViewController(withIdentifier: "moreSettingsViewController") as! MoreSettingsViewController
        navigationController?.pushViewController(CCWebviewController, animated: false)
        CCWebviewController.title = "More"
        CCWebviewController.hidesBottomBarWhenPushed = true
    }
    

    

}

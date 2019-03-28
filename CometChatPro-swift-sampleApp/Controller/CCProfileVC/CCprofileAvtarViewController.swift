//
//  CCprofileAvtarViewController.swift
//  CometChatUI
//
//  Created by Admin1 on 19/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit

class CCprofileAvtarViewController: UIViewController {
    
    //Outlets Declarations
    @IBOutlet weak var profileAvtarView: UIImageView!
    
    //Variable Declarations
    var profileAvtar:UIImage!
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Function Calling
        self.handleCCProfileAvtarVCAppearance()
    }
    
    //This method handles the UI customization for WebVC
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
        
        // Profile Avtar
        profileAvtarView.image = profileAvtar
        
    }
    
    
}

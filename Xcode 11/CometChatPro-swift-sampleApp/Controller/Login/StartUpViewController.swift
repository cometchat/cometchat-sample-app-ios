//
//  ViewController.swift
//  CometChatUI
//
//  Created by Pushpsen Airekar on 15/11/18.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.
//

import UIKit


class startUpViewController: UIViewController,CCBottomSlideDelegate, UITextFieldDelegate{

    // Outlets Declarations
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var CClogoTop: NSLayoutConstraint!
    @IBOutlet weak var cometChatLogo: UIImageView!
    
    // Variable Declarations
    var bottomController:CCBottomSlideController?
    var logoImage: UIImage!
    var logoImageView:UIImageView!
    let modelName = UIDevice.modelName
    var isFirstTime:Bool!

    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Function Calling
        
        self.hideKeyboardWhenTappedAround()
        self.handleStartUpVCApperance()
        self.handleBottomView()
        self.handleLogoDistance()
        
    }
    
    func handleStartUpVCApperance() {
          if((UserDefaults.standard.object(forKey: "LoggedInUserUID")) == nil){
            bottomView.isHidden = false
        }
        self.view.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.BACKGROUND_COLOR)
        self.cometChatLogo.tintColor = UIColor.red
        cometChatLogo.image = cometChatLogo.image!.withRenderingMode(.alwaysTemplate)
        cometChatLogo.tintColor = UIColor.init(hexFromString: UIAppearanceColor.LOGO_TINT_COLOR)
    }
    
    
    func handleBottomView(){
        
    // This function deals with the handling of the Swipeable view according with the specific device size.
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        
       
        
        if(modelName == "iPhone 5" || modelName == "iPhone 5s" || modelName == "iPhone 5c" || modelName == "iPhone SE" ){
             bottomController = CCBottomSlideController(parent: view, bottomView: bottomView, tabController: self.tabBarController!, navController: self.navigationController, visibleHeight: 350)
            bottomController?.setAnchorPoint(anchor: 0.78)
        }else if (modelName == "iPhone 6 Plus" || modelName == "iPhone 6s Plus" || modelName == "iPhone 7 Plus" || modelName == "iPhone 8 Plus"){
             bottomController = CCBottomSlideController(parent: view, bottomView: bottomView, tabController: self.tabBarController!, navController: self.navigationController, visibleHeight: 350)
            bottomController?.setAnchorPoint(anchor: 0.6)
        }else if(modelName == "iPhone XS Max"){
             bottomController = CCBottomSlideController(parent: view, bottomView: bottomView, tabController: self.tabBarController!, navController: self.navigationController, visibleHeight: 350)
            bottomController?.setAnchorPoint(anchor: 0.6)
        }else if (modelName == "iPhone X" || modelName == "iPhone XS" || modelName == "iPhone XR"){
             bottomController = CCBottomSlideController(parent: view, bottomView: bottomView, tabController: self.tabBarController!, navController: self.navigationController, visibleHeight: 350)
            bottomController?.setAnchorPoint(anchor: 0.6)
        }else if modelName.contains("iPad"){
             bottomController = CCBottomSlideController(parent: view, bottomView: bottomView, tabController: self.tabBarController!, navController: self.navigationController, visibleHeight: 600)
            bottomController?.setAnchorPoint(anchor: 0.68)
        }else{
            bottomController = CCBottomSlideController(parent: view, bottomView: bottomView, tabController: self.tabBarController!, navController: self.navigationController, visibleHeight: 350)
            bottomController?.setAnchorPoint(anchor: 0.68)
        }
        
        bottomController?.delegate = self
        bottomController?.onPanelExpanded = {}
        bottomController?.onPanelCollapsed = {}
        bottomController?.onPanelMoved = { offset in }
    }
    
  
    
    func handleLogoDistance(){
        
    //This function deals with the distance of the CometChatLogo accroding with the particular device size.
        if(modelName == "iPhone 5" || modelName == "iPhone 5s" || modelName == "iPhone 5c" || modelName == "iPhone SE" ){
            
            CClogoTop.constant = 4
            
        }else if (modelName == "iPhone 6 Plus" || modelName == "iPhone 6s Plus" || modelName == "iPhone 7 Plus" || modelName == "iPhone 8 Plus"){
            
            CClogoTop.constant = 88
        }else if(modelName == "iPhone XS Max"){
            
            CClogoTop.constant = 144
        }else if (modelName == "iPhone X" || modelName == "iPhone XS") {
            CClogoTop.constant = 102
        }else if(modelName == "iPhone XR"){
            CClogoTop.constant = 144
        }else if(modelName == "iPad Pro (12.9-inch) (2nd generation)"){
            CClogoTop.constant = 200
        }else{
            CClogoTop.constant = 54
            
        }
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func didPanelCollapse() {
    }
    
    func didPanelExpand() {
        bottomController?.anchorPanel()
       
    }
    
    func didPanelAnchor() {
    }
    
    func didPanelMove(panelOffset: CGFloat) {
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        bottomController?.viewWillTransition(to: size, with: coordinator)
    }
}




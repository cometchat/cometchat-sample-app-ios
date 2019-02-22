//
//  ViewController.swift
//  CometChatUI
//
//  Created by Admin1 on 15/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit

class startUpViewController: UIViewController,CCBottomSlideDelegate, UITextFieldDelegate{

    // Outlets Declarations
    @IBOutlet weak var swipeUpLbel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var CClogoTop: NSLayoutConstraint!
    @IBOutlet weak var activity: CCActivityIndicator!
    @IBOutlet weak var cometChatLogo: UIImageView!
    
    // Variable Declarations
    var bottomController:CCBottomSlideController?
    var logoImage: UIImage!
    var logoImageView:UIImageView!
    let modelName = UIDevice.modelName

    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        //Function Calling
        self.hideKeyboardWhenTappedAround()
        self.handleStartUpVCApperance()
        self.handleBottomView()
        self.handleAnimations()
        self.handleLogoDistance()
    }
    
    func handleStartUpVCApperance() {
        self.view.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.BACKGROUND_COLOR)
        self.cometChatLogo.tintColor = UIColor.red
        cometChatLogo.image = cometChatLogo.image!.withRenderingMode(.alwaysTemplate)
        cometChatLogo.tintColor = UIColor.init(hexFromString: UIAppearanceColor.LOGO_TINT_COLOR)
        swipeUpLbel.textColor = UIColor.init(hexFromString: UIAppearanceColor.LOGO_TINT_COLOR)
        
    }
    
    
    func handleBottomView(){
        
    // This function deals with the handling of the Swipeable view according with the specific device size.
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        
        bottomController = CCBottomSlideController(parent: view, bottomView: bottomView, tabController: self.tabBarController!, navController: self.navigationController, visibleHeight: 5)
        
        if(modelName == "iPhone 5" || modelName == "iPhone 5s" || modelName == "iPhone 5c" || modelName == "iPhone SE" ){
            bottomController?.setAnchorPoint(anchor: 0.78)
        }else if (modelName == "iPhone 6 Plus" || modelName == "iPhone 6s Plus" || modelName == "iPhone 7 Plus" || modelName == "iPhone 8 Plus"){
            bottomController?.setAnchorPoint(anchor: 0.6)
        }else if(modelName == "iPhone XS Max"){
            bottomController?.setAnchorPoint(anchor: 0.6)
        }else if (modelName == "iPhone X" || modelName == "iPhone XS" || modelName == "iPhone XR"){
            bottomController?.setAnchorPoint(anchor: 0.6)
        }else{
            bottomController?.setAnchorPoint(anchor: 0.68)
        }
        
        bottomController?.delegate = self
        
        bottomController?.onPanelExpanded = {
            print("Panel Expanded in closure")
        }
        
        bottomController?.onPanelCollapsed = {
            print("Panel Collapsed in closure")
        }
        
        bottomController?.onPanelMoved = { offset in
            print("Panel moved in closure " + offset.description)
        }
        
        //Uncomment to specify top margin on expanded panel
        //bottomController?.setExpandedTopMargin(pixels: 30)
        
        if bottomController?.currentState == .collapsed
        {
            //do anything, i don't care
        }
    }
    
    
    func handleAnimations(){
        
    // This function deals with the handling of the animations and transitions  of view .
        swipeUpLbel.isHidden = true
       activity.stopAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() ) { // change 2 to desired number of seconds
//            self.activity.stopAnimating()
            self.swipeUpLbel.isHidden = false
            //self.bottomView.shake()
            
            UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 2.0, initialSpringVelocity: 2.0, options: .curveEaseInOut, animations: {
                
                let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
                animation.duration = 3.0
                animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
                self.bottomView.layer.add(animation, forKey: "shake")
                self.swipeUpLbel.layer.add(animation, forKey: "shake")
            }, completion: {
                (value: Bool) in
                //self.swipeUpLbel.isHidden = true
            })
            
        }
        
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
            print("I'm here")
            CClogoTop.constant = 144
        }else if(modelName == "iPad Pro (12.9-inch) (2nd generation)"){
            print("I'm here")
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
         print("didPanelCollapse")
    }
    
    func didPanelExpand() {
         print("didPanelExpand")
        bottomController?.anchorPanel()
       
    }
    
    func didPanelAnchor() {
         print("didPanelAnchor")
    }
    
    func didPanelMove(panelOffset: CGFloat) {
        print("didPanelMove : \(panelOffset)")
        self.swipeUpLbel.isHidden = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        bottomController?.viewWillTransition(to: size, with: coordinator)
    }
}


//
//  ViewController.swift
//  CometChatUI
//
//  Created by Pushpsen Airekar on 15/11/18.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.
//

import UIKit
import SPPermission


class startUpViewController: UIViewController,CCBottomSlideDelegate, UITextFieldDelegate, SPPermissionDialogDelegate{

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
    var isFirstTime:Bool!

    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Function Calling
        if UIApplication.isFirstLaunch(){
            SPPermission.Dialog.request(with: [.camera, .photoLibrary, .microphone], on: self,delegate: self,dataSource: self)
        }
        
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
        bottomController?.onPanelExpanded = {}
        bottomController?.onPanelCollapsed = {}
        bottomController?.onPanelMoved = { offset in }
    }
    
    func handleAnimations(){
        
    // This function deals with the handling of the animations and transitions  of view .
        swipeUpLbel.isHidden = true
        activity.stopAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() ) { // change 2 to desired number of seconds
            self.swipeUpLbel.isHidden = false
            
            UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 2.0, initialSpringVelocity: 2.0, options: .curveEaseInOut, animations: {
                
                let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
                animation.duration = 3.0
                animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
                self.bottomView.layer.add(animation, forKey: "shake")
                self.swipeUpLbel.layer.add(animation, forKey: "shake")
            }, completion: {
                (value: Bool) in
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
        self.swipeUpLbel.isHidden = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        bottomController?.viewWillTransition(to: size, with: coordinator)
    }
}

extension startUpViewController: SPPermissionDialogColorSource{
    
    var baseColor: UIColor {
        return UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
    }
    
    var blackColor: UIColor {
        return UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
    }
}

extension startUpViewController: SPPermissionDialogDataSource {
    
    var dialogComment: String {
        return "CometChatPro Sample App reqires above permissions to perform the necessory actions."
    }
    
    var dialogTitle: String {
        return "COMETCHAT PRO"
    }
    
    func image(for permission: SPPermissionType) -> UIImage? {
        
        switch permission{
            
        case .camera:break

        case .photoLibrary: break
            
        case .notification:break
            
        case .microphone:break
            
        case .calendar:break
            
        case .contacts:break
            
        case .reminders:break
            
        case .speech:break
            
        case .locationWhenInUse:break
            
        case .locationAlwaysAndWhenInUse:break
            
        case .motion:break
            
        case .mediaLibrary:break
            
        }
         return nil
    }
}


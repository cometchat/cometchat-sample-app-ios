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
        
        return NSLocalizedString("CometChat Pro Sample App requires above permissions to perform the necessary actions.", comment: "")
    }
    
    var dialogTitle: String {
        return NSLocalizedString("COMETCHAT PRO", comment: "")
    }
    
    func deniedTitle(for permission: SPPermissionType) -> String? {
        return NSLocalizedString("Permission denied", comment: "")
    }
    
    func deniedSubtitle(for permission: SPPermissionType) -> String? {
        return NSLocalizedString("Please, go to Settings and allow permissions", comment: "")
    }
    
    var cancelTitle: String {
        return NSLocalizedString("Cancel", comment: "")
    }
    
    var settingsTitle: String {
        return NSLocalizedString("Settings", comment: "")
    }
    
    var allowTitle: String {
        return NSLocalizedString("Allow", comment: "")
    }
    
    var allowedTitle: String {
        return NSLocalizedString("Allowed", comment: "")
    }
    
    var dialogSubtitle: String {
        return NSLocalizedString("Permissions Request", comment: "")
    }
    
    func name(for permission: SPPermissionType) -> String? {
        switch permission {
        case .camera:
            return NSLocalizedString("Camera", comment: "")
        case .photoLibrary:
            return NSLocalizedString("Photo Library", comment: "")
        case .notification:
            return NSLocalizedString("Notification", comment: "")
        case .microphone:
            return NSLocalizedString("Microphone", comment: "")
        case .calendar:
            return NSLocalizedString("Calendar", comment: "")
        case .contacts:
            return NSLocalizedString("Contacts", comment: "")
        case .reminders:
            return NSLocalizedString("Reminders", comment: "")
        case .speech:
            return NSLocalizedString("Speech", comment: "")
        case .locationWhenInUse, .locationAlwaysAndWhenInUse:
            return NSLocalizedString("Location", comment: "")
        case .motion:
            return NSLocalizedString("Motion", comment: "")
        case .mediaLibrary:
            return NSLocalizedString("Media Library", comment: "")
        }
    }
    
    func description(for permission: SPPermissionType) -> String? {
        switch permission {
        case .camera:
            return NSLocalizedString("Allow app for use camera", comment: "")
        case .calendar:
            return NSLocalizedString("Application can add events to calendar", comment: "")
        case .contacts:
            return NSLocalizedString("Access for your contacts and phones", comment: "")
        case .microphone:
            return NSLocalizedString("Allow record voice from app", comment: "")
        case .notification:
            return NSLocalizedString("Get important information without opening app.", comment: "")
        case .photoLibrary:
            return NSLocalizedString("Access for save photos in your gallery", comment: "")
        case .reminders:
            return NSLocalizedString("Application can create new task", comment: "")
        case .speech:
            return NSLocalizedString("Allow check you voice", comment: "")
        case .locationWhenInUse, .locationAlwaysAndWhenInUse:
            return NSLocalizedString("App will can check your location", comment: "")
        case .motion:
            return NSLocalizedString("Allow reports motion and environment-related data", comment: "")
        case .mediaLibrary:
            return NSLocalizedString("Allow check your media", comment: "")
        }
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


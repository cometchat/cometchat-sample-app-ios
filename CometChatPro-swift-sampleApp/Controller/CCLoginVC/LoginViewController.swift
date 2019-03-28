//
//  LoginViewController.swift
//  CometChatUI
//
//  Created by Admin1 on 16/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit
import CometChatPro
import Firebase

class LoginViewController: UIViewController ,UITextFieldDelegate {
    
    //Outlets Declaration
    @IBOutlet weak var bottomViewTop: NSLayoutConstraint!
    @IBOutlet weak var bottomViewUpArrow: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var UserNameView: UIView!
    @IBOutlet weak var PasswordView: UIView!
    @IBOutlet weak var switchBtn: UISwitch!
    @IBOutlet weak var superHero1View: UIView!
    @IBOutlet weak var superHero2View: UIView!
    @IBOutlet weak var superHero3View: UIView!
    @IBOutlet weak var superHero4View: UIView!
    
    
    //Variable Declarations
    var cometchat:CometChat!
    let modelName = UIDevice.modelName
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        //Funtion Calling
        self.handleLoginVCApperance()
        self.hideKeyboardWhenTappedAround()
        
        //Assigning Delegates
        userName.delegate = self
        password.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Funtion Calling
        self.handleTopViewDistance()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == 0 {
                if (modelName == "iPhone X" || modelName == "iPhone XS") || (modelName == "iPhone XS Max"){
                    self.view.frame.origin.y -= 100
                }else {
                    self.view.frame.origin.y -= 45
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func handleLoginVCApperance(){
        
        //View Apperance
        self.view.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        self.UserNameView.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        self.PasswordView.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        self.loginButton.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        self.loginButton.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
        self.switchBtn.tintColor = UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
        self.switchBtn.onTintColor = UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
        
        
        //TapGestureOnSuperHeroButtons
        let tapOnSuperHero1 = UITapGestureRecognizer(target: self, action: #selector(LoginWithSuperHero1(tapGestureRecognizer:)))
        superHero1View.isUserInteractionEnabled = true
        superHero1View.addGestureRecognizer(tapOnSuperHero1)
        
        let tapOnSuperHero2 = UITapGestureRecognizer(target: self, action: #selector(LoginWithSuperHero2(tapGestureRecognizer:)))
        superHero2View.isUserInteractionEnabled = true
        superHero2View.addGestureRecognizer(tapOnSuperHero2)
        
        let tapOnSuperHero3 = UITapGestureRecognizer(target: self, action: #selector(LoginWithSuperHero3(tapGestureRecognizer:)))
        superHero3View.isUserInteractionEnabled = true
        superHero3View.addGestureRecognizer(tapOnSuperHero3)
        
        let tapOnSuperHero4 = UITapGestureRecognizer(target: self, action: #selector(LoginWithSuperHero4(tapGestureRecognizer:)))
        superHero4View.isUserInteractionEnabled = true
        superHero4View.addGestureRecognizer(tapOnSuperHero4)
    }
    
    @IBAction func login(_ sender: Any) {
        CometChatLog.print(items: "login button pressed")
        let API_KEY:String = AuthenticationDict?["API_KEY"] as! String
        let UID:String = userName.text!
        let trimmedUID = UID.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(trimmedUID.count == 0){
            showAlert(title: "Warning!", msg: "UID cannot be Empty")
        }else if(API_KEY.contains("Enter") || API_KEY.contains("ENTER") || API_KEY.contains("NULL") || API_KEY.contains("null") || API_KEY.count == 0){
            showAlert(title: "Warning!", msg: "Please fill the APP-ID and API-KEY in CometChat-info.plist file.")
        }else{
            
            CometChat.login(UID: trimmedUID, apiKey: API_KEY, onSuccess: { (current_user) in
                
                var loggedInUserInfo:Dictionary = [String:Any]()
                let username:String = current_user.name ?? ""
                let userAvtar:String = current_user.avatar ?? ""
                let userStatus:String = current_user.status ?? ""
                
                let APP_ID:String = AuthenticationDict?["APP_ID"] as! String
                let userID:String = current_user.uid!
                let topic: String = APP_ID + "_user_" + userID + "_ios"
                Messaging.messaging().subscribe(toTopic: topic) { error in
                    CometChatLog.print(items:"Subscribed to \(topic) topic")
                }
                loggedInUserInfo = ["username":username,"userAvtar":userAvtar,"userStatus":userStatus]
                UserDefaults.standard.set(loggedInUserInfo, forKey: "LoggedInUserInfo")
                //UIButton State Change
                self.loginButton.setTitle("Login Sucessful", for: .normal)
                self.loginButton.backgroundColor = UIColor.init(hexFromString: "9ACD32")
                //Navigate to Next VC
                UserDefaults.standard.set(current_user.uid, forKey: "LoggedInUserUID")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let embeddedViewContrroller = storyboard.instantiateViewController(withIdentifier: "embeddedViewContrroller") as! EmbeddedViewController
                    self.navigationController?.pushViewController(embeddedViewContrroller, animated: true)
                }
                
            }){ (error) in
                
                CometChatLog.print(items:"login error:\(error.errorDescription)")
                CometChatLog.print(items:"login error: \(String(describing: error.debugDescription))")
                DispatchQueue.main.async { [unowned self] in
                    self.loginButton.backgroundColor = UIColor.init(hexFromString: "FF0000")
                    self.loginButton.setTitle("Login Failure", for: .normal)
                }
            }
        }
    }
    
    @objc func LoginWithSuperHero1(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.loginButton.setTitle("Login with Superhero1", for: .normal)
        userName.text = "superhero1"
        let API_KEY:String = AuthenticationDict?["API_KEY"] as! String
        CometChat.login(UID: "superhero1", apiKey: API_KEY, onSuccess: { (current_user) in
            self.loginButton.setTitle("Login Sucessful", for: .normal)
            self.loginButton.backgroundColor = UIColor.init(hexFromString: "9ACD32")
            var loggedInUserInfo:Dictionary = [String:Any]()
            let username:String = current_user.name ?? ""
            let userAvtar:String = current_user.avatar ?? ""
            let userStatus:String = current_user.status ?? ""
            
            let APP_ID:String = AuthenticationDict?["APP_ID"] as! String
            let userID:String = current_user.uid!
            let topic: String = APP_ID + "_user_" + userID + "_ios"
            Messaging.messaging().subscribe(toTopic: topic) { error in
                CometChatLog.print(items:"Subscribed to \(topic) topic")
            }
            
            loggedInUserInfo = ["username":username,"userAvtar":userAvtar,"userStatus":userStatus]
            UserDefaults.standard.set(loggedInUserInfo, forKey: "LoggedInUserInfo")
            //UIButton State Change
            self.loginButton.setTitle("Login Sucessful", for: .normal)
            self.loginButton.backgroundColor = UIColor.init(hexFromString: "9ACD32")
            //Navigate to Next VC
            UserDefaults.standard.set(current_user.uid, forKey: "LoggedInUserUID")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let embeddedViewContrroller = storyboard.instantiateViewController(withIdentifier: "embeddedViewContrroller") as! EmbeddedViewController
                self.navigationController?.pushViewController(embeddedViewContrroller, animated: true)
            }
            
        }) { (error) in
            DispatchQueue.main.async { [unowned self] in
                self.loginButton.backgroundColor = UIColor.init(hexFromString: "FF0000")
                self.loginButton.setTitle("Login Failure", for: .normal)
            }
        }
        
    }
    
    @objc func LoginWithSuperHero2(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let API_KEY:String = AuthenticationDict?["API_KEY"] as! String
        self.loginButton.setTitle("Login with Superhero2", for: .normal)
        userName.text = "superhero2"
        CometChat.login(UID: "superhero2", apiKey: API_KEY, onSuccess: { (current_user) in
            self.loginButton.setTitle("Login Sucessful", for: .normal)
            self.loginButton.backgroundColor = UIColor.init(hexFromString: "9ACD32")
            var loggedInUserInfo:Dictionary = [String:Any]()
            let username:String = current_user.name ?? ""
            let userAvtar:String = current_user.avatar ?? ""
            let userStatus:String = current_user.status ?? ""
            
            let APP_ID:String = AuthenticationDict?["APP_ID"] as! String
            let userID:String = current_user.uid!
            let topic: String = APP_ID + "_user_" + userID + "_ios"
            Messaging.messaging().subscribe(toTopic: topic) { error in
                CometChatLog.print(items:"Subscribed to \(topic) topic")
            }
            
            loggedInUserInfo = ["username":username,"userAvtar":userAvtar,"userStatus":userStatus]
            UserDefaults.standard.set(loggedInUserInfo, forKey: "LoggedInUserInfo")
            //UIButton State Change
            self.loginButton.setTitle("Login Sucessful", for: .normal)
            self.loginButton.backgroundColor = UIColor.init(hexFromString: "9ACD32")
            //Navigate to Next VC
            UserDefaults.standard.set(current_user.uid, forKey: "LoggedInUserUID")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let embeddedViewContrroller = storyboard.instantiateViewController(withIdentifier: "embeddedViewContrroller") as! EmbeddedViewController
                self.navigationController?.pushViewController(embeddedViewContrroller, animated: true)
            }
            
        }) { (error) in
            DispatchQueue.main.async { [unowned self] in
                self.loginButton.backgroundColor = UIColor.init(hexFromString: "FF0000")
                self.loginButton.setTitle("Login Failure", for: .normal)
            }
        }
        
        
    }
    
    @objc func LoginWithSuperHero3(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let API_KEY:String = AuthenticationDict?["API_KEY"] as! String
        self.loginButton.setTitle("Login with Superhero3", for: .normal)
        userName.text = "superhero3"
        CometChat.login(UID: "superhero3", apiKey: API_KEY, onSuccess: { (current_user) in
            self.loginButton.setTitle("Login Sucessful", for: .normal)
            self.loginButton.backgroundColor = UIColor.init(hexFromString: "9ACD32")
            var loggedInUserInfo:Dictionary = [String:Any]()
            let username:String = current_user.name ?? ""
            let userAvtar:String = current_user.avatar ?? ""
            let userStatus:String = current_user.status ?? ""
            
            let APP_ID:String = AuthenticationDict?["APP_ID"] as! String
            let userID:String = current_user.uid!
            let topic: String = APP_ID + "_user_" + userID + "_ios"
            Messaging.messaging().subscribe(toTopic: topic) { error in
                CometChatLog.print(items:"Subscribed to \(topic) topic")
            }
            
            loggedInUserInfo = ["username":username,"userAvtar":userAvtar,"userStatus":userStatus]
            UserDefaults.standard.set(loggedInUserInfo, forKey: "LoggedInUserInfo")
            //UIButton State Change
            self.loginButton.setTitle("Login Sucessful", for: .normal)
            self.loginButton.backgroundColor = UIColor.init(hexFromString: "9ACD32")
            //Navigate to Next VC
            UserDefaults.standard.set(current_user.uid, forKey: "LoggedInUserUID")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let embeddedViewContrroller = storyboard.instantiateViewController(withIdentifier: "embeddedViewContrroller") as! EmbeddedViewController
                self.navigationController?.pushViewController(embeddedViewContrroller, animated: true)
            }
            
        }) { (error) in
            DispatchQueue.main.async { [unowned self] in
                self.loginButton.backgroundColor = UIColor.init(hexFromString: "FF0000")
                self.loginButton.setTitle("Login Failure", for: .normal)
            }
        }
        
    }
    
    @objc func LoginWithSuperHero4(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let API_KEY:String = AuthenticationDict?["API_KEY"] as! String
        self.loginButton.setTitle("Login with Superhero4", for: .normal)
        userName.text = "superhero4"
        CometChat.login(UID: "superhero4", apiKey: API_KEY, onSuccess: { (current_user) in
            self.loginButton.setTitle("Login Sucessful", for: .normal)
            self.loginButton.backgroundColor = UIColor.init(hexFromString: "9ACD32")
            var loggedInUserInfo:Dictionary = [String:Any]()
            let username:String = current_user.name ?? ""
            let userAvtar:String = current_user.avatar ?? ""
            let userStatus:String = current_user.status ?? ""
            
            let APP_ID:String = AuthenticationDict?["APP_ID"] as! String
            let userID:String = current_user.uid!
            let topic: String = APP_ID + "_user_" + userID + "_ios"
            Messaging.messaging().subscribe(toTopic: topic) { error in
                CometChatLog.print(items:"Subscribed to \(topic) topic")
            }
            
            loggedInUserInfo = ["username":username,"userAvtar":userAvtar,"userStatus":userStatus]
            UserDefaults.standard.set(loggedInUserInfo, forKey: "LoggedInUserInfo")
            //UIButton State Change
            self.loginButton.setTitle("Login Sucessful", for: .normal)
            self.loginButton.backgroundColor = UIColor.init(hexFromString: "9ACD32")
            //Navigate to Next VC
            UserDefaults.standard.set(current_user.uid, forKey: "LoggedInUserUID")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let embeddedViewContrroller = storyboard.instantiateViewController(withIdentifier: "embeddedViewContrroller") as! EmbeddedViewController
                self.navigationController?.pushViewController(embeddedViewContrroller, animated: true)
            }
            
        }) { (error) in
            DispatchQueue.main.async { [unowned self] in
                self.loginButton.backgroundColor = UIColor.init(hexFromString: "FF0000")
                self.loginButton.setTitle("Login Failure", for: .normal)
            }
        }
        
        
        
    }
    
    
    
    @IBAction func guestLogin(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let embeddedViewContrroller = storyboard.instantiateViewController(withIdentifier: "embeddedViewContrroller") as! EmbeddedViewController
        self.navigationController?.pushViewController(embeddedViewContrroller, animated: true)
    }
    
    
    func handleTopViewDistance(){
        
        if(modelName == "iPhone 5" || modelName == "iPhone 5s" || modelName == "iPhone 5c" || modelName == "iPhone SE" ){
            bottomViewTop.constant = 0
        }else if (modelName == "iPhone 6 Plus" || modelName == "iPhone 6s Plus" || modelName == "iPhone 7 Plus" || modelName == "iPhone 8 Plus"){
            bottomViewTop.constant = 0
        }else if(modelName == "iPhone XS Max"){
            bottomViewTop.constant = 0
        }else if (modelName == "iPhone X" || modelName == "iPhone XS") {
            bottomViewTop.constant = 0
        }else if(modelName == "iPhone XR"){
            bottomViewTop.constant = 0
        }else if(modelName == "iPad Pro (12.9-inch) (2nd generation)"){
            bottomViewTop.constant = 0
        }else{
            bottomViewTop.constant = 0
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}

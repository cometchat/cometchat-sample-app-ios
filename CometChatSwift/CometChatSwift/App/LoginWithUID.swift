//
//  ViewController.swift
//  Demo
//
//  Created by CometChat Inc. on 16/12/19.
//  Copyright © 2020 CometChat Inc. All rights reserved.
//

import UIKit
import CometChatPro

class LoginWithUID: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var signInBottomConstraint: NSLayoutConstraint!
    
    let modelName = UIDevice.modelName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerObservers()

    }
    
    fileprivate func registerObservers(){
        //Register Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dismissKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.hideKeyboardWhenTappedArround()
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
             if let userinfo = notification.userInfo
             {
                 let keyboardHeight = (userinfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue?.size.height
                 if (modelName == "iPhone X" || modelName == "iPhone XS" || modelName == "iPhone XR" || modelName == "iPhone12,1"){
                     signInBottomConstraint.constant = (keyboardHeight)! - 10
                     UIView.animate(withDuration: 0.5) {
                         self.view.layoutIfNeeded()
                     }
                 }else{
                     signInBottomConstraint.constant = (keyboardHeight)! + 20
                     UIView.animate(withDuration: 0.5) {
                         self.view.layoutIfNeeded()
                     }
                 }
             }
    }
    
    fileprivate func hideKeyboardWhenTappedArround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
           backgroundView.addGestureRecognizer(tap)
       }
    
    
    // This function dismiss the  keyboard
    @objc  func dismissKeyboard() {
        textField.resignFirstResponder()
        if self.signIn.frame.origin.y != 0 {
            signInBottomConstraint.constant = 40
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }

   
    
    @IBAction func signInPressed(_ sender: Any) {
        self.loginWithUID(UID: textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
    }
    
   
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func loginWithUID(UID:String){
        
        activityIndicator.startAnimating()
        if(Constants.apiKey.contains(NSLocalizedString("Enter", comment: "")) || Constants.apiKey.contains(NSLocalizedString("ENTER", comment: "")) || Constants.apiKey.contains("NULL") || Constants.apiKey.contains("null") || Constants.apiKey.count == 0){
            showAlert(title: NSLocalizedString("Warning!", comment: ""), msg: NSLocalizedString("Please fill the APP-ID and API-KEY in Constants.swift file.", comment: ""))
        }else{
            CometChat.login(UID: UID, apiKey: Constants.apiKey, onSuccess: { (current_user) in
                
                    let userID:String = current_user.uid!
                    UserDefaults.standard.set(userID, forKey: "LoggedInUserUID")
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                         let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "mainViewController") as! MainViewController
                        let navigationController: UINavigationController = UINavigationController(rootViewController: mainVC)
                        navigationController.modalPresentationStyle = .fullScreen
                        navigationController.title = "CometChat KitchenSink"
                        navigationController.navigationBar.prefersLargeTitles = true
                       if #available(iOS 13.0, *) {
                                let navBarAppearance = UINavigationBarAppearance()
                               navBarAppearance.configureWithOpaqueBackground()
                        
                        navBarAppearance.titleTextAttributes = [ .foregroundColor:  UIColor.label,.font: UIFont.boldSystemFont(ofSize: 20) as Any]
                                navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label, .font: UIFont.boldSystemFont(ofSize: 30) as Any]
                                navBarAppearance.shadowColor = .clear
                        navBarAppearance.backgroundColor = .systemBackground
                        navigationController.navigationBar.standardAppearance = navBarAppearance
                        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
                                self.navigationController?.navigationBar.isTranslucent = false
                            }
                        self.present(navigationController, animated: true, completion: nil)
                    }
            }) { (error) in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    DispatchQueue.main.async {
                      let snackbar: CometChatSnackbar = CometChatSnackbar.init(message: error.errorDescription, duration: .short)
                         snackbar.show()
                    }
                }
                print("login failure \(error.errorDescription)")
                
            }
        }
    }
}


//
//  ViewController.swift
//  Demo
//
//  Created by CometChat Inc. on 16/12/19.
//  Copyright © 2020 CometChat Inc. All rights reserved.
//

import UIKit
import CometChatPro

class CreateUser: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var lodingViewTitle: UILabel!
    @IBOutlet weak var loadingViewHeightConstriant: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var signInButtonConstraint: NSLayoutConstraint!
    let modelName = UIDevice.modelName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = true
        loadingViewHeightConstriant.constant = 0
        self.registerObservers()
        self.navigationController?.title = "Sign Up"
        
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
                signInButtonConstraint.constant = (keyboardHeight)! - 10
                UIView.animate(withDuration: 0.5) {
                    self.view.layoutIfNeeded()
                }
            }else{
                signInButtonConstraint.constant = (keyboardHeight)! + 20
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
        if self.submit.frame.origin.y != 0 {
            signInButtonConstraint.constant = 40
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
             self.createUser()
        }
    }
    
    @IBAction func didCancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private func createUser() {
        guard let name = textField.text else { return }
        if(Constants.apiKey.contains(NSLocalizedString("Enter", comment: "")) || Constants.apiKey.contains(NSLocalizedString("ENTER", comment: "")) || Constants.apiKey.contains("NULL") || Constants.apiKey.contains("null") || Constants.apiKey.count == 0){
            showAlert(title: NSLocalizedString("Warning!", comment: ""), msg: NSLocalizedString("Please fill the APP-ID and API-KEY in Constants.swift file.", comment: ""))
        }else{
            loadingView.isHidden = false
            loadingViewHeightConstriant.constant = 40
            activityIndicator.startAnimating()
            lodingViewTitle.text = "Creating an User..."
            loadingView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
            if name.count == 0 {
                showAlert(title: "Warning!", msg: "Name cannot be empty")
            }else {
                
                let user = User(uid: "user\(Int(Date().timeIntervalSince1970 * 100))", name: name)
                CometChat.createUser(user: user, apiKey: Constants.apiKey, onSuccess: { (user) in
                    
                    if let uid = user.uid {
                          self.loginWithUID(UID: uid)
                    }

                }) { (error) in
                    if let error = error?.errorDescription {
                        DispatchQueue.main.async { [weak self] in
                            self?.loadingView.isHidden = false
                            self?.loadingViewHeightConstriant.constant = 40
                            self?.activityIndicator.startAnimating()
                            self?.lodingViewTitle.text = "Failed to create user."
                            self?.loadingView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                            UIView.animate(withDuration: 0.25) {
                                self?.view.layoutIfNeeded()
                            }
                            let snackbar: CometChatSnackbar = CometChatSnackbar.init(message: error, duration: .short)
                            snackbar.show()
                        }
                        print("Create User failure \(error)")
                    }
                }
                
            }
        }
    }

    private func loginWithUID(UID:String){
        DispatchQueue.main.async {
            self.loadingView.isHidden = false
            self.loadingViewHeightConstriant.constant = 40
            self.activityIndicator.startAnimating()
            self.lodingViewTitle.text = "Logging in..."
            self.loadingView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
        if(Constants.apiKey.contains(NSLocalizedString("Enter", comment: "")) || Constants.apiKey.contains(NSLocalizedString("ENTER", comment: "")) || Constants.apiKey.contains("NULL") || Constants.apiKey.contains("null") || Constants.apiKey.count == 0){
            showAlert(title: NSLocalizedString("Warning!", comment: ""), msg: NSLocalizedString("Please fill the APP-ID and API-KEY in Constants.swift file.", comment: ""))
        }else{
            CometChat.login(UID: UID, apiKey: Constants.apiKey, onSuccess: { (current_user) in
                
                let userID:String = current_user.uid!
                UserDefaults.standard.set(userID, forKey: "LoggedInUserUID")
                DispatchQueue.main.async {
                    self.loadingView.isHidden = false
                    self.loadingViewHeightConstriant.constant = 0
                    self.activityIndicator.startAnimating()
                    self.lodingViewTitle.text = ""
                    UIView.animate(withDuration: 0.25) {
                        self.view.layoutIfNeeded()
                    }
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
                DispatchQueue.main.async { [weak self] in
                    self?.loadingView.isHidden = false
                    self?.loadingViewHeightConstriant.constant = 40
                    self?.activityIndicator.stopAnimating()
                    self?.lodingViewTitle.text = "Failed to login the user."
                    self?.loadingView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                    UIView.animate(withDuration: 0.25) {
                        self?.view.layoutIfNeeded()
                    }
                    let snackbar: CometChatSnackbar = CometChatSnackbar.init(message: error.errorDescription, duration: .short)
                    snackbar.show()
                }
                print("login failure \(error.errorDescription)")
                
            }
        }
    }
}


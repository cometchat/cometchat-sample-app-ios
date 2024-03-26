//
//  Login.swift
//  CometChatSwift
//
//  Created by admin on 28/09/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatSDK
import CometChatUIKitSwift

class Login: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var superHero1View: UIView!
    @IBOutlet weak var superHero2View: UIView!
    @IBOutlet weak var superHero3View: UIView!
    @IBOutlet weak var superHero4View: UIView!
    @IBOutlet weak var superHero1Background: GradientImageView!
    @IBOutlet weak var superHero2Background: GradientImageView!
    @IBOutlet weak var superHero3Background: GradientImageView!
    @IBOutlet weak var superHero4Background: GradientImageView!
    @IBOutlet weak var uidView: UIView!
    @IBOutlet weak var uid: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginBackground: GradientImageView!
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addObservers()
        registerObservers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        reloadGradients()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        uid.text = nil
    }
    
    //MARK: FUNCTIONS
    func setupUI() {
        containerView.roundViewCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 14)
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.systemFill.cgColor
        signUpButton.layer.borderWidth = 1.0
        signUpButton.layer.borderColor = UIColor.systemGray4.cgColor
        self.navigationController?.isNavigationBarHidden = true
        uidView.layer.borderWidth = 1.0
        uidView.layer.borderColor = UIColor.systemFill.cgColor
        uid.leftPadding()
        uidView.roundViewCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 10)
        signUpButton.roundViewCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 10)
    }
    
    fileprivate func addObservers() {
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
    
    @objc func LoginWithSuperHero1(tapGestureRecognizer: UITapGestureRecognizer) {
        loginWithUID(UID: "superhero1")
    }
    
    @objc func LoginWithSuperHero2(tapGestureRecognizer: UITapGestureRecognizer) {
        loginWithUID(UID: "superhero2")
    }
    
    @objc func LoginWithSuperHero3(tapGestureRecognizer: UITapGestureRecognizer) {
        loginWithUID(UID: "superhero3")
    }
    
    @objc func LoginWithSuperHero4(tapGestureRecognizer: UITapGestureRecognizer) {
        loginWithUID(UID: "superhero4")
    }
    
    private func loginWithUID(UID:String) {
        DispatchQueue.main.async {
            CustomLoader.instance.showLoaderView()
        }
        if(AppConstants.AUTH_KEY.contains(NSLocalizedString("Enter", comment: "")) || AppConstants.AUTH_KEY.contains(NSLocalizedString("ENTER", comment: "")) || AppConstants.AUTH_KEY.contains("NULL") || AppConstants.AUTH_KEY.contains("null") || AppConstants.AUTH_KEY.count == 0) {
            DispatchQueue.main.async {
                CustomLoader.instance.hideLoaderView()
                self.showAlert(title: NSLocalizedString("Warning!", comment: ""), msg: NSLocalizedString("Please fill the APP-ID and AUTH-KEY in Constants.swift file.", comment: ""))
            }
            
        } else {
            CometChatUIKit.login(uid: UID, result: { (result) in
                switch result {
                case .success(let user):
                    DispatchQueue.main.async {
                        let userID = user.uid
                        UserDefaults.standard.set(userID, forKey: "LoggedInUserUID")
                        CustomLoader.instance.hideLoaderView()
                        if let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "home") as? Home {
                            self.navigationController?.pushViewController(mainVC, animated: true)
                        }
                    }
                    break
                case .onError(let error):
                    DispatchQueue.main.async {
                        CustomLoader.instance.hideLoaderView()
                        self.showAlert(title: "Error", msg: error.errorDescription)
                        
                    }
                    break
                }
            })
        }
    }
    
    @IBAction func loginButton_Pressed(_ sender: UIButton) {
        if let uid = uid.text?.trimmingCharacters(in: .whitespacesAndNewlines), !uid.isEmpty {
            self.loginWithUID(UID: uid)
         } else {
            showAlert(title: "Warning!", msg: "UID cannot be empty! Please enter UID to login.")
        }
       
    }
    
    @IBAction func signUpButton_Pressed(_ sender: UIButton) {
        if let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateUser") as? CreateUser {
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }
    
    private func reloadGradients() {
        DispatchQueue.main.async {
            let gradLayer = self.loginBackground.layer.sublayers?.compactMap { $0 as? CAGradientLayer }
            gradLayer?.first?.frame = self.loginBackground.bounds
            let gradLayerSuperHero1 = self.superHero1Background.layer.sublayers?.compactMap { $0 as? CAGradientLayer }
            gradLayerSuperHero1?.first?.frame = self.superHero1Background.bounds

            let gradLayerSuperHero2 = self.superHero2Background.layer.sublayers?.compactMap { $0 as? CAGradientLayer }
            gradLayerSuperHero2?.first?.frame = self.superHero2Background.bounds

            let gradLayerSuperHero3 = self.superHero3Background.layer.sublayers?.compactMap { $0 as? CAGradientLayer }
            gradLayerSuperHero3?.first?.frame = self.superHero3Background.bounds

            let gradLayerSuperHero4 = self.superHero4Background.layer.sublayers?.compactMap { $0 as? CAGradientLayer }
            gradLayerSuperHero4?.first?.frame = self.superHero4Background.bounds
        }
    }
    
    fileprivate func registerObservers(){
        //Register Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        self.hideKeyboardWhenTappedArround()
      }
      @objc private func keyboardWillChangeFrame(notification: NSNotification) {
        if let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
          var keyboardHeight = UIScreen.main.bounds.height - endFrame.origin.y
          if keyboardHeight > 0 {
            keyboardHeight = keyboardHeight - view.safeAreaInsets.bottom
            scrollView.contentOffset.y += keyboardHeight*9/10
          } else {
            self.scrollView.setContentOffset(CGPoint(x: 0, y: self.view.frame.origin.y), animated: false )
          }
          UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
          }
        }
      }
      fileprivate func hideKeyboardWhenTappedArround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        }
      @objc func dismissKeyboard() {
        uid.resignFirstResponder()
        UIView.animate(withDuration: 0.25) {
          self.view.layoutIfNeeded()
        }
      }

}

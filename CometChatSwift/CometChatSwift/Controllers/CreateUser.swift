
//  CreateUser.swift
//  CometChatSwift
//  Created by admin on 28/09/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatSDK
import CometChatUIKitSwift

class CreateUser: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var signUpTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var signUpBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var uidView: UIView!
    @IBOutlet weak var uid: UITextField!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var uidStackView: UIStackView!
    @IBOutlet weak var submitBackground: GradientImageView!
    @IBOutlet weak var backButton: UIButton!
    
    //MARK: VARIABLES
    var isCheckbox = false
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerObservers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            let gradLayers = self.submitBackground.layer.sublayers?.compactMap { $0 as? CAGradientLayer }
            gradLayers?.first?.frame = self.submitBackground.bounds
        }
    }
    
    //MARK: FUNCTIONS
    func setupUI() {
        containerView.dropShadow()
        containerView.layer.borderColor = UIColor.systemGray5.cgColor
        containerView.layer.borderWidth = 1.0
        containerView.roundViewCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 15)
        checkBox.roundViewCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 6)
        uidView.roundViewCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 10)
        uidView.layer.borderColor = UIColor.systemGray4.cgColor
        nameView.roundViewCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 10)
        nameView.layer.borderColor = UIColor.systemGray4.cgColor
        checkBox.setImage(UIImage(named: ""), for: .normal)
        uid.leftPadding()
        name.leftPadding()
        let gradientView = GradientImageView(frame: self.view.bounds)
        self.view.insertSubview(gradientView, at: 0)
    }
    
    @IBAction func submit_Pressed(_ sender: UIButton) {
        createUser()
    }
    
    @IBAction func checkBox_Pressed(_ sender: UIButton) {
        checkBox.setImage(UIImage(named: isCheckbox ? "" : "checkmark"), for: .normal)
        UIView.transition(with: uidStackView, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            self.uidStackView.isHidden = !self.isCheckbox
        })
        isCheckbox = !isCheckbox
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func createUser() {
        guard let name = name.text else { return }
        if(Constants.authKey.contains(NSLocalizedString("Enter", comment: "")) || Constants.authKey.contains(NSLocalizedString("ENTER", comment: "")) || Constants.authKey.contains("NULL") || Constants.authKey.contains("null") || Constants.authKey.count == 0) {
            showAlert(title: NSLocalizedString("Warning!", comment: ""), msg: NSLocalizedString("Please fill the APP-ID and AUTH-KEY in Constants.swift file.", comment: ""))
        } else {
            if (name.count == 0 ) {
                showAlert(title: "Warning!", msg: "Name cannot be empty")
            } else {
                var user : User?
                if isCheckbox {
                    user = User(uid: "user\(Int(Date().timeIntervalSince1970 * 100))", name: name)
                } else {
                    user = User(uid: self.uid.text?.trimmingCharacters(in: .whitespaces) ?? "", name: self.name.text?.trimmingCharacters(in: .whitespaces) ?? "")
                }
                if let user = user {
                    CometChatUIKit.create(user: user, result: { result in
                        switch result {
                        case .success(let user):
                            if let uid = user.uid {
                                self.loginWithUID(UID: uid)
                            }
                            break
                        case .onError(let error):
                            DispatchQueue.main.async {
                                self.showAlert(title: "Error", msg: error.errorDescription)
                            }
                            break
                        }
                    })
                }
            }
        }
    }
    
    private func loginWithUID(UID:String) {
        DispatchQueue.main.async {
            CustomLoader.instance.showLoaderView()
        }
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
    
    fileprivate func registerObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        self.hideKeyboardWhenTappedArround()
    }
    
    @objc private func keyboardWillChangeFrame(notification: NSNotification) {
        if let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var keyboardHeight = UIScreen.main.bounds.height - endFrame.origin.y
            if keyboardHeight > 0 {
                keyboardHeight = keyboardHeight - view.safeAreaInsets.bottom
                signUpTopConstraint.constant = 0
                signUpBottomConstraint.constant = 4
            } else {
                signUpTopConstraint.constant = 30
                signUpBottomConstraint.constant = 20
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
        name.resignFirstResponder()
        self.view.layoutIfNeeded()
    }
    
}

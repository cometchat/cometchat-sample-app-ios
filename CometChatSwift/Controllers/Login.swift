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
    @IBOutlet weak var uidView: UIView!
    @IBOutlet weak var uid: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginBackground: GradientImageView!
    
    @IBOutlet weak var loginButtons: UIStackView!
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerObservers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        
        self.loginButtons.axis = .vertical
        self.loginButtons.alignment = .fill
        self.loginButtons.distribution = .fillEqually
        self.loginButtons.spacing = 10 // Optional: Add spacing between views
        self.loginButtons.translatesAutoresizingMaskIntoConstraints = false
        fetchSampleLoginData()
       
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
    
    func fetchSampleLoginData(){
        let url = URL(string: "https://assets.cometchat.io/sampleapp/sampledata.json")!
          URLSession.shared.fetchData(for: url) { (result: Result<SampleUsers, Error>) in
            switch result {
            case .success(let users):
                self.constructLoginButtons(users.users)
                
            case .failure(let error):
                if let data = self.loadJson(filename: "sample_user_data"){
                    self.constructLoginButtons(data.users)
                } else {
                    print("error occured is \(error.localizedDescription)")
                }
                
          }
        }
    }
    
    func constructLoginButtons(_ users : [SampleUser]){
        DispatchQueue.main.async {
            var count = 0
            var row = UIStackView()
            row.axis = .horizontal
            row.alignment = .fill
            row.distribution = .equalSpacing
            row.spacing = 2 // Optional: Add spacing between views
            row.translatesAutoresizingMaskIntoConstraints = false
            for user in users{
                count+=1
                // Create the background view
                        let backgroundView = UIView()
                        backgroundView.translatesAutoresizingMaskIntoConstraints = false
                backgroundView.backgroundColor = CometChatTheme.palatte.secondary.withAlphaComponent(0.16)
                        backgroundView.layer.cornerRadius = 15.0
                backgroundView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMaxYCorner,.layerMaxXMinYCorner]
                        backgroundView.layer.masksToBounds = true // Ensure the corners are clipped
                
                let customButton = CustomLoginButton()
                    .set(title: user.name)
                    .set(subtitle: user.uid)
                    .set(avatar: user.avatar)
                    .set(onTap: { [weak self] in
                        guard let this = self else { return }
                        this.loginWithUID(UID: user.uid)
                    })
                
                
                backgroundView.addSubview(customButton)
                
                row.addArrangedSubview(backgroundView)
                // Set constraints for the background view
                      NSLayoutConstraint.activate([
                          backgroundView.widthAnchor.constraint(equalToConstant: 161.8),
                          backgroundView.heightAnchor.constraint(equalToConstant: 50)
                      ])
                      
                      // Set constraints for the button to match the size of the background view
                      NSLayoutConstraint.activate([
                          customButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
                          customButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
                          customButton.topAnchor.constraint(equalTo: backgroundView.topAnchor),
                          customButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor)
                      ])
                
                if count%2==0 {
                    self.loginButtons.addArrangedSubview(row)
                    row = UIStackView()
                    row.axis = .horizontal
                    row.alignment = .fill
                    row.distribution = .equalSpacing
                    row.spacing = 2 // Optional: Add spacing between views
                    row.translatesAutoresizingMaskIntoConstraints = false
                }
            }
            
            if count%2 != 0{
                row.addArrangedSubview(UIView(frame: CGRect(x: 0, y: 0, width: 152, height: 50)))
                self.loginButtons.addArrangedSubview(row)
            }
            
        }
    }
    
    func loadJson(filename fileName: String) -> SampleUsers? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(SampleUsers.self, from: data)
                return jsonData
            } catch {
                print("error occurred while loading JSON:\(error.localizedDescription)")
            }
        }
        return nil
    }
    
    @IBAction func signUpButton_Pressed(_ sender: UIButton) {
        if let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateUser") as? CreateUser {
            self.navigationController?.pushViewController(mainVC, animated: true)
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

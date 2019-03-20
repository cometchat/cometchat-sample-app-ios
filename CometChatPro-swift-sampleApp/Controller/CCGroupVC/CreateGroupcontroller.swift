//
//  CreateGroupcontroller.swift
//  CometChatUI
//
//  Created by Admin1 on 21/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit
import CometChatPro

class CreateGroupcontroller: UIViewController {

    //Outlets Declaration
    @IBOutlet weak var groupIDView: UIView!
    @IBOutlet weak var groupNameView: UIView!
    @IBOutlet weak var groupTypeView: UIView!
    @IBOutlet weak var groupPasswordView: UIView!
    @IBOutlet weak var groupType: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var groupstackView: UIStackView!
    @IBOutlet weak var groupIDTxtFld: UITextField!
    @IBOutlet weak var groupNameTxtFld: UITextField!
    @IBOutlet weak var groupPasswordTxtFld: UITextField!
    //Variable Declarations
    var group:Group!
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Function Calling
        self.handleCreateGroupVCAppearance()
        self.hideKeyboardWhenTappedAround()
    }
    
     //This method handles the UI customization for CreateGroupVC
    func handleCreateGroupVCAppearance() {
        
        // ViewController Appearance

        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        } else {
            
        }
        
        groupNameView.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        groupIDView.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        groupPasswordView.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        groupTypeView.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        createButton.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        cancelButton.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        
        groupPasswordView.isHidden = true
        
        // NavigationBar Buttons Appearance
        
        let backButtonImage = UIImageView(image: UIImage(named: "back_arrow"))
        backButtonImage.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let backBTN = UIBarButtonItem(image: backButtonImage.image,
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBTN
        backBTN.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
        
        // UIButton Appearance
        createButton.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR)
        createButton.setTitleColor(UIColor.white, for: .normal)
        cancelButton.layer.borderWidth = 1
        cancelButton.setTitleColor(UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR), for: .normal)
        cancelButton.layer.borderColor = UIColor.init(hexFromString: UIAppearanceColor.LOGIN_BUTTON_TINT_COLOR).cgColor
        
        //Tap On SelectGroupType
        
        let tapOnSelectGroupType = UITapGestureRecognizer(target: self, action: #selector(selectGroupTypeClicked(tapGestureRecognizer:)))
        groupTypeView.isUserInteractionEnabled = true
        groupTypeView.addGestureRecognizer(tapOnSelectGroupType)
    }

    //Cancel Button Pressed
    @IBAction func cancelPressed(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //CreateGroup Button Pressed
    @IBAction func createGroupPressed(_ sender: Any) {
        
        if(groupType.text == "Public Group"){
            group = Group(guid: groupIDTxtFld.text!, name: groupNameTxtFld.text!, groupType: .public, password:nil)
        }else if(groupType.text == "Password - Protected"){
            group = Group(guid: groupIDTxtFld.text!, name: groupNameTxtFld.text!, groupType: .password, password: groupPasswordTxtFld.text!)
        }else if(groupType.text == "Private Group"){
            group = Group(guid: groupIDTxtFld.text!, name: groupNameTxtFld.text!, groupType: .private, password:nil)
        }
        
        CometChat.createGroup(group: group, onSuccess: { (group) in
            DispatchQueue.main.async {
            self.view.makeToast("Group created successfully.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigationController?.popViewController(animated: true)
            }
            }
            print("Group created successfully." + group.stringValue())
            let group:[String: Group] = ["groupData": group]
            NotificationCenter.default.post(name: Notification.Name("com.newGroupData"), object: nil, userInfo: group)
        }) { (error) in
           DispatchQueue.main.async {
            self.view.makeToast("\(error!.errorDescription)")
           }
        }
  
    }
    
    //selectGroupType Button Pressed
    @objc func selectGroupTypeClicked(tapGestureRecognizer: UITapGestureRecognizer){
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let publicGroup: UIAlertAction = UIAlertAction(title: "Public Group", style: .default) { action -> Void in
            
            self.groupPasswordView.isHidden = true
            self.groupType.text = "Public Group"
            
        }
        let passwordProtectedGroup: UIAlertAction = UIAlertAction(title: "Password - Protected", style: .default) { action -> Void in
            
             self.groupType.text = "Password - Protected"
             self.groupPasswordView.isHidden = false
            
        }
        let privateGroup: UIAlertAction = UIAlertAction(title: "Private Group", style: .default) { action -> Void in
            
             self.groupPasswordView.isHidden = true
             self.groupType.text = "Private Group"
            
        }

        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
           
            
        }
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        actionSheetController.addAction(publicGroup)
        actionSheetController.addAction(passwordProtectedGroup)
         actionSheetController.addAction(privateGroup)
        actionSheetController.addAction(cancelAction)
        present(actionSheetController, animated: true, completion: nil)
        
    }
}

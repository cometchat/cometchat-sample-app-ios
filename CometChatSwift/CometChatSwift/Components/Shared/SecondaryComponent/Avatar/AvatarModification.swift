//
//  AvatarModification.swift
//  CometChatSwift
//
//  Created by admin on 24/08/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatUIKit
import CometChatPro
class AvatarModification: UIViewController {
    
    // Avatar
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatar: CometChatAvatar!
    @IBOutlet weak var avatarCornerRadius: UITextField!
    @IBOutlet weak var imageSegment: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        avatarView.dropShadow()
        hideKeyboardWhenTappedArround()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemGray6
            avatar.setAvatar(avatarUrl: "https://data-us.cometchat.io/assets/images/avatars/captainamerica.png")
        } else {}

       
    }
    
    fileprivate func hideKeyboardWhenTappedArround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        avatarView.addGestureRecognizer(tap)
        
    }
    
    @objc  func dismissKeyboard() {
        avatarCornerRadius.resignFirstResponder()
    }
    
    
    @IBAction func selectImageType(_ sender: UISegmentedControl) {
        switch imageSegment.selectedSegmentIndex {
        case 0:
            avatar.setAvatar(avatarUrl: "https://data-us.cometchat.io/assets/images/avatars/captainamerica.png")
        case 1:
            avatar.setAvatar(avatarUrl: "", with: "Captain America")
        default:
            break
        }
    }
    
    @IBAction func textFieldValueChanged(_ sender: UITextField) {

        let cornerRadius = CGFloat(truncating: NumberFormatter().number(from: avatarCornerRadius.text ?? "0") ?? 75)

        
        self.avatar.set(cornerRadius: cornerRadius)
    }
    
}




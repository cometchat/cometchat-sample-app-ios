//
//  AvatarModification.swift
//  CometChatSwift
//
//  Created by admin on 24/08/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatUIKitSwift
import CometChatPro

class AvatarModification: UIViewController {
    
    // MARK: OUTLETS
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatar: CometChatAvatar!
    @IBOutlet weak var avatarCornerRadius: UITextField!
    @IBOutlet weak var imageSegment: UISegmentedControl!

    func setupView() {
        DispatchQueue.main.async {
            let blurredView = self.blurView(view: self.view)
            self.view.addSubview(blurredView)
            self.view.sendSubviewToBack(blurredView)
        }
    }
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarView.dropShadow()
        hideKeyboardWhenTappedArround()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemFill
            avatar.setAvatar(avatarUrl: "https://data-us.cometchat.io/assets/images/avatars/captainamerica.png")
        } else {}
        setupView()
    }
    
    //MARK: FUNCTIONS
    fileprivate func hideKeyboardWhenTappedArround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        avatarView.addGestureRecognizer(tap)
    }
    
    @objc  func dismissKeyboard() {
        avatarCornerRadius.resignFirstResponder()
    }
    
    @IBAction func onCloseClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
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

       // self.avatar.set(cornerRadius: CometChatCorner(cornerRadius: CGFloat(truncating: NumberFormatter().number(from: avatarCornerRadius.text ?? "0") ?? 75)))
        
        self.avatar.set(cornerRadius: CometChatCornerStyle(cornerRadius: CGFloat(truncating: NumberFormatter().number(from: avatarCornerRadius.text ?? "0") ?? avatar.bounds.width / 2 as NSNumber)))
    }
}




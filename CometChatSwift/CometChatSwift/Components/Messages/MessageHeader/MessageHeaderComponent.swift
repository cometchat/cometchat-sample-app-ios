//
//  MessageHeaderComponent.swift
//  CometChatSwift
//
//  Created by admin on 06/09/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatPro
import CometChatUIKit
class MessageHeaderComponent: UIViewController {

    @IBOutlet weak var messageHeader: CometChatMessageHeader!
    var user  = User(uid: "superhero2", name: "Captain America")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupUser()
    }
    
    func setupUser(){
        user.avatar = "https://data-us.cometchat.io/assets/images/avatars/captainamerica.png"
        user.status = .online
    }

    func setUpUI(){
        DispatchQueue.main.async {
            self.messageHeader.hide(backButton: false)
            self.messageHeader.set(backButtonIconTint: UIColor.black)
            self.messageHeader.set(user: self.user)
        }

    }

}

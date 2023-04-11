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
    @IBOutlet weak var headerContainer: UIView!
    var user  = User(uid: "superHero2", name: "Captain America")
    
    func setupView() {
        let blurredView = blurView(view: self.view)
        view.addSubview(blurredView)
        view.sendSubviewToBack(blurredView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupUser()
        setupView()
    }
    
    func setupUser() {
        user.avatar = "https://data-us.cometchat.io/assets/images/avatars/captainamerica.png"
        user.status = .online
    }

    func setUpUI() {
        DispatchQueue.main.async {
            self.view.backgroundColor = .systemFill
            self.headerContainer.roundViewCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 20)
            self.headerContainer.dropShadow()
            self.messageHeader.hide(backButton: false)
            self.messageHeader.set(backIconTint: UIColor.black)
            self.messageHeader.set(user: self.user)
        }
    }
    
    @IBAction func onCloseClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

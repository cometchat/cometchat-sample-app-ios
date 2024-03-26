//
//  CallButtonsComponent.swift
//  CometChatSwift
//
//  Created by Ajay Verma on 29/05/23.
//  Copyright © 2023 MacMini-03. All rights reserved.
//

import UIKit
import CometChatSDK
import CometChatUIKitSwift

class CallButtonsComponent: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemFill
        self.containerView.dropShadow()
        setupCallButtons()
        setupView()
    }
    
    func setupCallButtons() {
        #if canImport(CometChatCallsSDK)
        let callingButton = CometChatCallButtons(width: 70, height: 70)
        callingButton.set(controller: self)
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        view.spacing = 10
        view.distribution = .fillEqually
        let user = User(uid: "superhero2", name: "Captain America")
        callingButton.set(user: user)
        view.addArrangedSubview(callingButton)
        
        containerView.addSubview(view)
        containerView.addConstraint(NSLayoutConstraint(item: callingButton, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
        containerView.addConstraint(NSLayoutConstraint(item: callingButton, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0))
        #endif
    }
    
    func setupView() {
        DispatchQueue.main.async {
            let blurredView = self.blurView(view: self.view)
            self.view.addSubview(blurredView)
            self.view.sendSubviewToBack(blurredView)
        }
    }

    @IBAction func didCloseButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}

//
//  SoundManagerComponent.swift
//  CometChatSwift
//
//  Created by admin on 01/09/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatPro
import CometChatUIKit

class SoundManagerComponent: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var incomingMessageBackground: GradientImageView!
    @IBOutlet weak var outgoingMessageBackground: GradientImageView!
    @IBOutlet weak var containerView: UIView!
    
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
        setupUI()
        self.setupView()
    }
    
   

    
    func setupUI() {
        self.view.backgroundColor = .clear
        containerView.dropShadow()
    }
    
    @IBAction func onCloseCLicked(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
    
    @IBAction func playIncomingAudio(_ sender: UIButton) {
        CometChatSoundManager().play(sound: Sound.incomingMessage)
    }
    
    @IBAction func playOutgoingAudio(_ sender: UIButton) {
        CometChatSoundManager().play(sound: Sound.outgoingMessage)
    }
}

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
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.dropShadow()

    }
    @IBAction func playIncomingAudio(_ sender: UIButton) {
        CometChatSoundManager().play(sound: Sound.incomingMessage)
       
    }
    
    @IBAction func playOutgoingAudio(_ sender: UIButton) {
        CometChatSoundManager().play(sound: Sound.outgoingMessage)
        
    }
    
    
}

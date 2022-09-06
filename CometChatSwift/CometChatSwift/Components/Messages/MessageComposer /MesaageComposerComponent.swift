//
//  MesaageComposerComponent.swift
//  CometChatSwift
//
//  Created by admin on 12/08/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatPro
import CometChatUIKit
class MesaageComposerComponent: UIViewController {


    @IBOutlet weak var messageCompser: CometChatMessageComposer!

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    
    open override func loadView() {
        let loadedNib = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        if let contentView = loadedNib?.first as? UIView  {
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view  = contentView
        }
    }

}


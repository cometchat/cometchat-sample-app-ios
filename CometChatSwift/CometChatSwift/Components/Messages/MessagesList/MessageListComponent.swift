//
//  MessageListComponent.swift
//  CometChatSwift
//
//  Created by admin on 12/08/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatPro
import CometChatUIKit
class MessageListComponent: UIViewController {

    @IBOutlet weak var messageListComponent: CometChatMessageList!
    
    var group: Group?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        // Do any additional setup after loading the view.
    }

    open override func loadView() {
        let loadedNib = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        if let contentView = loadedNib?.first as? UIView  {
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view  = contentView
        }
    }
    
    private func setup(){
        guard let group = group else { return }
        messageListComponent.set(group: group)
        
    }

}

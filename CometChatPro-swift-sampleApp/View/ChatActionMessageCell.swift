//
//  ChatActionMessageCell.swift
//  CometChatPro-swift-sampleApp
//
//  Created by Admin1 on 06/03/19.
//  Copyright © 2019 Admin1. All rights reserved.
//

import UIKit

class ChatActionMessageCell: UITableViewCell {

    @IBOutlet weak var actionMessageLabel: UILabel!
    
    var chatMessage : Message! {
        didSet{
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

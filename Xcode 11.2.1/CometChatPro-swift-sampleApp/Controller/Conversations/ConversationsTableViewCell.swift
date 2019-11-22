//
//  ConversationsTableViewCell.swift
//  CometChatUI
//
//  Created by Pushpsen Airekar on 21/11/18.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.
//

import UIKit
import CometChatPro

class ConversationsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var avtar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var unreadCount: UILabel!
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var conversation: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    
    var UID:String!
    var conversationObject: Conversation!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//
//  MessageReceiptCell.swift
//  CometChatPro-swift-sampleApp
//
//  Created by MacMini-03 on 12/09/19.
//  Copyright © 2019 Admin1. All rights reserved.
//

import UIKit

class MessageReceiptCell: UITableViewCell {

    
    @IBOutlet weak var avtar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var readAt: UILabel!
    @IBOutlet weak var deliveredAt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  MoreSettingTableViewCell.swift
//  CometChatPulse-swift-sampleApp
//
//  Created by Admin1 on 04/01/19.
//  Copyright © 2019 Admin1. All rights reserved.
//

import UIKit

class MoreSettingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var settingsLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

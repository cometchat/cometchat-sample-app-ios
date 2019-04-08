//
//  MoreSettingTableViewCell.swift
//  CometChatPro-swift-sampleApp
//
//  Created by Pushpsen Airekar on 04/01/19.
//  Copyright © 2019 Pushpsen Airekar. All rights reserved.
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

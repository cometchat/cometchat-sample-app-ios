//
//  BlockedUserCell.swift
//  CometChatPro-swift-sampleApp
//
//  Created by MacMini-03 on 27/05/19.
//  Copyright © 2019 Admin1. All rights reserved.
//

import UIKit
import CometChatPro

class BlockedUserCell: UITableViewCell {

    @IBOutlet weak var buddyAvtar: UIImageView!
    @IBOutlet weak var buddyName: UILabel!
    @IBOutlet weak var buddyStatus: UILabel!
    @IBOutlet weak var check: UIImageView!
    
    var user:User?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buddyAvtar.layer.cornerRadius = 20
        buddyAvtar.contentMode = .scaleAspectFill
        buddyAvtar.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            check.image = #imageLiteral(resourceName: "checked")
            self.contentView.backgroundColor = UIColor(hexFromString: "7FFF00", alpha: 0.1)
        }else{
            check.image = #imageLiteral(resourceName: "unchecked")
            self.contentView.backgroundColor = UIColor.clear
        }
    }
    
    
    
}

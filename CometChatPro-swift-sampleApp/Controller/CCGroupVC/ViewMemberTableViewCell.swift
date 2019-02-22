//
//  ViewMemberTableViewCell.swift
//  CometChatPro-swift-sampleApp
//
//  Created by Inscripts mac mini  on 03/02/19.
//  Copyright © 2019 Admin1. All rights reserved.
//

import UIKit
import CometChatPro

class ViewMemberTableViewCell: UITableViewCell {
    @IBOutlet weak var buddyAvtar: UIImageView!
    @IBOutlet weak var buddyName: UILabel!
    
    var memberScope:CometChat.GroupMemberScopeType!
    var uid:String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.handleOneOnOneTableViewCellAppearance()
    }
    
    func handleOneOnOneTableViewCellAppearance(){
        buddyAvtar.layer.cornerRadius = 20
        buddyAvtar.contentMode = .scaleAspectFill
        buddyAvtar.clipsToBounds = true
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

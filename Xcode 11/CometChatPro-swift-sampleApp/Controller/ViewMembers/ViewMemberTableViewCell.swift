//
//  ViewMemberTableViewCell.swift
//  CometChatPro-swift-sampleApp
//
//  Created by Inscripts mac mini  on 03/02/19.
//  Copyright © 2019 Pushpsen Airekar. All rights reserved.
//

import UIKit
import CometChatPro

class ViewMemberTableViewCell: UITableViewCell {
    @IBOutlet weak var buddyAvtar: UIImageView!
    @IBOutlet weak var buddyName: UILabel!
    @IBOutlet weak var buddyScope: UILabel!
    
    var memberScope:CometChat.GroupMemberScopeType!
    var uid:String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.handleUsersTableViewCellAppearance()
    }
    
    func handleUsersTableViewCellAppearance(){
        buddyAvtar.layer.cornerRadius = 20
        buddyAvtar.contentMode = .scaleAspectFill
        buddyAvtar.clipsToBounds = true
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}



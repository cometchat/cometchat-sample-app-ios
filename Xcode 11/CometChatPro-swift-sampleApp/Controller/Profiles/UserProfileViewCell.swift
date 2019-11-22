//
//  UserProfileViewCell.swift
//  CometChatPro-swift-sampleApp
//
//  Created by pushpsen airekar on 08/12/18.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.
//

import UIKit

class UserProfileViewCell: UITableViewCell {
    
    @IBOutlet weak var CellLeftImage: UIImageView!
    @IBOutlet weak var CellTitle: UILabel!
    @IBOutlet weak var CellRightImage: UIImageView!
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var leftIconBackgroundView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellBackgroundView.layer.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        //cellBackgroundView.clipsToBounds = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

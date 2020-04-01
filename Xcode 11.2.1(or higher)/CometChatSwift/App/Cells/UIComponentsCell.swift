//
//  UIComponentsCell.swift
//  ios-chat-uikit-app
//
//  Created by CometChat Inc. on 18/12/19.
//  Copyright © 2020 CometChat Inc. All rights reserved.
//

import UIKit

class UIComponentsCell: UITableViewCell {

    @IBOutlet weak var componentName: UILabel!
    @IBOutlet weak var componentDescription: UILabel!
    @IBOutlet weak var cardview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
         self.selectionStyle = .none
        cardview.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

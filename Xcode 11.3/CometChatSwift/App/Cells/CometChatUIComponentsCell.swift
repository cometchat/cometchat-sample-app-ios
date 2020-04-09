//
//  CometChatLauncherCell.swift
//  Demo
//
//  Created by CometChat Inc. on 17/12/19.
//  Copyright © 2020 CometChat Inc. All rights reserved.
//

import UIKit

protocol CometChatUIComponentsCellDelegate: class {
    func didlaunchButtonPressed(_ sender: UIButton)
}


class CometChatUIComponentsCell: UITableViewCell {

   weak var delegate: CometChatUIComponentsCellDelegate?
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        if #available(iOS 13.0, *) {
        } else {}
        
        cardView.dropShadow()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func launchPressed(_ sender: Any) {
        delegate?.didlaunchButtonPressed(sender as! UIButton)
    }
}





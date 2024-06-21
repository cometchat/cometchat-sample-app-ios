//
//  CometChatLauncherCell.swift
//  Demo
//
//  Created by CometChat Inc. on 17/12/19.
//  Copyright © 2020 CometChat Inc. All rights reserved.
//

import UIKit

protocol CometChatUICellDelegate: class {
    func didlaunchButtonPressed(_ sender: UIButton, segmentControl: UISegmentedControl)
}


class CometChatUICell: UITableViewCell {

   weak var delegate: CometChatUICellDelegate?
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var cardView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.dropShadow()
        self.selectionStyle = .none
        self.segmentControl.ensureiOS12Style()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func launchPressed(_ sender: Any) {
        delegate?.didlaunchButtonPressed(sender as! UIButton, segmentControl: segmentControl)
    }
}




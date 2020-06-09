//
//  CometChatLauncherCell.swift
//  Demo
//
//  Created by CometChat Inc. on 17/12/19.
//  Copyright © 2020 CometChat Inc. All rights reserved.
//

import UIKit

protocol CometChatUIScreenCellDelegate: class {
    func didlaunchButtonPressed(_ sender: UIButton, with screenSegment: UISegmentedControl, styleSegment: UISegmentedControl)
}


class CometChatUIScreenCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var screenSegment: UISegmentedControl!
    @IBOutlet weak var styleSegment: UISegmentedControl!
    
    weak var delegate: CometChatUIScreenCellDelegate?
   
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.dropShadow()
        screenSegment.ensureiOS12Style()
        styleSegment.ensureiOS12Style()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func launchPressed(_ sender: Any) {
        delegate?.didlaunchButtonPressed(sender as! UIButton, with: screenSegment, styleSegment: styleSegment)
    }
   
}

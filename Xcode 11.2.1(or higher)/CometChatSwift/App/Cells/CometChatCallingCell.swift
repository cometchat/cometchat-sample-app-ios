//
//  CometChatLauncherCell.swift
//  Demo
//
//  Created by CometChat Inc. on 17/12/19.
//  Copyright © 2020 CometChat Inc. All rights reserved.
//

import UIKit
import  CometChatPro

protocol CometChatCallingCellDelegate: class {
    func didMakeCallButtonPressed(_ sender: UIButton, with userSegment: UISegmentedControl, typeSegment: UISegmentedControl, callTypeSegment: UISegmentedControl)
}


class CometChatCallingCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var userSegment: UISegmentedControl!
    @IBOutlet weak var typeSegment: UISegmentedControl!
    @IBOutlet weak var callType: UISegmentedControl!
    
    weak var delegate: CometChatCallingCellDelegate?
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.dropShadow()
        userSegment.ensureiOS12Style()
        typeSegment.ensureiOS12Style()
        callType.ensureiOS12Style()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func didSelectedTypePressed(_ sender: Any) {
        
        if typeSegment.selectedSegmentIndex == 0 {
            self.userSegment.isHidden = false
        }else{
            self.userSegment.isHidden = true
        }
        
        
    }
    @IBAction func makeCallPressed(_ sender: Any) {
        delegate?.didMakeCallButtonPressed(sender as! UIButton, with: userSegment, typeSegment: typeSegment, callTypeSegment: callType)
    }
   
}

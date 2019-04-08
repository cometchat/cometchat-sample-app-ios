//
//  ChatFileMessageCell.swift
//  CometChatPro-swift-sampleApp
//
//  Created by Pushpsen Airekar on 27/12/18.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.
//

import UIKit
import CometChatPro

class ChatFileMessageCell: UITableViewCell {
    
    // Outlets Declarations
    @IBOutlet weak var fileMessageView: UIView!
    @IBOutlet weak var userAvtar: UIImageView!
    @IBOutlet weak var fileIcon: UIImageView!
    @IBOutlet weak var fileNameLabel: UILabel!
    @IBOutlet weak var fileTypeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeLabel1: UILabel!
    @IBOutlet weak var readReceipts: UIImageView!
    
    // NSLayoutConstraints Declarations
    @IBOutlet weak var fileMessageViewTrailingConstrant: NSLayoutConstraint!
    @IBOutlet weak var fileMessageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var timeLabelTrailingConstraints: NSLayoutConstraint!
    @IBOutlet weak var timeLabelWidthConstraint: NSLayoutConstraint!
    
    
    var isSelf:Bool!
    var isGroup:Bool!
    
    var chatMessage : MediaMessage! {
        didSet{
            
            let myUID = UserDefaults.standard.string(forKey: "LoggedInUserUID")
            if chatMessage.senderUid == myUID{
                isSelf = true
            }else{
                isSelf = false
            }
            
            if chatMessage.senderUid == myUID {
                
                userAvtar.isHidden = true
                timeLabel1.isHidden = false
                
                switch AppAppearance{
                    
                case .AzureRadiance:
                    self.fileMessageView.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
                    fileNameLabel.textColor = UIColor.white
                    fileTypeLabel.textColor = UIColor.white
                    
                case .MountainMeadow:
                    
                    self.fileMessageView.layer.cornerRadius = 15
                    fileMessageView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
                    fileNameLabel.textColor = UIColor.white
                    fileTypeLabel.textColor = UIColor.white
                    
                case .PersianBlue:
                    self.fileMessageView.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
                    
                    fileNameLabel.textColor = UIColor.white
                    fileTypeLabel.textColor = UIColor.white
                case .Custom:
                    
                    self.fileMessageView.layer.cornerRadius = 15
                    fileMessageView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
                    fileNameLabel.textColor = UIColor.white
                    fileTypeLabel.textColor = UIColor.white
                }
            } else {
                userAvtar.isHidden = false
                timeLabel1.isHidden = true
                switch AppAppearance{
                    
                case .AzureRadiance:
                    self.fileMessageView.roundCorners([.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: "E6E9ED")
                    fileNameLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    fileTypeLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    
                case .MountainMeadow:
                    
                    self.fileMessageView.layer.cornerRadius = 15
                    fileMessageView.backgroundColor = UIColor.init(hexFromString: "E6E9ED")
                    fileNameLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    fileTypeLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    
                case .PersianBlue:
                    self.fileMessageView.roundCorners([.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: "E6E9ED")
                    fileNameLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    fileTypeLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    
                case .Custom:
                    
                    self.fileMessageView.layer.cornerRadius = 15
                    fileMessageView.backgroundColor = UIColor.init(hexFromString: "E6E9ED")
                    fileNameLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    fileTypeLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                }
            }
            
            if(chatMessage.receiverType == .group){
                userNameLabel.isHidden = false
            }else{
                userNameLabel.isHidden = true
            }
            
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        // timeLabel.removeFromSuperview()
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userNameLabel.isHidden = true
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if(isSelf == true){
            readReceipts.isHidden = false
            userNameLabel.isHidden = true
            timeLabelWidthConstraint.constant = 0
            timeLabelTrailingConstraints.constant = 10
            fileMessageViewTrailingConstrant.constant = 10
            //fileMessageView.widthConstraint?.constant = 230
            fileMessageViewLeadingConstraint.constant = 65
            //timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        }else{
            readReceipts.isHidden = true
            userNameLabel.isHidden = false
        
        }
        
        
    }
    
    
    
    
}

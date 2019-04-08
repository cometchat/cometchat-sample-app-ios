//
//  ChatTextMessageCell.swift
//  CometChatPro-swift-sampleApp
//
//  Created by Pushpsen Airekar on 27/12/18.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.
//

import UIKit
import CometChatPro

class ChatTextMessageCell: UITableViewCell {
    
    let messageLabel = UILabel()
    let userNameLabel = UILabel()
    var url: NSURL!
    var data: NSData!
    var avtarURLString:String!
    let messageBackgroundView = UIView()
    let messageTimeLabel = UILabel()
    let userAvatarImageView = UIImageView()
    let readRecipts = UIImageView()
    var messageLabelLeadingConstraint : NSLayoutConstraint!
    var messageLabelTrailingConstraint : NSLayoutConstraint!
    var timeLabelLeadingConstraint : NSLayoutConstraint!
    var timeLabelTrailingConstraint : NSLayoutConstraint!
    var enableOutGoingConstraintForbubble = Bool()
    
    
    var chatMessage : TextMessage! {
        didSet{
            
            messageLabel.text = chatMessage.text
            userNameLabel.text = (chatMessage.sender?.name ?? " ") + " :"
            userNameLabel.font = userNameLabel.font.withSize(12)
            let date = Date(timeIntervalSince1970: TimeInterval(chatMessage.sentAt))
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "HH:mm:a"
            dateFormatter1.timeZone = NSTimeZone.local
            let dateString : String = dateFormatter1.string(from: date)
            messageTimeLabel.text =  dateString
            
            readRecipts.image = #imageLiteral(resourceName: "readReceiptDelivered")
            
            if(chatMessage.sender?.avatar != ""){
                url = NSURL(string: ((chatMessage.sender?.avatar) ?? nil) ?? " ")
                userAvatarImageView.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_user"))
            }else{
                userAvatarImageView.image = UIImage(named: "default_user")
            }
            let myUID = UserDefaults.standard.string(forKey: "LoggedInUserUID")
            if(chatMessage.senderUid == myUID){
                messageLabelLeadingConstraint.isActive = false
                messageLabelTrailingConstraint.isActive = true
                timeLabelTrailingConstraint.isActive = true
                timeLabelLeadingConstraint.isActive = false
                userNameLabel.textColor = UIColor.darkGray
                userAvatarImageView.isHidden = true
                userNameLabel.isHidden = true
                readRecipts.isHidden = false
                switch AppAppearance{
                    
                case .AzureRadiance:
                    self.messageBackgroundView.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
                    messageLabel.textColor = UIColor.white
                    
                case .MountainMeadow:
                    
                    self.messageBackgroundView.layer.cornerRadius = 15
                    messageBackgroundView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
                    messageLabel.textColor = UIColor.white
                    
                case .PersianBlue:
                    self.messageBackgroundView.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
                    
                    messageLabel.textColor = UIColor.white
                case .Custom:
                    
                    self.messageBackgroundView.layer.cornerRadius = 15
                    messageBackgroundView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
                    messageLabel.textColor = UIColor.white
                }
                
            }else {
                readRecipts.isHidden = true
                messageLabelLeadingConstraint.isActive = true
                messageLabelTrailingConstraint.isActive = false
                timeLabelTrailingConstraint.isActive = false
                timeLabelLeadingConstraint.isActive = true
                userNameLabel.textColor = UIColor.darkGray
                userAvatarImageView.isHidden = false
                if(chatMessage.receiverType == .group){
                    userNameLabel.isHidden = false
                }else{
                    userNameLabel.isHidden = true
                }
                
                switch AppAppearance{
                    
                case .AzureRadiance:
                    
                    self.messageBackgroundView.roundCorners([.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: "E6E9ED")
                    messageLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    
                case .MountainMeadow:
                    
                    self.messageBackgroundView.layer.cornerRadius = 15
                    messageBackgroundView.backgroundColor = UIColor.init(hexFromString: "E6E9ED")
                    messageLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    
                case .PersianBlue:
                    
                    self.messageBackgroundView.roundCorners([.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: "E6E9ED")
                    messageLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    
                case .Custom:
                    
                    self.messageBackgroundView.layer.cornerRadius = 15
                    messageBackgroundView.backgroundColor = UIColor.init(hexFromString: "E6E9ED")
                    messageLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                }
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        messageBackgroundView.clipsToBounds = true
        messageBackgroundView.layer.cornerRadius = 15
        messageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(userNameLabel)
        addSubview(messageBackgroundView)
        addSubview(messageLabel)
        addSubview(messageTimeLabel)
        addSubview(readRecipts)
        
        messageLabel.backgroundColor = UIColor.clear
        messageLabel.numberOfLines = 0
        
        readRecipts.translatesAutoresizingMaskIntoConstraints = false
        readRecipts.widthAnchor.constraint(lessThanOrEqualToConstant: 20).isActive = true
        readRecipts.heightAnchor.constraint(lessThanOrEqualToConstant: 20).isActive = true
        readRecipts.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3).isActive = true
        readRecipts.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3).isActive = true
        readRecipts.clipsToBounds = true
        
       
        
        //Setting Constraints for MessageLabel
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: messageBackgroundView.leadingAnchor, constant: 0).isActive = true
        userNameLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 15).isActive = true
        userNameLabel.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -15).isActive = true
        userNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10).isActive = true
        
        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        messageBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -12).isActive = true
        messageBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -12).isActive = true
        messageBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant:12).isActive = true
        messageBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 12).isActive = true
        
        messageLabelLeadingConstraint =  messageLabel.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: 17)
        messageLabelTrailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        
        messageTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabelLeadingConstraint = messageTimeLabel.leadingAnchor.constraint(equalTo: messageBackgroundView.trailingAnchor, constant: 5)
        timeLabelTrailingConstraint = messageTimeLabel.trailingAnchor.constraint(equalTo: messageBackgroundView.leadingAnchor, constant: -5)
        messageTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        messageTimeLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        messageTimeLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 12).isActive = true
        messageTimeLabel.font = messageTimeLabel.font.withSize(10)
        messageTimeLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
        addSubview(userAvatarImageView)
        userAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        userAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        userAvatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        userAvatarImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 25).isActive = true
        userAvatarImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 25).isActive = true
        userAvatarImageView.clipsToBounds = true
        userAvatarImageView.layer.cornerRadius = 12.5
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



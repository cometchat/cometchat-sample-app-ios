//
//  ChatMediaMessageCell.swift
//  CometChatPro-swift-sampleApp
//
//  Created by Pushpsen Airekar on 23/04/19.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.


import UIKit
import CometChatPro

class ChatMediaMessageCell: UITableViewCell {
    
    let fileNameLabel = UILabel()
    let fileTypeLabel = UILabel()
    let userNameLabel = UILabel()
    var url: NSURL!
    var data: NSData!
    var avtarURLString:String!
    let messageBackgroundView = UIView()
    let messageTimeLabel = UILabel()
    let userAvatarImageView = UIImageView()
    let fileIconImageView = UIImageView()
    let readRecipts = UIImageView()
    var messageLabelLeadingConstraint : NSLayoutConstraint!
    var messageLabelTrailingConstraint : NSLayoutConstraint!
    var timeLabelLeadingConstraint : NSLayoutConstraint!
    var timeLabelTrailingConstraint : NSLayoutConstraint!
    var enableOutGoingConstraintForbubble = Bool()
    
    var chatMessage : MediaMessage! {
        didSet{
            
            let fileName:String = chatMessage.attachment?.fileName ?? "Processing"
            let fileType:String = chatMessage.attachment?.fileExtension ?? "- - -"
            fileNameLabel.text = "            " + fileName
            fileTypeLabel.font = fileTypeLabel.font.withSize(12)
            fileTypeLabel.text = fileType.uppercased()
            fileIconImageView.contentMode = .scaleAspectFit
            userNameLabel.text = (chatMessage.sender?.name ?? " ") + " :"
            userNameLabel.font = userNameLabel.font.withSize(12)
            let date = Date(timeIntervalSince1970: TimeInterval(chatMessage.sentAt))
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "HH:mm:a"
            dateFormatter1.timeZone = NSTimeZone.local
            let dateString : String = dateFormatter1.string(from: date)
            if chatMessage.sentAt == 0 {
                messageTimeLabel.text =  "Sending..."
            }else{
                messageTimeLabel.text =  dateString
            }
            readRecipts.image = #imageLiteral(resourceName: "wait")
            
            DispatchQueue.main.async {  [weak self] in
                guard let strongSelf = self
                    else
                {
                    return
                }
                
                if self!.chatMessage.sentAt == 0{
                     self!.readRecipts.image = #imageLiteral(resourceName: "wait")
                }else if strongSelf.chatMessage.readAt > 0.0 {
                    strongSelf.readRecipts.image = #imageLiteral(resourceName: "seen")
                }
                else if strongSelf.chatMessage.deliveredAt > 0.0 {
                    strongSelf.readRecipts.image = #imageLiteral(resourceName: "delivered")
                }else{
                    strongSelf.readRecipts.image = #imageLiteral(resourceName: "sent")
                }
            }
            
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
                if chatMessage.receiverType == .user{
                    readRecipts.isHidden = false
                }else{
                    readRecipts.isHidden = true
                }
                
                switch AppAppearance{
                    
                case .AzureRadiance:
                    self.messageBackgroundView.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
                    fileNameLabel.textColor = UIColor.white
                    fileTypeLabel.textColor = UIColor.white
                    
                case .MountainMeadow:
                    
                    self.messageBackgroundView.layer.cornerRadius = 15
                    messageBackgroundView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
                    fileNameLabel.textColor = UIColor.white
                    fileTypeLabel.textColor = UIColor.white
                    
                case .PersianBlue:
                    self.messageBackgroundView.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
                    fileNameLabel.textColor = UIColor.white
                    fileTypeLabel.textColor = UIColor.white
                case .Custom:
                    
                    self.messageBackgroundView.layer.cornerRadius = 15
                    messageBackgroundView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
                    fileNameLabel.textColor = UIColor.white
                    fileTypeLabel.textColor = UIColor.white
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
                    fileNameLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    fileTypeLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    
                case .MountainMeadow:
                    
                    self.messageBackgroundView.layer.cornerRadius = 15
                    messageBackgroundView.backgroundColor = UIColor.init(hexFromString: "E6E9ED")
                    fileNameLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    fileTypeLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    
                case .PersianBlue:
                    
                    self.messageBackgroundView.roundCorners([.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: "E6E9ED")
                    fileNameLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    fileTypeLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    
                case .Custom:
                    
                    self.messageBackgroundView.layer.cornerRadius = 15
                    messageBackgroundView.backgroundColor = UIColor.init(hexFromString: "E6E9ED")
                    fileNameLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                    fileTypeLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
                }
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        messageBackgroundView.clipsToBounds = true
        messageBackgroundView.layer.cornerRadius = 15
        messageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(userNameLabel)
        addSubview(messageBackgroundView)
        addSubview(fileNameLabel)
        addSubview(fileTypeLabel)
        addSubview(fileIconImageView)
        addSubview(messageTimeLabel)
        addSubview(readRecipts)
        
        fileNameLabel.backgroundColor = UIColor.clear
        fileNameLabel.numberOfLines = 0
        fileTypeLabel.backgroundColor = UIColor.clear
        fileNameLabel.numberOfLines = 0
        
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
        userNameLabel.bottomAnchor.constraint(equalTo: fileNameLabel.topAnchor, constant: -15).isActive = true
        userNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        messageBackgroundView.topAnchor.constraint(equalTo: fileNameLabel.topAnchor, constant: -12).isActive = true
        messageBackgroundView.leadingAnchor.constraint(equalTo: fileNameLabel.leadingAnchor, constant: -12).isActive = true
        messageBackgroundView.bottomAnchor.constraint(equalTo: fileTypeLabel.bottomAnchor, constant:12).isActive = true
        messageBackgroundView.trailingAnchor.constraint(equalTo: fileNameLabel.trailingAnchor, constant: 12).isActive = true
        messageBackgroundView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        messageBackgroundView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        fileIconImageView.translatesAutoresizingMaskIntoConstraints = false
        fileIconImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        fileIconImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        fileIconImageView.leadingAnchor.constraint(equalTo: messageBackgroundView.leadingAnchor, constant: 5).isActive = true
        fileIconImageView.topAnchor.constraint(equalTo: messageBackgroundView.topAnchor, constant: 7.5).isActive = true
        
        fileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fileNameLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10).isActive = true
        fileNameLabel.leadingAnchor.constraint(equalTo: messageBackgroundView.leadingAnchor, constant: 50).isActive = true
        fileNameLabel.bottomAnchor.constraint(equalTo: fileTypeLabel.topAnchor, constant: 0).isActive = true
        fileNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        fileTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        fileTypeLabel.topAnchor.constraint(equalTo: fileNameLabel.bottomAnchor, constant: 10).isActive = true
        fileTypeLabel.leadingAnchor.constraint(equalTo: fileNameLabel.leadingAnchor, constant: 45).isActive = true
        fileTypeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        fileTypeLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        messageLabelLeadingConstraint =  fileNameLabel.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: 17)
        messageLabelTrailingConstraint = fileNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        
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

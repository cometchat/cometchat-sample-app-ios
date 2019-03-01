//
//  ChatFileMessageCell.swift
//  CometChatPro-swift-sampleApp
//
//  Created by pushpsen airekar on 25/02/19.
//  Copyright © 2019 Admin1. All rights reserved.
//

import UIKit

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
    
    // NSLayoutConstraints Declarations
    @IBOutlet weak var fileMessageViewTrailingConstrant: NSLayoutConstraint!
    @IBOutlet weak var fileMessageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var timeLabelTrailingConstraints: NSLayoutConstraint!
    @IBOutlet weak var timeLabelWidthConstraint: NSLayoutConstraint!
    
    
    
    var isSelf:Bool!
    var isGroup:Bool!
    
    var chatMessage : Message! {
        didSet{
        
            print("chatMessage File: \(chatMessage.messageText)")
            isSelf = chatMessage.isSelf
            isGroup = chatMessage.isGroup
            print("isSelf value is \(isSelf)")
            if  isSelf == true {
                
                userAvtar.isHidden = true
                timeLabel1.isHidden = false
              //  fileMessageViewTrailingConstrant.constant = 10
                
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
            
            if(isGroup == true){
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

        
        print("isSelf is: \(String(describing: isSelf))")
        print("isGroup is: \(String(describing: isGroup))")
        userNameLabel.isHidden = true
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if(isSelf == true){
            userNameLabel.isHidden = true
            timeLabel.isHidden = true
            timeLabelWidthConstraint.constant = 0
            timeLabelTrailingConstraints.constant = 10
            fileMessageViewTrailingConstrant.constant = 0
            //fileMessageView.widthConstraint?.constant = 230
            fileMessageViewLeadingConstraint.constant = 65
            //timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        }
        
        
       
        //timeLabel.removeFromSuperview()
        // Configure the view for the selected state
    }

        
//        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//            super.init(style: style, reuseIdentifier: reuseIdentifier)
    
//            chatImage.layer.cornerRadius = 20
//            chatImage.clipsToBounds=true
//            chatImage.translatesAutoresizingMaskIntoConstraints = false
//            bubbleBackgroundView.backgroundColor = .yellow
//            bubbleBackgroundView.layer.cornerRadius = 20
//            bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
//            bubbleBackgroundView.clipsToBounds=true
//            addSubview(userNameLabel)
//            addSubview(bubbleBackgroundView)
//            addSubview(messageTimeLabel)
//            addSubview(chatImage)
//
//            chatImage.translatesAutoresizingMaskIntoConstraints = false
//            userNameLabel.translatesAutoresizingMaskIntoConstraints = false
//            // lets set up some constraints for our label
//
//
//
//
//            let constraints = [
//
//                userNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: -250),
//                userNameLabel.bottomAnchor.constraint(equalTo: chatImage.bottomAnchor, constant: 10),
//                userNameLabel.leadingAnchor.constraint(equalTo: chatImage.leadingAnchor, constant: 0),
//                userNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
//
//                chatImage.topAnchor.constraint(equalTo: topAnchor, constant: 30),
//                chatImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
//                chatImage.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
//                chatImage.heightAnchor.constraint(lessThanOrEqualToConstant: 250),
//
//                bubbleBackgroundView.topAnchor.constraint(equalTo: chatImage.topAnchor, constant: 0),
//                bubbleBackgroundView.leadingAnchor.constraint(equalTo: chatImage.leadingAnchor, constant: 0),
//                bubbleBackgroundView.bottomAnchor.constraint(equalTo: chatImage.bottomAnchor, constant: 0),
//                bubbleBackgroundView.trailingAnchor.constraint(equalTo: chatImage.trailingAnchor, constant: 0),
//                ]
//            NSLayoutConstraint.activate(constraints)
//
//            aleadingConstraint = chatImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
//            aleadingConstraint.isActive = false
//
//            atrailingConstraint = chatImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
//            atrailingConstraint.isActive = false
//
//            // user avatar constrains //
//            aleadingConstraint =  chatImage.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: 5)
//            atrailingConstraint = chatImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
//
//            addSubview(userAvatarImageView)
//
//            userAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
//            userAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 13).isActive = true
//            userAvatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
//            userAvatarImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 25).isActive = true
//            userAvatarImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 25).isActive = true
//            userAvatarImageView.clipsToBounds = true
//            userAvatarImageView.layer.cornerRadius = 13
//            userAvatarImageView.image = UIImage(named: "default_user")
//
//            // user avatar constrains //
//
//
//            // time label constrains //
//            messageTimeLabel.translatesAutoresizingMaskIntoConstraints = false
//            timeLabelLeadingConstraint = messageTimeLabel.leadingAnchor.constraint(equalTo: bubbleBackgroundView.trailingAnchor, constant: 5)
//            timeLabelTrailingConstraint = messageTimeLabel.trailingAnchor.constraint(equalTo: bubbleBackgroundView.leadingAnchor, constant: -5)
//            messageTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
//            messageTimeLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
//            messageTimeLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 12).isActive = true
//            messageTimeLabel.font = messageTimeLabel.font.withSize(12)
//            // messageTimeLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
//            // time label constrains //
//        }
//
//        required init?(coder aDecoder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
    
    }

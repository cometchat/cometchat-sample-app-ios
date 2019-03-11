//
//  ChatMessageCell.swift
//  ImageChatApp
//
//  Copyright © 2018 MacDevs. All rights reserved.
//

import UIKit

class ChatImageMessageCell: UITableViewCell {
   
    var url: NSURL!
    var data: NSData!
    let chatImage = UIImageView()
    var urlString = String()
    let bubbleBackgroundView = UIView()
     let userNameLabel = UILabel()
    let messageTimeLabel = UILabel()
    let userAvatarImageView = UIImageView()
    private var aleadingConstraint: NSLayoutConstraint!
    private var atrailingConstraint: NSLayoutConstraint!
    var timeLabelLeadingConstraint : NSLayoutConstraint!
    var timeLabelTrailingConstraint : NSLayoutConstraint!
    
    var chatMessage:Message! {
        didSet {
            urlString = chatMessage.messageText
           // chatImage.image = #imageLiteral(resourceName: "default_Pending")
            userNameLabel.text = "\(chatMessage.userName):"
            userNameLabel.font = userNameLabel.font.withSize(12)
            userNameLabel.textColor = UIColor.darkGray
            userNameLabel.isHidden = true
            print("urlString: \(urlString)")
            url = NSURL(string: urlString)
            if(chatMessage.avatarURL != ""){
                url = NSURL(string: chatMessage.avatarURL)
                userAvatarImageView.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_user"))
            }else{
                userAvatarImageView.image = UIImage(named: "default_user")
            }
            messageTimeLabel.text = chatMessage.time
            chatImage.contentMode = .scaleAspectFill
            bubbleBackgroundView.backgroundColor = chatMessage.isSelf ? .white : UIColor(white: 0.80, alpha: 1)
            
            if chatMessage.isSelf == true {
                aleadingConstraint.isActive = false
                atrailingConstraint.isActive = true
                timeLabelLeadingConstraint.isActive = false
                timeLabelTrailingConstraint.isActive = true
                userAvatarImageView.isHidden = true

            } else {
                userAvatarImageView.isHidden = false
                aleadingConstraint.isActive = true
                atrailingConstraint.isActive = false
                timeLabelLeadingConstraint.isActive = true
                timeLabelTrailingConstraint.isActive = false
                userNameLabel.isHidden = false
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        chatImage.layer.cornerRadius = 20
        chatImage.clipsToBounds=true
        chatImage.translatesAutoresizingMaskIntoConstraints = false
        bubbleBackgroundView.backgroundColor = .yellow
        bubbleBackgroundView.layer.cornerRadius = 20
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        bubbleBackgroundView.clipsToBounds=true
        addSubview(userNameLabel)
        addSubview(bubbleBackgroundView)
        addSubview(messageTimeLabel)
        addSubview(chatImage)
        
        chatImage.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        // lets set up some constraints for our label
  
        
        let constraints = [
            
            userNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: -250),
            userNameLabel.bottomAnchor.constraint(equalTo: chatImage.bottomAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: chatImage.leadingAnchor, constant: 0),
            userNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            chatImage.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            chatImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
            chatImage.widthAnchor.constraint(equalToConstant: 250),
            chatImage.heightAnchor.constraint(equalToConstant: 250),
            
            bubbleBackgroundView.topAnchor.constraint(equalTo: chatImage.topAnchor, constant: 0),
            bubbleBackgroundView.leadingAnchor.constraint(equalTo: chatImage.leadingAnchor, constant: 0),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: chatImage.bottomAnchor, constant: 0),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: chatImage.trailingAnchor, constant: 0),
            ]
        NSLayoutConstraint.activate(constraints)
        
        
        aleadingConstraint = chatImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        aleadingConstraint.isActive = false
        
        atrailingConstraint = chatImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        atrailingConstraint.isActive = false
        
        // user avatar constrains //
        aleadingConstraint =  chatImage.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: 5)
        atrailingConstraint = chatImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        
        addSubview(userAvatarImageView)
        
        userAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        userAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 13).isActive = true
        userAvatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        userAvatarImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 25).isActive = true
        userAvatarImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 25).isActive = true
        userAvatarImageView.clipsToBounds = true
        userAvatarImageView.layer.cornerRadius = 13
        userAvatarImageView.image = UIImage(named: "default_user")
        
        // user avatar constrains //
        
        
        // time label constrains //
        messageTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabelLeadingConstraint = messageTimeLabel.leadingAnchor.constraint(equalTo: bubbleBackgroundView.trailingAnchor, constant: 5)
        timeLabelTrailingConstraint = messageTimeLabel.trailingAnchor.constraint(equalTo: bubbleBackgroundView.leadingAnchor, constant: -5)
        messageTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        messageTimeLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        messageTimeLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 12).isActive = true
        messageTimeLabel.font = messageTimeLabel.font.withSize(12)
       // messageTimeLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
       // time label constrains //
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}







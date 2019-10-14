//
//  ChatMessageCell.swift
//  ImageChatApp
//
//  Copyright © 2018 MacDevs. All rights reserved.
//

import UIKit
import  AVKit
import AVFoundation
import CometChatPro

class ChatVideoMessageCell: UITableViewCell {
    
    var videoURL: NSURL!
    var data: NSData!
    let chatImage = UIImageView()
    let bubbleBackgroundView = UIView()
    let userNameLabel = UILabel()
    let playButton = UIButton()
    let messageTimeLabel = UILabel()
    let userAvatarImageView = UIImageView()
    let readRecipts = UIImageView()
    private var aleadingConstraint: NSLayoutConstraint!
    private var atrailingConstraint: NSLayoutConstraint!
    var timeLabelLeadingConstraint : NSLayoutConstraint!
    var timeLabelTrailingConstraint : NSLayoutConstraint!
    
    var chatMessage:MediaMessage! {
        didSet {
            
            videoURL = URL(string: chatMessage.url!.decodeUrl()!) as NSURL?
            userNameLabel.text = (chatMessage.sender?.name ?? " ") + " :"
            userNameLabel.font = userNameLabel.font.withSize(12)
            userNameLabel.textColor = UIColor.darkGray
            userNameLabel.isHidden = true
            
            if(chatMessage.sender?.avatar != ""){
                let url = NSURL(string: (chatMessage.sender?.avatar ?? " "))
                userAvatarImageView.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_user"))
            }else{
                userAvatarImageView.image = UIImage(named: "default_user")
            }
            let date = Date(timeIntervalSince1970: TimeInterval(chatMessage.sentAt))
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "HH:mm:a"
            dateFormatter1.timeZone = NSTimeZone.local
            let dateString : String = dateFormatter1.string(from: date)
            let url = NSURL(string: chatMessage.url ?? "nil")
                       if chatMessage.sentAt == 0 {
                                      messageTimeLabel.text =  "Sending..."
                                     chatImage.image = #imageLiteral(resourceName: "default_pendingVideo")
                                  }else{
                                      messageTimeLabel.text =  dateString
                                      chatImage.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_video"))
                                  }
            chatImage.contentMode = .scaleAspectFill
            let myUID = UserDefaults.standard.string(forKey: "LoggedInUserUID")
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
            bubbleBackgroundView.backgroundColor = chatMessage.senderUid == myUID ? .white : UIColor(white: 0.80, alpha: 1)
            
            if chatMessage.senderUid == myUID {
                aleadingConstraint.isActive = false
                atrailingConstraint.isActive = true
                timeLabelLeadingConstraint.isActive = false
                timeLabelTrailingConstraint.isActive = true
                userAvatarImageView.isHidden = true
                if chatMessage.receiverType == .user{
                    readRecipts.isHidden = false
                }else{
                    readRecipts.isHidden = true
                }
                
            } else {
                userAvatarImageView.isHidden = false
                aleadingConstraint.isActive = true
                atrailingConstraint.isActive = false
                timeLabelLeadingConstraint.isActive = true
                timeLabelTrailingConstraint.isActive = false
                readRecipts.isHidden = true
            }
            
            if(chatMessage.receiverType == .group && chatMessage.senderUid != myUID){
                userNameLabel.isHidden = false
            }else{
                userNameLabel.isHidden = true
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
        addSubview(readRecipts)
        
        chatImage.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        // lets set up some constraints for our label
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
        readRecipts.translatesAutoresizingMaskIntoConstraints = false
        readRecipts.widthAnchor.constraint(lessThanOrEqualToConstant: 20).isActive = true
        readRecipts.heightAnchor.constraint(lessThanOrEqualToConstant: 20).isActive = true
        readRecipts.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3).isActive = true
        readRecipts.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13).isActive = true
        readRecipts.clipsToBounds = true
       
        
        // time label constrains //
        messageTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabelLeadingConstraint = messageTimeLabel.leadingAnchor.constraint(equalTo: bubbleBackgroundView.trailingAnchor, constant: 5)
        timeLabelTrailingConstraint = messageTimeLabel.trailingAnchor.constraint(equalTo: bubbleBackgroundView.leadingAnchor, constant: -5)
        messageTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        messageTimeLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        messageTimeLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 12).isActive = true
        messageTimeLabel.font = messageTimeLabel.font.withSize(10)
        // messageTimeLabel.textColor = UIColor.init(hexFromString: "3C3B3B")
        // time label constrains //
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}







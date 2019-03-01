//
//  ChatAudioMessageCell.swift
//  CometChatPro-swift-sampleApp
//
//  Created by pushpsen airekar on 26/02/19.
//  Copyright © 2019 Admin1. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ChatAudioMessageCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userAvtar: UIImageView!
    @IBOutlet weak var audioMessageView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var audioPlaybutton: UIButton!
    @IBOutlet weak var timeLabel1: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    // NSLayoutConstraints Declarations
    @IBOutlet weak var audioMessageViewTrailingConstrant: NSLayoutConstraint!
    @IBOutlet weak var audioMessageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var timeLabelTrailingConstraints: NSLayoutConstraint!
    @IBOutlet weak var timeLabelWidthConstraint: NSLayoutConstraint!
    
    var isSelf:Bool!
    var isGroup:Bool!
    var playURL:String!
    
    var player : AVPlayer?
    
    var chatMessage : Message! {
        didSet{
            
            print("chatMessage Audio: \(chatMessage.messageText)")
            isSelf = chatMessage.isSelf
            isGroup = chatMessage.isGroup
            playURL = chatMessage.messageText.decodeUrl()
            print("isSelf value is \(String(describing: isSelf))")
            if  isSelf == true {
                
                userAvtar.isHidden = true
                timeLabel1.isHidden = false
                //  fileMessageViewTrailingConstrant.constant = 10
                
                switch AppAppearance{
                    
                case .AzureRadiance:
                    self.audioMessageView.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
//                    audioMessageView.textColor = UIColor.white
//                    audioMessageView.textColor = UIColor.white
                    
                case .MountainMeadow:
                    
                    self.audioMessageView.layer.cornerRadius = 15
                    audioMessageView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
//                    fileNameLabel.textColor = UIColor.white
//                    fileTypeLabel.textColor = UIColor.white
                    
                case .PersianBlue:
                    self.audioMessageView.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
//
//                    fileNameLabel.textColor = UIColor.white
//                    fileTypeLabel.textColor = UIColor.white
                case .Custom:
                    
                    self.audioMessageView.layer.cornerRadius = 15
                    audioMessageView.backgroundColor = UIColor.init(hexFromString: UIAppearanceColor.RIGHT_BUBBLE_BACKGROUND_COLOR)
//                    fileNameLabel.textColor = UIColor.white
//                    fileTypeLabel.textColor = UIColor.white
                }
            } else {
                userAvtar.isHidden = false
                
                switch AppAppearance{
                    
                case .AzureRadiance:
                    self.audioMessageView.roundCorners([.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: "E6E9ED")
                   
                    
                case .MountainMeadow:
                    
                    self.audioMessageView.layer.cornerRadius = 15
                    audioMessageView.backgroundColor = UIColor.init(hexFromString: "E6E9ED")
                  
                    
                case .PersianBlue:
                    self.audioMessageView.roundCorners([.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner ], radius: 15, borderColor: .clear, borderWidth: 0, withBackgroundColor: "E6E9ED")
                   
                    
                case .Custom:
                    
                    self.audioMessageView.layer.cornerRadius = 15
                    audioMessageView.backgroundColor = UIColor.init(hexFromString: "E6E9ED")
                  
                }
            }
            
            if(isGroup == true){
                userNameLabel.isHidden = false
            }else{
                userNameLabel.isHidden = true
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func duration(for resource: String) -> Double {
        let asset = AVURLAsset(url: URL(fileURLWithPath: resource))
        return Double(CMTimeGetSeconds(asset.duration))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        if(isSelf == true){
            userNameLabel.isHidden = true
            timeLabel.isHidden = true
            timeLabelWidthConstraint.constant = 0
            timeLabelTrailingConstraints.constant = 10
            audioMessageViewTrailingConstrant.constant = 0
            //audioMessageView.widthConstraint?.constant = 230
            audioMessageViewLeadingConstraint.constant = 40
           // timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
            
        }
        // Configure the view for the selected state
    }
    
    func playUsingAVPlayer(url: URL) {
        player = AVPlayer(url: url)
        player?.play()
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        print("Calling from playButtonPressed")
        let time:String = "\(duration(for: playURL))"
    
         durationLabel.text = String(format:"%.2f",time)
        
        guard let url = URL(string: playURL.decodeUrl()!) else {
            print("Invalid URL")
            return
        }

        if(audioPlaybutton.currentImage == UIImage(named: "play.png")){
            print("audioPlayed")
            playUsingAVPlayer(url: url)
            audioPlaybutton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        }else{
            print("audioPaused")
            player?.pause()
            audioPlaybutton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }

    }
    
    
}

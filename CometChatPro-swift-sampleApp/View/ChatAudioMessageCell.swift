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

    @IBOutlet weak var playBackSlider: UISlider!
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
    var morePreciseTime:Double!
    var playerItem:AVPlayerItem!
    
    var player : AVPlayer?
    
    var chatMessage : Message! {
        didSet{
            durationLabel.isHidden = true
            print("chatMessage Audio: \(chatMessage.messageText)")
            isSelf = chatMessage.isSelf
            isGroup = chatMessage.isGroup
            playURL = chatMessage.messageText.decodeUrl()
            print("isSelf value is \(String(describing: isSelf))")
           
            if  isSelf == true {
                userAvtar.isHidden = true
                timeLabel1.isHidden = false
                timeLabel.isHidden = true
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
                timeLabel1.isHidden = true
                 timeLabel.isHidden = false
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
            
            if( isGroup == true && isSelf == false){
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
           audioMessageView.translatesAutoresizingMaskIntoConstraints = false
           let constraint = [audioMessageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),audioMessageView.leadingAnchor.constraint(equalTo: timeLabel1.trailingAnchor, constant: 10)]
            NSLayoutConstraint.activate(constraint)
            
            audioMessageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
            audioMessageView.widthAnchor.constraint(equalToConstant: 280)
            audioMessageViewLeadingConstraint.constant = (UIScreen.main.bounds.width + 60) - UIScreen.main.bounds.width
        }else{
            audioMessageView.translatesAutoresizingMaskIntoConstraints = true
        }
    }
    
    func playUsingAVPlayer(url: URL) {
        player = AVPlayer(url: url)
        player?.play()
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
        
        print("Calling from playButtonPressed")
        playBackSlider.minimumValue = 0.0
        let time:String = "\(duration(for: playURL))"
        morePreciseTime = Double(time)
        print("Time is : \(String(describing:  morePreciseTime?.string(maximumFractionDigits: 2)))")
        durationLabel.text = "\(String(describing: morePreciseTime!.string(maximumFractionDigits: 2)))"
        durationLabel.isHidden = false
        playBackSlider.maximumValue = Float(morePreciseTime)


        //playBackSlider.setValue(Float((player?.currentItem?.currentTime().seconds)!), animated: true)
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
    
//    func playerInit()  {
//        guard let url = URL(string: playURL) else {
//
//            return
//        }
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//            print("AVAudioSession Category Playback OK")
//            do {
//                try AVAudioSession.sharedInstance().setActive(true)
//                print("AVAudioSession is Active")
//                playerItem = AVPlayerItem(url: url)
//                player = AVPlayer(playerItem: playerItem)
//
//                player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, 1), queue: DispatchQueue.main) { (CMTime) -> Void in
//                    if self.player!.currentItem?.status == .readyToPlay {
//                        let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());
//                        self.playBackSlider.value = Float ( time )
//                        self.playBackSlider.minimumValue = 0
//
//                        let duration : CMTime = self.playerItem!.asset.duration
//                        let seconds : Float64 = CMTimeGetSeconds(duration)
//
//                        self.playBackSlider.maximumValue = Float(seconds)
//                        self.durationLabel.text = self.secondsToHoursMinutesSeconds(seconds: seconds)
//                        self.durationLabel.text = self.secondsToHoursMinutesSeconds(seconds: Double( self.playBackSlider.value ))
//
//                    }
//                }
//
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            }
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
//
//    func secondsToHoursMinutesSeconds (seconds : Double) -> (String) {
//        let (hr,  minf) = modf (seconds / 3600)
//        let (min, secf) = modf (60 * minf)
//        return ("\(Int(hr)):\(Int(min)):\(Int(60 * secf))")
//    }
    
    @IBAction func sliderMoved(_ sender: Any) {
     
        
        
    }
    
    
}

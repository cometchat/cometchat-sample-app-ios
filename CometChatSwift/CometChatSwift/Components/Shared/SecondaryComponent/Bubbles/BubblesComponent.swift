//
//  BubblesComponent.swift
//  CometChatSwift
//
//  Created by Ajay Verma on 27/05/23.
//  Copyright © 2023 MacMini-03. All rights reserved.
//

import UIKit
import CometChatSDK
import CometChatUIKitSwift

enum BubbleType {
    case textBubble, imageBubble, videoBubble, audioBubble, fileBubble
}

class BubblesComponent: UIViewController {
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var container: UIView!
    var bubbleType: BubbleType?
    let imageUrl = "https://data-us.cometchat.io/2379614bd4db65dd/media/1682517838_2050398854_08d684e835e3c003f70f2478f937ed57.jpeg"
    let videoUrl = "https://data-us.cometchat.io/2379614bd4db65dd/media/1682517886_527585446_3e8e02fc506fa535eecfe0965e1a2024.mp4"
    let videoThumbnailUrl = "https://data-us.cometchat.io/2379614bd4db65dd/media/1682666720_1080372877_5efc5c9d02a7133f3d25e67e7eca4572.png"
    let audioUrl = "https://data-us.cometchat.io/2379614bd4db65dd/media/1682517916_1406731591_130612180fb2e657699814eb52817574.mp3"
    let fileUrl = "https://data-us.cometchat.io/2379614bd4db65dd/media/1682517934_233027292_069741a92a2f641eb428ba6d12ccb9af.pdf"
    
    ///Life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemFill
        self.shadowView.dropShadow()
        addBubble()
        setupView()
    }
    
    func setupView() {
        DispatchQueue.main.async {
            let blurredView = self.blurView(view: self.view)
            self.view.addSubview(blurredView)
            self.view.sendSubviewToBack(blurredView)
        }
    }
    
    func addBubble() {
        switch bubbleType {
            
        case .textBubble:
            showTextBubble()
            break
            
        case .imageBubble:
            showImageBubble()
            break
            
        case .videoBubble:
            showVideoBubble()
            break
            
        case .audioBubble:
            showAudioBubble()
            break
            
        case .fileBubble:
            showFileBubble()
            break
            
        case .none:
            break
        }
        
    }
    
    func showTextBubble() {
        let textBubble = CometChatTextBubble()
        textBubble.set(text: "Hello, how are you?")
        textBubble.set(cornerRadius: CometChatCornerStyle(cornerRadius: 10.0))
        textBubble.set(backgroundColor: CometChatTheme.palatte.secondary)
        container.addSubview(textBubble)
        container.addConstraint(NSLayoutConstraint(item: textBubble, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: container, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
        container.addConstraint(NSLayoutConstraint(item: textBubble, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: container, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0))
    }
    
    func showImageBubble() {
        let imageBubble = CometChatImageBubble()
        imageBubble.set(cornerRadius: CometChatCornerStyle(cornerRadius: 10.0))
        imageBubble.set(controller: self)
        imageBubble.set(backgroundColor: CometChatTheme.palatte.secondary)
        imageBubble.set(imageUrl: imageUrl)
        imageBubble.set(caption: "")
        container.addSubview(imageBubble)
        container.addConstraint(NSLayoutConstraint(item: imageBubble, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: container, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
        container.addConstraint(NSLayoutConstraint(item: imageBubble, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: container, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0))
        
    }
    
    func showVideoBubble() {
        let videoBubble = CometChatVideoBubble()
        videoBubble.set(controller: self)
        videoBubble.set(corner: CometChatCornerStyle(cornerRadius: 10.0))
        videoBubble.set(backgroundColor: CometChatTheme.palatte.secondary)
        videoBubble.set(thumnailImageUrl: videoThumbnailUrl)
        videoBubble.set(videoURL: videoUrl)
        container.addSubview(videoBubble)
        container.addConstraint(NSLayoutConstraint(item: videoBubble, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: container, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
        container.addConstraint(NSLayoutConstraint(item: videoBubble, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: container, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0))
    }
    
    func showAudioBubble() {
        let audioBubble = CometChatAudioBubble()
        audioBubble.set(controller: self)
        audioBubble.set(backgroundColor: CometChatTheme.palatte.secondary)
        audioBubble.set(cornerRadius: CometChatCornerStyle(cornerRadius: 10.0))
        audioBubble.set(title: "Music")
        audioBubble.set(subTitle: "Disco")
        audioBubble.set(fileURL: audioUrl)
        container.addSubview(audioBubble)
        container.addConstraint(NSLayoutConstraint(item: audioBubble, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: container, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
        container.addConstraint(NSLayoutConstraint(item: audioBubble, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: container, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0))
 
    }
    
    func showFileBubble() {
        let fileBubble = CometChatFileBubble()
        fileBubble.set(controller: self)
        fileBubble.set(title: "File")
        fileBubble.set(subTitle: "Resume")
        fileBubble.set(cornerRadius: CometChatCornerStyle(cornerRadius: 10.0))
        fileBubble.set(backgroundColor: CometChatTheme.palatte.secondary)
        fileBubble.set(fileUrl: fileUrl)
        container.addSubview(fileBubble)
        container.addConstraint(NSLayoutConstraint(item: fileBubble, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: container, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
        container.addConstraint(NSLayoutConstraint(item: fileBubble, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: container, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0))
    }
    
    @IBAction func didBackButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

}


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
    case textBubble, imageBubble, videoBubble, audioBubble, fileBubble, formBubble, cardBubble
}

class BubblesComponent: UIViewController {
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
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
            
        case .formBubble:
            showFormBubble()
            
        case .cardBubble:
            showCardBubble()
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
    
    func showFormBubble() {
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(scrollView)
        heightConstraint.constant = 300
        NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: container.topAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
                                     scrollView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                                     scrollView.trailingAnchor.constraint(equalTo: container.trailingAnchor)])
        
        let formBubble = CometChatFormBubble()
        formBubble.set(formMessage: formMessageData())
        formBubble.isUserInteractionEnabled = false
        scrollView.addSubview(formBubble)
        formBubble.translatesAutoresizingMaskIntoConstraints = false
        heightConstraint.constant = 300
        NSLayoutConstraint.activate([formBubble.topAnchor.constraint(equalTo: scrollView.topAnchor),
                                     formBubble.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                                     formBubble.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                                     formBubble.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)])
    }
    
    func showCardBubble() {
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(scrollView)
        NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: container.topAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
                                     scrollView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                                     scrollView.trailingAnchor.constraint(equalTo: container.trailingAnchor)])
        
        let cardBubble = CometChatCardBubble()
        cardBubble.set(controller: self)
        cardBubble.set(cardMessage: cardMessageData())
        cardBubble.isUserInteractionEnabled = false
        container.addSubview(cardBubble)
        cardBubble.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(cardBubble)
        cardBubble.translatesAutoresizingMaskIntoConstraints = false
        heightConstraint.constant = 300
        NSLayoutConstraint.activate([cardBubble.topAnchor.constraint(equalTo: scrollView.topAnchor),
                                     cardBubble.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                                     cardBubble.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                                     cardBubble.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)])
    }
    
    func showQuickView() {
        let formBubble = CometChatFormBubble()
        formBubble.set(controller: self)
        formBubble.set(formMessage: formMessageData())
        container.addSubview(formBubble)
        container.addConstraint(NSLayoutConstraint(item: formBubble, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: container, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
        container.addConstraint(NSLayoutConstraint(item: formBubble, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: container, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0))
    }
    
    @IBAction func didBackButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    func formMessageData() -> FormMessage {
        let interactiveMessage = InteractiveMessage()
        interactiveMessage.messageCategory = .interactive
        
        let jsonString:[String:Any] = [
            "goalCompletionText": "Goal completed YAY",
            "title":"Information form",
            "formFields":[
                [
                    "defaultValue" : "",
                    "elementId" : "element1",
                    "elementType" : "textInput",
                    "label" : "Name",
                    "maxLines" : 1,
                    "optional" : false
                ],
                [
                    "elementId" : "element2",
                    "elementType" : "textInput",
                    "label" : "Last Name",
                    "maxLines" : 1,
                    "optional" : false
                ],
                [
                    "defaultValue" : "",
                    "elementId" : "element3",
                    "elementType" : "textInput",
                    "label" : "Address",
                    "maxLines" : 5,
                    "optional" : false
                ],
                [
                    "defaultOption" : "",
                    "elementId" : "element4",
                    "elementType" : "dropdown",
                    "label" : "Country",
                    "optional" : false,
                    "options" :                             [
                        [
                            "label" : "INDIA",
                            "value" : "option1"
                        ],
                        [
                            "label" : "AUSTRALIA",
                            "value" : "option2"
                        ],
                        [
                            "label" : "RUSSIA",
                            "value" : "option3"
                        ],
                        [
                            "label" : "AMERICA",
                            "value" : "option4"
                        ]
                    ]
                ],
                [
                    "defaultValue" :                             [
                    ],
                    "elementId" : "element5",
                    "elementType" : "checkbox",
                    "label" : "Country",
                    "optional" : false,
                    "options" :                             [
                        [
                            "label" : "INDIA",
                            "value" : "option1"
                        ],
                        [
                            "label" : "AUSTRALIA",
                            "value" : "option2"
                        ],
                        [
                            "label" : "RUSSIA",
                            "value" : "option3"
                        ],
                        [
                            "label" : "AMERICA",
                            "value" : "option4"
                        ]
                    ]
                ],
                [
                    "defaultValue" : "",
                    "elementId" :  "element6",
                    "elementType" : "singleSelect",
                    "label" : "Country",
                    "optional" : false,
                    "options" : [
                        [
                            "label" : "INDIA",
                            "value" : "option1"
                        ],
                        [
                            "label" : "AUSTRALIA",
                            "value" : "option2"
                        ]
                    ]
                ],
                [
                    "defaultValue" : "option1",
                    "elementId" : "element7",
                    "elementType" : "radio",
                    "label" : "Country",
                    "optional" : false,
                    "options" : [
                        [
                            "label" : "INDIA",
                            "value" : "option1"
                        ],
                        [
                            "label" : "AUSTRALIA",
                            "value" : "option2"
                        ],
                        [
                            "label" : "RUSSIA",
                            "value" : "option3"
                        ],
                        [
                            "label" : "AMERICA",
                            "value" : "option4"
                        ]
                    ]
                ],
                [
                    "action" : [
                        "actionType" : "urlNavigation",
                        "url" : "https://www.cometchat.com/"
                    ],
                    "buttonText" : "About us",
                    "disableAfterInteracted" : false,
                    "elementId" : "element9",
                    "elementType" : "button"
                ]
            ],
            "submitElement" : [
                "action" : [
                    "actionType" : "apiAction",
                    "dataKey" : "CometChatData",
                    "headers" : [
                        "Content-Type" : "application/json",
                        "apiKey" : "5797f2d3d103d7d78f085eb46bfd14d5c45ddfdf",
                        "appId" : "10893f2ae68f59",
                        "onBehalfOf" : "superhero1"
                    ],
                    "method" : "POST",
                    "payload" : [
                        "category" : "message",
                        "data" :                                 [
                            "text" : "Thanks For filling the Form!"
                        ],
                        "receiver" : "group_1695921003310",
                        "receiverType" : "group",
                        "type" : "text"
                    ] as [String : Any],
                    "url" : "https://10893f2ae68f59.api-us.cometchat-staging.com/v3.0/messages"
                ] as [String : Any],
                "buttonText" : "Submit",
                "disableAfterInteracted" : true,
                "elementId" : "element8",
                "elementType" : "button"
            ] as [String : Any]
        ]
        interactiveMessage.interactiveData = jsonString
        let goal = InteractionGoal()
        goal.elementIds = ["element9","element8"]
        goal.interactionType = .allOf
        
        interactiveMessage.interactionGoal = goal
        interactiveMessage.allowSenderInteraction = true
        interactiveMessage.type = "form"
        interactiveMessage.receiverType = .user
        interactiveMessage.receiverUid = "superhero2"
        interactiveMessage.muid = "1697025959995609"
        interactiveMessage.senderUid = CometChat.getLoggedInUser()?.uid ?? ""
        interactiveMessage.sender = CometChat.getLoggedInUser()
        return FormMessage.formInteractive(interactiveMessage)
    }
    
    func cardMessageData() -> CardMessage {
        let interactiveMessage = InteractiveMessage()
        interactiveMessage.messageCategory = .interactive
        
        let jsonString:[String:Any] = [
            "imageUrl" : "https://images.unsplash.com/photo-1682687982470-8f1b0e79151a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
            "text" : "👋 🆕 ❤️ 🆓 ⚒️ = Welcome to your new favorite free tool! This emoji translator will help you decipher even the most complex strings of emojis so you’re never out of the loop. Use it to translate messages and get emoji definitions on the fly." +
            "\n\n" +
            "✨ Introducing our New Personalized Card Messages! ✨" +
            "\n\n" +
            "💌💁‍♀️ Want to make your gifts more special? Now it's easy with our personalized card messages! 👩‍💼🖍",
            "cardActions": [
                [
                    "elementType": "button1",
                    "elementId": "element8",
                    "enabled": true,
                    "buttonText": "Press it",
                    "action": [
                        "actionType" : "apiAction",
                        "dataKey" : "CometChatData",
                        "headers" :                                 [
                            "Content-Type" : "application/json",
                            "apiKey" : "5797f2d3d103d7d78f085eb46bfd14d5c45ddfdf",
                            "appId" : "10893f2ae68f59",
                            "onBehalfOf" : "superhero1"
                        ]
                    ],"payload" : [
                            "category" : "message",
                            "data" : [
                                "text" : "Thanks For filling the Form!",
                            ],
                            "receiver" : "vivek",
                            "receiverType" : "user",
                            "type" : "text",
                        ],
                        "url" : "https://10893f2ae68f59.api-us.cometchat-staging.com/v3.0/messages"
                    ],
                [
                    "action" :                             [
                        "actionType" : "urlNavigation",
                        "url" : "https://www.cometchat.com/",
                    ],
                    "buttonText" : "Navigate",
                    "disableAfterInteracted" : true,
                    "elementId" : "element10",
                    "elementType" : "button"
                ],
                [
                    "elementType": "button",
                    "elementId": "element9",
                    "enabled": true,
                    "buttonText": "Press it",
                    "action": [
                        "actionType" : "apiAction",
                        "dataKey" : "CometChatData",
                        "headers" :                                 [
                            "Content-Type" : "application/json",
                            "apiKey" : "5797f2d3d103d7d78f085eb46bfd14d5c45ddfdf",
                            "appId" : "10893f2ae68f59",
                            "onBehalfOf" : "superhero1"
                        ]
                    ],"payload" : [
                            "category" : "message",
                            "data" : [
                                "text" : "Thanks For filling the Form!",
                            ],
                            "receiver" : "vivek",
                            "receiverType" : "user",
                            "type" : "text",
                        ],
                        "url" : "https://10893f2ae68f59.api-us.cometchat-staging.com/v3.0/messages"
                    ]
            ]
        ]
        interactiveMessage.interactiveData = jsonString
        let goal = InteractionGoal()
        goal.elementIds = ["element9","element8"]
        goal.interactionType = .anyOf
        
        interactiveMessage.interactionGoal = goal
        interactiveMessage.allowSenderInteraction = true
        interactiveMessage.type = "card"
        interactiveMessage.receiverType = .user
        interactiveMessage.receiverUid = "superhero2"
        interactiveMessage.muid = "1697025959995609"
        return CardMessage.cardInteractive(interactiveMessage)
    }
}


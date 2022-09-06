//
//  MessageReceiptCell.swift
//  CometChatSwift
//
//  Created by admin on 31/08/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatPro
import CometChatUIKit
class MessageReceiptCell: UITableViewCell {
    
    @IBOutlet weak var messageReceipt : UILabel!
    @IBOutlet weak var messageReceiptContainer : UIView!
    @IBOutlet weak var messageReceiptImage : CometChatMessageReceipt!
    
    var textMessage =  TextMessage(receiverUid: "superhero", text: "Good Morning", receiverType: .user)

    override func awakeFromNib() {
        super.awakeFromNib()
        messageReceiptContainer.dropShadow()
       
    }
    
    var index : Int? {
        didSet {
            switch index {
            case 0:
                textMessage.sentAt = 0
                textMessage.deliveredAt = 0.0
                textMessage.readAt = 0.0
                textMessage.metaData = ["error": false]
                messageReceipt.text = "Progress State"

            case 1:
                textMessage.sentAt = 1657543565
                textMessage.deliveredAt = 0.0
                textMessage.readAt = 0.0
                textMessage.metaData = ["error": false]
                messageReceipt.text = "Sent Receipt"

                
            case 2:
                textMessage.sentAt = 1657543565
                textMessage.deliveredAt = 1657543577.0
                textMessage.readAt = 0.0
                textMessage.metaData = ["error": false]
                messageReceipt.text = "Deliver Receipt"
                
            case 3:
                textMessage.sentAt = 1657543565
                textMessage.deliveredAt = 1657543577.0
                textMessage.readAt = 1657543577.0
                textMessage.metaData = ["error": false]
                messageReceipt.text = "Read Receipt"
               
                    
            case 4:
                textMessage.metaData = ["error": true]
                messageReceipt.text = "Error State"
                
            default:
                break
            }
            messageReceiptImage.set(receipt: textMessage)
        }
    }

    
}

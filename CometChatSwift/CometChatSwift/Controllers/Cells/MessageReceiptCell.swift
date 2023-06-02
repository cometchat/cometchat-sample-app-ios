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
    @IBOutlet weak var messageReceiptImage : CometChatReceipt!
    
    var textMessage =  TextMessage(receiverUid: "superhero", text: "Good Morning", receiverType: .user)

    override func awakeFromNib() {
        super.awakeFromNib()
        messageReceiptContainer.dropShadow()
        messageReceiptContainer.layer.borderWidth = 0.2
        messageReceiptContainer.layer.borderColor = UIColor.lightGray.cgColor

    }
    
    var index : Int? {
        didSet {
            switch index {
            case 0:
                messageReceipt.text = "Progress State"
                messageReceiptImage.set(receipt: .inProgress)

            case 1:
                messageReceipt.text = "Sent Receipt"
                messageReceiptImage.set(receipt: .sent)
                
            case 2:
                messageReceipt.text = "Deliver Receipt"
                messageReceiptImage.set(receipt: .delivered)
            case 3:
                messageReceipt.text = "Read Receipt"
                messageReceiptImage.set(receipt: .read)
                    
            case 4:
                messageReceipt.text = "Error State"
                messageReceiptImage.set(receipt: .failed)
                
            default:
                break
            }
           
        }
    }
}

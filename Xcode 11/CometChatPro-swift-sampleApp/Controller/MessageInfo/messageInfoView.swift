//
//  messageInfoView.swift
//  CometChatPro-swift-sampleApp
//
//  Created by MacMini-03 on 12/09/19.
//  Copyright © 2019 Admin1. All rights reserved.
//

import UIKit
import  CometChatPro

class messageInfoView: UITableViewController {
    
    var message: BaseMessage!
    var receipts: [MessageReceipt] = [MessageReceipt]()
    fileprivate let textCellID = "textCCell"
    fileprivate let imageCellID = "imageCell"
    fileprivate let videoCellID = "videoCell"
    fileprivate let actionCellID = "actionCell"
    fileprivate let mediaCellID = "mediaCell"
    fileprivate let deletedCellID = "deleteCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.handleMessageInfoVCAppearance()
        self.fetchMessageInfo()
    }
    
    
    internal func fetchMessageInfo(){
    
        CometChat.getMessageReceipts(message.id, onSuccess: { (fetchedReceipts) in
            print("getMessageReceipts onSuccess: \(fetchedReceipts)")
            
            if fetchedReceipts != nil {
            self.receipts = fetchedReceipts
                for receipt in fetchedReceipts {
                    print("receipt \(receipt.stringValue())")
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()

                }
            }
            
            
        }) { (error) in
            print("getMessageReceipts \(String(describing: error))")
        }
    }
    
    
    
    func handleMessageInfoVCAppearance() {
    
        //registering Cells
        tableView.register(ChatTextMessageCell.self, forCellReuseIdentifier: textCellID)
        tableView.register(ChatImageMessageCell.self, forCellReuseIdentifier: imageCellID)
        tableView.register(ChatVideoMessageCell.self, forCellReuseIdentifier: videoCellID)
        tableView.register(ChatMediaMessageCell.self, forCellReuseIdentifier: mediaCellID)
        tableView.register(ChatDeletedMessageCell.self, forCellReuseIdentifier: deletedCellID)
        let actionNib  = UINib.init(nibName: "ChatActionMessageCell", bundle: nil)
        self.tableView.register(actionNib, forCellReuseIdentifier: actionCellID)
        let messageReciptNib  = UINib.init(nibName: "MessageReceiptCell", bundle: nil)
        self.tableView.register(messageReciptNib, forCellReuseIdentifier: "messageReceiptsCell")
        self.tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        
        // NavigationBar Buttons Appearance
        
        let backButtonImage = UIImageView(image: UIImage(named: "back_arrow"))
        backButtonImage.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let backBTN = UIBarButtonItem(image: backButtonImage.image,
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBTN
        backBTN.tintColor = UIColor.init(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate

    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0) {
        return 1
        }else{
          return receipts.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

            return 35
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return NSLocalizedString("Message", comment: "")
        }else{
            return NSLocalizedString("Message Receipts", comment: "")
        }
    }
    


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell:UITableViewCell = UITableViewCell()
        
        if  indexPath.section == 0 && indexPath.row == 0 {
            
            switch message.messageType{
                
            case .text:
                
                // Forms Cell for message type of TextMessage
                var textMessageCell = ChatTextMessageCell()
                textMessageCell = tableView.dequeueReusableCell(withIdentifier: textCellID, for: indexPath) as! ChatTextMessageCell
                textMessageCell.chatMessage = (message as? TextMessage)!
                textMessageCell.selectionStyle = .none
                textMessageCell.isUserInteractionEnabled = true
                return textMessageCell
                
            case .image where message.deletedAt > 0.0:
                
                // Forms Cell for message type of image Message when the message is deleted
                var deletedCell = ChatDeletedMessageCell()
                deletedCell = tableView.dequeueReusableCell(withIdentifier: deletedCellID, for: indexPath) as! ChatDeletedMessageCell
                deletedCell.chatMessage = (message as? MediaMessage)!
                deletedCell.selectionStyle = .none
                deletedCell.isUserInteractionEnabled = false
                return deletedCell
                
            case .image:
                
                // Forms Cell for message type of image Message
                var imageMessageCell = ChatImageMessageCell()
                imageMessageCell = tableView.dequeueReusableCell(withIdentifier: imageCellID , for: indexPath) as! ChatImageMessageCell
                imageMessageCell.chatMessage = (message as? MediaMessage)!
                let url = NSURL(string: (message as? MediaMessage)?.attachment?.fileUrl ?? "")
                imageMessageCell.chatImage.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_Pending"))
                imageMessageCell.selectionStyle = .none
                return imageMessageCell
                
            case .video where message.deletedAt > 0.0:
                
                // Forms Cell for message type of video Message when the message is deleted
                var deletedCell = ChatDeletedMessageCell()
                deletedCell = tableView.dequeueReusableCell(withIdentifier: deletedCellID, for: indexPath) as! ChatDeletedMessageCell
                deletedCell.chatMessage = (message as? MediaMessage)!
                deletedCell.selectionStyle = .none
                deletedCell.isUserInteractionEnabled = false
                return deletedCell
                
            case .video:
                
                // Forms Cell for message type of video Message
                var videoMessageCell = ChatVideoMessageCell()
                videoMessageCell = tableView.dequeueReusableCell(withIdentifier: videoCellID , for: indexPath) as! ChatVideoMessageCell
                videoMessageCell.chatMessage = (message as? MediaMessage)!
                videoMessageCell.selectionStyle = .none
                return videoMessageCell
                
            case .audio where message.deletedAt > 0.0:
                
                // Forms Cell for message type of audio Message when the video is deleted
                var deletedCell = ChatDeletedMessageCell()
                deletedCell = tableView.dequeueReusableCell(withIdentifier: deletedCellID, for: indexPath) as! ChatDeletedMessageCell
                deletedCell.chatMessage = (message as? MediaMessage)!
                deletedCell.selectionStyle = .none
                deletedCell.isUserInteractionEnabled = false
                return deletedCell
                
            case .audio:
                
                // Forms Cell for message type of audio Message
                var mediaMessageCell = ChatMediaMessageCell()
                mediaMessageCell = tableView.dequeueReusableCell(withIdentifier: mediaCellID, for: indexPath) as! ChatMediaMessageCell
                mediaMessageCell.chatMessage = (message as? MediaMessage)!
                mediaMessageCell.selectionStyle = .none
                mediaMessageCell.fileIconImageView.image = #imageLiteral(resourceName: "play")
                return mediaMessageCell
                
            case .file where message.deletedAt > 0.0:
                
                // Forms Cell for message type of file Message when the video is deleted
                var deletedCell = ChatDeletedMessageCell()
                deletedCell = tableView.dequeueReusableCell(withIdentifier: deletedCellID, for: indexPath) as! ChatDeletedMessageCell
                deletedCell.chatMessage = (message as? MediaMessage)!
                deletedCell.selectionStyle = .none
                deletedCell.isUserInteractionEnabled = false
                return deletedCell
                
            case .file:
                
                // Forms Cell for message type of file Message
                var mediaMessageCell = ChatMediaMessageCell()
                mediaMessageCell = tableView.dequeueReusableCell(withIdentifier: mediaCellID, for: indexPath) as! ChatMediaMessageCell
                mediaMessageCell.chatMessage = (message as? MediaMessage)!
                mediaMessageCell.selectionStyle = .none
                mediaMessageCell.fileIconImageView.image = #imageLiteral(resourceName: "file")
                return mediaMessageCell
                
            case .custom: break
                
            case .groupMember: break
                
            }
        }else{
            
            // Forms Cell for message type of file Message
            var messageReceiptsCell = MessageReceiptCell()
            
            let receipt = receipts[indexPath.row]
            let calendar = Calendar.current
            let deliveredAt = Date(timeIntervalSince1970: TimeInterval(receipt.deliveredAt))
            let readAt = Date(timeIntervalSince1970: TimeInterval(receipt.deliveredAt))
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "HH:mm a"
            dateFormatter1.timeZone = NSTimeZone.local
            let readAtString : String = dateFormatter1.string(from: readAt)
            let deliveredAtString : String = dateFormatter1.string(from: deliveredAt)
            messageReceiptsCell = tableView.dequeueReusableCell(withIdentifier: "messageReceiptsCell", for: indexPath) as! MessageReceiptCell
            messageReceiptsCell.name.text = receipt.sender?.name
            let url = NSURL(string: ((receipt.sender?.avatar) ?? nil) ?? " ")
            messageReceiptsCell.avtar.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_user"))
            
            if calendar.isDateInToday(deliveredAt){
                 messageReceiptsCell.deliveredAt.text = "Today at \(deliveredAtString)"
            }else if calendar.isDateInYesterday(deliveredAt){
                messageReceiptsCell.deliveredAt.text = "Yesterday at \(deliveredAtString)"
            }else {
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "dd/mm/yyyy HH:mm a"
                dateFormatter1.timeZone = NSTimeZone.local
                dateFormatter1.locale = NSLocale.current
                let timeStampString : String = dateFormatter1.string(from: deliveredAt)
                messageReceiptsCell.deliveredAt.text = "\(timeStampString)"
            }
            
            
            if calendar.isDateInToday(readAt){
                messageReceiptsCell.readAt.text = "Today at \(readAtString)"
            }else if calendar.isDateInYesterday(readAt){
                messageReceiptsCell.readAt.text = "Yesterday at \(readAtString)"
            }else{
                messageReceiptsCell.readAt.text = "\(readAt.millisecondsSince1970)"
            }
            return messageReceiptsCell
            
        }
        return cell
    }
 
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section != 0{
            return 90
        }else{
            return UITableView.automaticDimension
        }
    }

    
    
}

//
//  MessageReceiptModification.swift
//  CometChatSwift
//
//  Created by admin on 24/08/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatUIKit
import CometChatPro
class MessageReceiptModification: UIViewController {

    @IBOutlet weak var receiptView: UIView!
    @IBOutlet weak var messageReceipt: CometChatMessageReceipt!
    @IBOutlet weak var messageStatus: UISegmentedControl!
    @IBOutlet weak var receiptTableView: UITableView!
    var textMessage =  TextMessage(receiverUid: "superhero", text: "Good Morning", receiverType: .user)
    var identifier = "MessageReceiptCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageStatus.selectedSegmentIndex = 0
        textMessage.sentAt = 0
        textMessage.deliveredAt = 0.0
        textMessage.readAt = 0.0
        messageReceipt.set(receipt: textMessage)
        setupTableView()
    }
    
    
    private func setupTableView() {
        self.receiptTableView.delegate = self
        self.receiptTableView.dataSource = self
        self.receiptTableView.separatorStyle = .none

        let receiptCell  = UINib.init(nibName: identifier, bundle: nil)
        self.receiptTableView.register(receiptCell, forCellReuseIdentifier: identifier)
    }
    


    
    @IBAction func messageReceiptTypePressed(_ sender: UISegmentedControl) {
        switch messageStatus.selectedSegmentIndex {
        case 0:
            textMessage.sentAt = 0
            textMessage.deliveredAt = 0.0
            textMessage.readAt = 0.0
            textMessage.metaData = ["error": false]

        case 1:
            textMessage.sentAt = 1657543565
            textMessage.deliveredAt = 0.0
            textMessage.readAt = 0.0
            textMessage.metaData = ["error": false]

            
        case 2:
            textMessage.sentAt = 1657543565
            textMessage.deliveredAt = 1657543577.0
            textMessage.readAt = 0.0
            textMessage.metaData = ["error": false]
            
        case 3:
            textMessage.sentAt = 1657543565
            textMessage.deliveredAt = 1657543577.0
            textMessage.readAt = 1657543577.0
            textMessage.metaData = ["error": false]
           
                
        case 4:
            textMessage.metaData = ["error": true]
            
        default:
            break
        }
        messageReceipt.set(receipt: textMessage)
    }

}

extension MessageReceiptModification: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let receiptCell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MessageReceiptCell else { fatalError()}
        receiptCell.index = indexPath.row
        receiptCell.selectionStyle = .none
        return receiptCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

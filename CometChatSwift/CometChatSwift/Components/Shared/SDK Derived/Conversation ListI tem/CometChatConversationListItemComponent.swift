//
//  CometChatConversationListItemComponent.swift
//  CometChatSwift
//
//  Created by admin on 11/08/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatUIKit
import CometChatPro
class CometChatConversationListItemComponent: UIViewController{
    
    //MARK: OUTLETS
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var listItemContainer: UIView!
    
    
    //MARK: Declaration of Variables
    var tableView: UITableView! = nil
    var safeArea: UILayoutGuide!
    private let identifier = "CometChatConversationListItem"

    
    
    var conversation = Conversation()
    var user = User(uid: "superhero2", name: "CometChat")
    var user2 = User(uid: "superhero1", name: "SpiderMan")
    var textMesssage = TextMessage(receiverUid: "superhero2", text: "You have new message", receiverType: .user)
   
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        self.listItemContainer.dropShadow()
        self.setupTableView()
        self.setUpConversation()
    }
    
    func setUpConversation(){
        conversation.conversationWith = self.user
        conversation.lastMessage?.messageCategory = .message
        user.avatar = "https://data-us.cometchat.io/assets/images/avatars/spiderman.png"
        textMesssage.deliveredAt = 123456
        user.status = .online
        textMesssage.sender = user2
        conversation.unreadMessageCount = 8
        conversation.lastMessage = textMesssage
        conversation.conversationType = .user
    }
    
    
    private func setupTableView() {
        if #available(iOS 13.0, *) {
            self.registerCells()
        }
        
    }
    
    private func registerCells(){
       let cell = UINib(nibName: identifier, bundle: CometChatUIKit.bundle )
       self.table.register(cell, forCellReuseIdentifier: identifier)

    }
    
    
}


// MARK: - Table view Methods

extension CometChatConversationListItemComponent: UITableViewDelegate , UITableViewDataSource {

    
    /// This method specifiesnumber of rows in CometChatConversationList
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - section: An index number identifying a section of tableView .
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    /// This method specifies the height for row in CometChatConversationList
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - section: An index number identifying a section of tableView .
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    /// This method specifies the view for user  in CometChatConversationList
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - section: An index number identifying a section of tableView.
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CometChatConversationListItem else { return UITableViewCell() }
        
         cell.set(conversation: conversation)
        
        return cell
    }
    
}


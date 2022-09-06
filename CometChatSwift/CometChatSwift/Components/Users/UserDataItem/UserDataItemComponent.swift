//
//  DataItemComponent.swift
//  CometChatSwift
//
//  Created by admin on 12/08/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatUIKit
import CometChatPro

//enum selectUserType {
//    case userType
//    case groupType
//}

class UserDataItemComponent: UIViewController {
    
    //MARK: OUTLETS
    

    @IBOutlet weak var tableDataItem: UITableView!
   
   
    @IBOutlet weak var dataItemContainer: UIView!
    
    @IBOutlet weak var itemDescription: UILabel!
    
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var dataItemContainerHeight: NSLayoutConstraint!
    //MARK: Declaration of Variables
    
    private let identifier = "CometChatDataItem"
    
    var isUser : Bool  = false
    var isGroup : Bool = false
    
    var user               = User(uid: "superhero1", name: "CometChat")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataItemContainer.dropShadow()
        self.setupTableView()
        setupUser()
        manageHeight()
    }
    
    
    func setupUser(){
        user.avatar = "https://data-us.cometchat.io/assets/images/avatars/spiderman.png"
    }
    
    func manageHeight(){
        self.dataItemContainerHeight.constant = 250
    }
    
    private func setupTableView() {
        self.tableDataItem.delegate = self
        self.tableDataItem.dataSource = self
        self.registerCells()
    }
    
    
    
    private func registerCells(){
        let cell = UINib(nibName: identifier, bundle: CometChatUIKit.bundle )
        self.tableDataItem.register(cell, forCellReuseIdentifier: identifier)
        
    }
}


// MARK: - Table view Methods

extension UserDataItemComponent: UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CometChatDataItem else { return UITableViewCell() }
        
        cell.set(user: user)
        
        
        return cell
    }
    
}



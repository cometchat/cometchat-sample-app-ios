//
//  DataItem.swift
//  CometChatSwift
//
//  Created by admin on 06/09/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatUIKit
import CometChatPro
class DataItem: UIViewController {
    
    @IBOutlet weak var dataItemContainer: UIView!
    @IBOutlet weak var dataItemTable: UITableView!
    
    private let identifier = "CometChatDataItem"
    var user    = User(uid: "superhero1", name: "CometChat")
    var group   = Group(guid: "Guid123", name: "CometChatTeam", groupType: .public, password: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataItemContainer.dropShadow()
        self.setupTableView()
        setupUser()
        self.group.membersCount = 4
        
    }
    
    func setupUser(){
        user.avatar = "https://data-us.cometchat.io/assets/images/avatars/spiderman.png"
    }
    
    
    private func setupTableView() {
        self.dataItemTable.delegate = self
        self.dataItemTable.dataSource = self
        self.registerCells()
        
    }
    
    private func registerCells(){
        let cell = UINib(nibName: identifier, bundle: CometChatUIKit.bundle )
        self.dataItemTable.register(cell, forCellReuseIdentifier: identifier)
        
    }
    
}


// MARK: - Table view Methods

extension DataItem: UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        
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
        
        switch indexPath.section {
        case 0:
            cell.set(user: user)
        case 1:
            cell.set(group: group)
        default:
            break
        }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header  = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
        let lable = UILabel(frame: CGRect(x: 10, y: 0, width: header.frame.size.width, height: header.frame.size.height - 4 ))
        header.addSubview(lable)
        
        switch section {
        case 0:
            lable.text = "User"
        case 1:
            lable.text = "Group"
            
        default:
            break
        }
        
        return header
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
        
    }
    
}

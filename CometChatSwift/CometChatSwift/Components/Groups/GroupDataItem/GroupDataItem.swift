//
//  GroupDataItem.swift
//  CometChatSwift
//
//  Created by admin on 06/09/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatUIKit
import CometChatPro
class GroupDataItem: UIViewController {
    
    @IBOutlet weak var dataItemContainer: UIView!
    @IBOutlet weak var dataItemTable: UITableView!
    
    private let identifier = "CometChatDataItem"
    var group   = Group(guid: "Guid123", name: "CometChatTeam", groupType: .public, password: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataItemContainer.dropShadow()
        self.group.membersCount = 4
        setupTableView()
        
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


extension GroupDataItem : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
            self.group.groupType = .public
        case 1:
            self.group.groupType = .password
        case 2:
            self.group.groupType = .private
        default:
            break
        }
        
        cell.set(group: self.group)
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header  = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
        let lable = UILabel(frame: CGRect(x: 10, y: 0, width: header.frame.size.width, height: header.frame.size.height - 4 ))
        header.addSubview(lable)
        
        switch section {
        case 0:
            lable.text = "Public"
        case 1:
            lable.text = "Password"
        case 2:
            lable.text = "Private"
        default:
            break
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
}

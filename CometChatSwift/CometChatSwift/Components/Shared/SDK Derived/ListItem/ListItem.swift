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

enum  ListItemType {
    case user
    case group
    case conversation
}

class ListItem: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var dataItemContainer: UIView!
    @IBOutlet weak var dataItemTable: UITableView!
    @IBOutlet weak var height: NSLayoutConstraint!
    
    var listItemTypes : [ListItemType] = [.user, .group, .conversation]
    
    //MARK: VARIABLES
    private let identifier = "CometChatListItem"
    var user    = User(uid: "superhero1", name: "SpiderMan")
    var group   = Group(guid: "Guid123", name: "CometChat Teams", groupType: .password, password: "")
    
    var conversation = Conversation()
    var user1 = User(uid: "superhero2", name: "CometChat")
   
    var textMesssage = TextMessage(receiverUid: "superhero2", text: "You have new message", receiverType: .user)
    
    func setupView() {
        let blurredView = blurView(view: self.view)
        view.addSubview(blurredView)
        view.sendSubviewToBack(blurredView)
    }
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemFill
        self.dataItemContainer.dropShadow()
        self.setupTableView()
        setupUser()
        setupGroup()
        setupConveration()
        setupView()
        
    }
    
    //MARK: FUNCTIONS
    func setupUser() {
        user.avatar = "https://data-us.cometchat.io/assets/images/avatars/spiderman.png"
    }
    
    func setupGroup() {
        self.group.membersCount = 20
    }
    
    func setupConveration() {
        conversation.lastMessage = textMesssage
        conversation.unreadMessageCount = 20
        var user =  User(uid: "superhero1", name: "Iron Man")
        user.avatar = "https://data-us.cometchat.io/assets/images/avatars/ironman.png"
        conversation.conversationWith = user
    }
    
    private func setupTableView() {
        dataItemTable.delegate = self
        dataItemTable.dataSource = self
        dataItemTable.separatorStyle = .none
        registerCells()
        
        if listItemTypes.count == 1 {
            height.constant = 300
         } else {
            height.constant = 520
        }
    }
    
    private func registerCells() {
        let cell = UINib(nibName: identifier, bundle: CometChatUIKit.bundle )
        self.dataItemTable.register(cell, forCellReuseIdentifier: identifier)
    }
    
    @IBAction func onCLoseClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

// MARK: Table view Methods
extension ListItem: UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return listItemTypes.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listItem = tableView.dequeueReusableCell(withIdentifier: identifier) as? CometChatListItem else { return UITableViewCell() }
        switch listItemTypes[indexPath.section] {
        case .user:
            if let name = user.name {
                listItem.set(title: name.capitalized)
                listItem.set(avatarName: name.capitalized)
            }
            if let avatarURL = user.avatar {
                listItem.set(avatarURL: avatarURL)
            }
            listItem.hide(statusIndicator: false)
            listItem.set(statusIndicatorColor: CometChatTheme.palatte.success)
            listItem.set(avatarStyle: AvatarStyle())
            listItem.set(statusIndicatorStyle: StatusIndicatorStyle())
            listItem.set(listItemStyle: ListItemStyle())
            listItem.build()
            return listItem
        case .group:
            if let name = group.name {
                listItem.set(title: name.capitalized)
                listItem.set(avatarName: name.capitalized)
            }
            listItem.hide(statusIndicator: false)
            listItem.set(statusIndicatorIcon: UIImage(named: "groups-lock" ,in: CometChatUIKit.bundle, with: nil) ?? UIImage())
            let label = UILabel()
            label.text = String(group.membersCount) + " Members"
            label.textColor = CometChatTheme.palatte.accent500
            label.font = CometChatTheme.typography.subtitle1
            listItem.set(subtitle: label)
            listItem.set(statusIndicatorIconTint: .white)
            listItem.set(statusIndicatorColor: .orange)
            listItem.set(avatarStyle: AvatarStyle())
            listItem.set(statusIndicatorStyle: StatusIndicatorStyle())
            listItem.set(listItemStyle: ListItemStyle())
            listItem.build()
            return listItem
        case .conversation:
            listItem.set(tail: configureTailView(conversation: conversation))
            listItem.set(subtitle: configureSubtitleView(conversation: conversation))
            listItem.set(listItemStyle: ListItemStyle())
            listItem.set(avatarStyle: AvatarStyle())
            listItem.set(statusIndicatorStyle: StatusIndicatorStyle())
    
            if let name = (conversation.conversationWith as? User)?.name?.capitalized {
                listItem.set(title: name)
            }
            listItem.set(avatarURL: (conversation.conversationWith as? User)?.avatar ?? "")
            listItem.hide(statusIndicator: false)
            listItem.set(statusIndicatorColor: CometChatTheme.palatte.success)
            listItem.build()
            return listItem
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header  = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: 200, height: 20))
        label.font = .systemFont(ofSize: 10)
        header.addSubview(label)
        switch listItemTypes[section] {
        case .user:  label.text = "User"
        case .group:  label.text = "Group"
        case .conversation: label.text = "Conversation"
        }
        header.layer.cornerRadius = 5
        header.backgroundColor = .systemFill
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        reloadInputViews()
    }
}


extension ListItem {
    
    private func configureTailView(conversation: Conversation) -> UIView {
        let tailView = UIStackView()
        tailView.distribution = .fill
        tailView.alignment = .trailing
        tailView.axis = .vertical
        tailView.spacing = 10
        
        let dateLabel = CometChatDate()
        dateLabel.set(timestamp: Int(conversation.updatedAt))
        dateLabel.textAlignment = .center
        dateLabel.font = CometChatTheme.typography.subtitle1
        dateLabel.textColor = CometChatTheme.palatte.accent400
        
        let badgeCount = UILabel()
        badgeCount.text = "\(conversation.unreadMessageCount)"
        if conversation.unreadMessageCount == 0 {
            badgeCount.textColor = .clear
            badgeCount.backgroundColor = .clear
        } else {
            badgeCount.textColor = CometChatTheme.palatte.background
            badgeCount.backgroundColor = CometChatTheme.palatte.primary
        }
        badgeCount.textAlignment = .center
        badgeCount.font = CometChatTheme.typography.subtitle2
        badgeCount.heightAnchor.constraint(equalToConstant: 20).isActive = true
        badgeCount.widthAnchor.constraint(equalToConstant: 30).isActive = true
        badgeCount.layer.cornerRadius = 10
        badgeCount.clipsToBounds = true
        tailView.addArrangedSubview(dateLabel)
        tailView.addArrangedSubview(badgeCount)
        return tailView
    }

    private func configureSubtitleView(conversation: Conversation) -> UIView {
        let subTitleView = UIStackView()
        subTitleView.alignment = .leading
        subTitleView.distribution = .fillProportionally
        subTitleView.axis = .vertical
        subTitleView.spacing = 10
        
        let lastStackView = UIStackView()
        lastStackView.alignment = .fill
        lastStackView.distribution = .fill
        lastStackView.axis = .horizontal
        
        let reciept = CometChatReceipt(image: UIImage(named: "messages-delivered" ,in: CometChatUIKit.bundle, with: nil))
        reciept.contentMode = .scaleAspectFit
       // reciept.heightAnchor.constraint(equalToConstant: 20).isActive = true
        reciept.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        let lastMessage = UILabel()
        lastMessage.font = CometChatTheme.typography.subtitle1
        lastMessage.textColor = CometChatTheme.palatte.accent700
        lastMessage.translatesAutoresizingMaskIntoConstraints = false
        lastMessage.numberOfLines = 0
        lastMessage.text = (conversation.lastMessage as? TextMessage)?.text
     
        lastStackView.addArrangedSubview(reciept)
        lastStackView.addArrangedSubview(lastMessage)
        subTitleView.addArrangedSubview(lastStackView)
        return subTitleView
    }

}

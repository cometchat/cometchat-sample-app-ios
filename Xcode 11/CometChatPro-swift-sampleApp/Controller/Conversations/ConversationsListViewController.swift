//
//  ConversationsListViewController.swift
//  CometChatUI
//
//  Created by pushpsen airekar on 18/11/18.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.
//

import UIKit
import  CometChatPro

class ConversationsListViewController: UIViewController ,UISearchControllerDelegate , CometChatMessageDelegate {
    
    //Outlets Declarations
    @IBOutlet weak var ConversationsTableView: UITableView!
    @IBOutlet weak var notifyButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var leftPadding: NSLayoutConstraint!
    @IBOutlet weak var rightPadding: NSLayoutConstraint!
    
    var conversations: [Conversation] = [Conversation]()
    var conversationRequest : ConversationRequest = ConversationRequest.ConversationRequestBuilder(limit: 100).setConversationType(conversationType: .none).build()
    
    var newConversationRequest : ConversationRequest?
    
    //Variable Declarations
    private var shadowImageView: UIImageView?
    
    //This method is called when controller has loaded its view into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CometChat.messagedelegate = self
        self.fetchConversationList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        CometChat.messagedelegate = self
        
        //Function Calling
        self.refreshConversationList()
        self.handleConversationsListVCAppearance()
    }
    
    func fetchConversationList(){
        //This method fetches the ConversationList from the server
        
        conversationRequest.fetchNext(onSuccess: { (fetchedConversations) in
            print("fetchedConversations : \(fetchedConversations)")
            for convo in fetchedConversations {
                self.conversations.append(convo)
            }
            DispatchQueue.main.async(execute: {
                self.ConversationsTableView.reloadData()
            })
        }) { (error) in
            print("fetchedConversations : \(String(describing: error?.errorDescription))")
            DispatchQueue.main.async(execute: {
                self.view.makeToast("\(String(describing: error!.errorDescription))")
            })
        }
    }
    
    func refreshConversationList(){
        self.conversations.removeAll()
        conversationRequest  = ConversationRequest.ConversationRequestBuilder(limit: 100).setConversationType(conversationType: .none).build()
        conversationRequest.fetchNext(onSuccess: { (fetchedConversations) in
            print("fetchedConversations 11: \(fetchedConversations)")
            for convo in fetchedConversations {
                self.conversations.append(convo)
            }
            DispatchQueue.main.async(execute: {
                self.ConversationsTableView.reloadData()
            })
        }) { (error) in
            print("fetchedConversations : \(String(describing: error?.errorDescription))")
            DispatchQueue.main.async(execute: {
                self.view.makeToast("\(String(describing: error!.errorDescription))")
            })
        }
    }
    
    
    //This method handles the UI customization for ConversationsListVC
    func  handleConversationsListVCAppearance(){
        // ViewController Appearance
        view.backgroundColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_COLOR)
        
        //TableView Appearance
        ConversationsTableView.delegate = self
        ConversationsTableView.dataSource = self
        self.ConversationsTableView.cornerRadius = CGFloat(UIAppearanceSize.CORNER_RADIUS)
        self.leftPadding.constant = CGFloat(UIAppearanceSize.Padding)
        self.rightPadding.constant = CGFloat(UIAppearanceSize.Padding)
        
        switch AppAppearance{
        case .AzureRadiance: self.ConversationsTableView.separatorStyle = .none
        case .MountainMeadow:break
        case .PersianBlue:break
        case .Custom:break
        }
        
        // NavigationBar Appearance
        navigationItem.title = NSLocalizedString("Converations", comment: "")
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white,.font: UIFont(name: SystemFont.regular.value, size: 21)!]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: SystemFont.bold.value, size: 40)!]
            navBarAppearance.backgroundColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_COLOR)
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {}
        
        ConversationsTableView.tableFooterView = UIView(frame: .zero)
    
        // NavigationBar Buttons Appearance
        notifyButton.setImage(UIImage(named: "bell.png"), for: .normal)
        moreButton.setImage(UIImage(named: "more_vertical.png"), for: .normal)
        moreButton.imageView?.contentMode = .scaleAspectFill
        notifyButton.imageView?.contentMode = .scaleAspectFill
        notifyButton.tintColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
        notifyButton.isHidden = true
        moreButton.tintColor = UIColor(hexFromString: UIAppearanceColor.NAVIGATION_BAR_BUTTON_TINT_COLOR)
    }
    
    
    @IBAction func announcementPressed(_ sender: Any) {
        
        
    }
    
    @IBAction func morePressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CCWebviewController = storyboard.instantiateViewController(withIdentifier: "moreSettingsViewController") as! MoreSettingsViewController
        navigationController?.pushViewController(CCWebviewController, animated: false)
        CCWebviewController.title = "More"
        CCWebviewController.hidesBottomBarWhenPushed = true
    }
    
    
    func onTextMessageReceived(textMessage: TextMessage) {
        refreshConversationList()
    }
    
    func onMediaMessageReceived(mediaMessage: MediaMessage) {
        refreshConversationList()
    }
}


extension ConversationsListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if conversations.isEmpty {
            self.ConversationsTableView.setEmptyMessage("No conversations yet.")
        } else {
            self.ConversationsTableView.restore()
        }
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ConversationsTableView.dequeueReusableCell(withIdentifier: "ConversationsTableViewCell") as! ConversationsTableViewCell
        if !conversations.isEmpty {
            
            let conversation = conversations[indexPath.row]
            cell.conversationObject = conversation
            print("conv is \(conversation.stringValue())")
            
            if conversation.lastMessage != nil {
                
                
                switch conversation.conversationType {
                    
                case .user:
                    cell.name.text = (conversation.conversationWith as? User)?.name
                    let url  = NSURL(string: (conversation.conversationWith as? User)?.avatar ?? "")
                    cell.avtar.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_user"))
                case .group:
                    cell.name.text = (conversation.conversationWith as? Group)?.name
                    let url  = NSURL(string: (conversation.conversationWith as? Group)?.icon ?? "")
                    cell.avtar.sd_setImage(with: url as URL?, placeholderImage: #imageLiteral(resourceName: "default_user"))
                case .none:
                    break
                @unknown default:
                    break
                }
                let senderName = conversation.lastMessage?.sender?.name
                
                
                switch conversation.lastMessage!.messageCategory {
                    
                case .message:
                    switch conversation.lastMessage?.messageType {
                        
                    case .text where conversation.conversationType == .user:
                        cell.conversation.text = (conversation.lastMessage as? TextMessage)?.text
                        print ("\(conversation.lastMessage as? TextMessage)?.text))")
                        
                    case .text where conversation.conversationType == .group:
                        cell.conversation.text = senderName! + ":  " + (conversation.lastMessage as? TextMessage)!.text
                    case .image where conversation.conversationType == .user:
                        cell.conversation.text = "has sent an image."
                        
                    case .image where conversation.conversationType == .group:
                        cell.conversation.text = senderName! + ":  " + "has sent an image."
                        
                    case .video  where conversation.conversationType == .user:
                        cell.conversation.text = "has sent a video"
                        
                    case .video  where conversation.conversationType == .group:
                        cell.conversation.text = senderName! + ":  " + "has sent a video"
                    case .audio  where conversation.conversationType == .user:
                        cell.conversation.text = "has sent a audio"
                        
                    case .video  where conversation.conversationType == .group:
                        cell.conversation.text = senderName! + ":  " + "has sent a audio"
                    case .file  where conversation.conversationType == .user:
                        cell.conversation.text = "has sent a file"
                        
                    case .video  where conversation.conversationType == .group:
                        cell.conversation.text = senderName! + ":  " + "has sent a file"
                    case .custom:
                        break
                    case .groupMember:
                        break
                    case .none:
                        break
                    case .some(_):
                        break
                    }
                case .action:
                    if conversation.conversationType == .user {
                        cell.conversation.text = (conversation.lastMessage as? ActionMessage)?.message
                    }
                case .call:
                    break
                case .custom:
                    cell.conversation.text = "This is custom Message"
                @unknown default:
                    break
                }
                
                let date = Date(timeIntervalSince1970: TimeInterval(conversation.lastMessage?.sentAt ?? 0))
                           let dateFormatter1 = DateFormatter()
                           dateFormatter1.dateFormat = "HH:mm:a"
                           dateFormatter1.timeZone = NSTimeZone.local
                           let dateString : String = dateFormatter1.string(from: date)
                cell.timeStamp.text = dateString
                if conversation.unreadMessageCount != 0 {
                    cell.badgeView.isHidden = false
                    cell.unreadCount.text = "\(conversation.unreadMessageCount)"
                }else{
                    cell.badgeView.isHidden = true
                }
                
            }
        }
        return cell
    }
    
    
     //didSelectRowAt indexPath
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           ConversationsTableView.deselectRow(at: indexPath, animated: true)
           let selectedCell:ConversationsTableViewCell = tableView.cellForRow(at: indexPath) as! ConversationsTableViewCell
            selectedCell.unreadCount.text = "0"
            selectedCell.badgeView.isHidden = true
           
        
        switch selectedCell.conversationObject.conversationType {
            
        case .user:
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
                     let chatViewController = storyboard.instantiateViewController(withIdentifier: "chatViewController") as! ChatViewController
              
            switch (selectedCell.conversationObject.conversationWith as? User)!.status {
              case .online:
                chatViewController.buddyStatusString = "Online"
              case .offline:
                chatViewController.buddyStatusString = "Offline"
              @unknown default: break}
              chatViewController.buddyAvtar = selectedCell.avtar.image
              chatViewController.buddyNameString = selectedCell.name.text
              chatViewController.buddyUID = (selectedCell.conversationObject.conversationWith as? User)?.uid
              chatViewController.isGroup = "0"
              navigationController?.pushViewController(chatViewController, animated: true)
        case .group:
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
                     let chatViewController = storyboard.instantiateViewController(withIdentifier: "chatViewController") as! ChatViewController
                     chatViewController.buddyAvtar = selectedCell.avtar.image
                     chatViewController.buddyNameString = selectedCell.name.text
                     chatViewController.buddyUID = (selectedCell.conversationObject.conversationWith as? Group)?.guid
                     chatViewController.isGroup = "1"
                     navigationController?.pushViewController(chatViewController, animated: true)
        case .none:
            break
        @unknown default:
            break
        }
       }
}



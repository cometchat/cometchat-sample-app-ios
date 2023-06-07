//
//  MessageListComponent.swift
//  CometChatSwift
//
//  Created by admin on 12/08/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatPro
import CometChatUIKitSwift

class MessageListComponent: UIViewController {
    
    @IBOutlet weak var listContainer: UIView!
    @IBOutlet weak var messageList: CometChatMessageList!
    
    func setupView() {
        DispatchQueue.main.async {
            let blurredView = self.blurView(view: self.view)
            self.view.addSubview(blurredView)
            self.view.sendSubviewToBack(blurredView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGroup()
        setupUI()
        setupView()
    }

    
    public override func loadView() {
        let loadedNib = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        if let contentView = loadedNib?.first as? UIView  {
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view  = contentView
        }
    }
    
    func setupUI() {
        self.view.backgroundColor = .systemFill
        listContainer.dropShadow()
        listContainer.roundViewCorners([.layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner], radius: 20)
    }
    
    
    private func setupGroup() {
        var types = [String]()
        var categories = [String]()
        var templates = [(type: String, template: CometChatMessageTemplate)]()
        let messageTypes =  ChatConfigurator.getDataSource().getAllMessageTemplates()
        for template in messageTypes {
            if !(categories.contains(template.category)){
                categories.append(template.category)
            }
            if !(types.contains(template.type)){
                types.append(template.type)
            }
            templates.append((type: template.type, template: template))
        }
        
        CometChat.getGroup(GUID: "supergroup") { group in
            DispatchQueue.main.async {
                self.messageList.set(messagesRequestBuilder: MessagesRequest.MessageRequestBuilder().set(guid: group.guid).set(limit: 30).set(types: types).set(categories: categories))
                self.messageList.set(group: group)
                if let messageList = self.messageList {
                    messageList.set(templates: templates)
                    messageList.set(controller: self)
                }
            }
        } onError: { error in
            self.showAlert(title: "Error", msg: error?.errorDescription ?? "")
        }
    }
    
    @IBAction func onCloseClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

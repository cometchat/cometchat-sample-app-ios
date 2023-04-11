//
//  UIComponentsCell.swift
//  ios-chat-uikit-app
//
//  Created by CometChat Inc. on 18/12/19.
//  Copyright © 2020 CometChat Inc. All rights reserved.
//

import UIKit

class UIComponentsCell: UITableViewCell {

    @IBOutlet weak var viewbottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var componentName: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var componentDescription: UILabel!
    @IBOutlet weak var forwardImage: UIImageView!
    @IBOutlet weak var cardview: UIView!
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
         self.selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //set the values for top,left,bottom,right margins
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setUpCell(customData: [ModuleComponentModel], indexPath : IndexPath ){
        setUpComponentsUI(isFirst: indexPath.row == 0, isLast: indexPath.row == (customData.count - 1))
            self.componentName.text = customData[indexPath.row].heading
            self.componentDescription.text = customData[indexPath.row].description
            self.avatar.image = UIImage(systemName: customData[indexPath.row].avatar)
           
        }

    
    func setUpComponentsUI(isFirst: Bool, isLast: Bool){
        if isFirst {
            if isFirst == isLast {
                cardview.roundViewCorners([.layerMinXMinYCorner , .layerMaxXMinYCorner,.layerMinXMaxYCorner , .layerMaxXMaxYCorner], radius: 15)
                self.viewLine.isHidden = true
                viewTopConstraint.constant = 10
                viewbottomConstraint.constant = 10

            } else {
                cardview.roundViewCorners([.layerMinXMinYCorner , .layerMaxXMinYCorner], radius: 15)
                self.viewLine.isHidden = false
                viewTopConstraint.constant = 10
                viewbottomConstraint.constant = 0
            }

        } else if isLast {
            cardview.roundViewCorners([.layerMinXMaxYCorner , .layerMaxXMaxYCorner], radius: 15)
            self.viewLine.isHidden = true
            viewTopConstraint.constant = 0
            viewbottomConstraint.constant = 10
        } else {
            cardview.roundViewCorners([.layerMinXMinYCorner , .layerMaxXMinYCorner, .layerMinXMaxYCorner , .layerMaxXMaxYCorner], radius: 0)
            self.viewLine.isHidden = false
            viewTopConstraint.constant = 0
            viewbottomConstraint.constant = 0
        }
        self.cardview.dropShadow()
        
    }
    
    var moduleType : moduleType? {
        didSet {
            viewTopConstraint.constant = 10
            viewbottomConstraint.constant = 10
            viewLine.isHidden = true
            avatar.isHidden = true
            forwardImage.isHidden = false
            cardview.dropShadow()
            
            var title = ""
            var description = ""
            
                switch moduleType {
                  
                case .chats:
                    title = "Chats"
                    description = "Conversations module helps you to list the recent conversations between your users and groups. To learn more about its components click here."
                    
                case .calls:
                    title = "Calls"
                    description = "Calls module helps you to list the recent call history between your users and groups. To learn more about its components click here."
                    
                case .messages:
                    title = "Messages"
                    description = "Messages module helps you to send and receive in a conversation between a user or group. To learn more about its components click here. "

                case .users:
                    title = "Users"
                    description = "Users module helps you list all the users available in your app. To learn more about its components click here."

                case .groups:
                    title = "Groups"
                    description = "Groups module helps you list all the groups you are part of in your app. To learn more about its components click here."

                case .shared:
                    title = "Shared"
                    description = "Share module contains several reusable components that are divided into Primary, Secondary and SDK derived components. To learn more about these components click here."

                default:
                    break
        }
        self.setUpModulesUI(title: title, titleDescription: description)
    }
}
    
    func setUpModulesUI(title: String? , titleDescription : String?) {
        if let title = title,  let titleDescription = titleDescription{
            self.cardview.layer.cornerRadius = 15
            self.componentName.text = title
            self.componentDescription.text = titleDescription
        }
    }
    
}

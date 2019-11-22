//
//  UsersTableViewCell.swift
//  CometChatUI
//
//  Created by Pushpsen Airekar on 21/11/18.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.
//

import UIKit
import CometChatPro

class UsersTableViewCell: UITableViewCell {
    
    //Outlets Declarations
    @IBOutlet weak var buddyAvtar: UIImageView!
    @IBOutlet weak var buddyName: UILabel!
    @IBOutlet weak var buddyStatus: UILabel!
    @IBOutlet weak var buddyStatusIcon: UIImageView!
    @IBOutlet weak var blockedLabel: UIView!
    @IBOutlet weak var unreadCountBadge: UIView!
    @IBOutlet weak var unreadCountLabel: UILabel!
    
    
    //variable Declarations
    var UID:String!
    var group:Group!
    public typealias unreadMessageCountResponse = (_ count:Int? , _ error:CometChatException?) ->Void
    //This methods getting called when the cell is loaded in the TableView
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Function Calling
        self.handleUsersTableViewCellAppearance()
    }
    
    
    func getUnreadCountForAllUsers(UID:String, completionHandler:@escaping unreadMessageCountResponse) {
    
        CometChat.getUnreadMessageCountForAllUsers(onSuccess: { (response) in
            let count:Int = response[UID] as? Int ?? 0
            completionHandler(count,nil)
        }) { (error) in
            completionHandler(nil,error)
        }
    }
    
    
    
    //This method handles the UI customization for nOneTableViewCell
    func handleUsersTableViewCellAppearance(){
        buddyAvtar.layer.cornerRadius = 27.5
        buddyAvtar.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

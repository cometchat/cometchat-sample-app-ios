//
//  GroupTableViewCell.swift
//  CometChatUI
//
//  Created by Pushpsen Airekar on 21/11/18.
//  Copyright © 2018 Pushpsen Airekar. All rights reserved.
//

import UIKit
import CometChatPro

class GroupTableViewCell: UITableViewCell {
    
    //Outlets Declarations
    @IBOutlet weak var passwordProtected: UIImageView!
    @IBOutlet weak var groupAvtar: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupParticipants: UILabel!
    @IBOutlet weak var unreadCountBadge: UIView!
    @IBOutlet weak var unreadCountLabel: UILabel!

    var UID:String!
    var groupType : Int!
    var group: Group!
    var groupScope : Int!
    public typealias unreadMessageCountResponse = (_ count:Int? , _ error:CometChatException?) ->Void
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Function Calling
        self.handleGroupTableViewCellAppearance()
    }
    
    func getUnreadCountForAllGroups(UID:String, completionHandler:@escaping unreadMessageCountResponse) {
        
        CometChat.getUnreadMessageCountForAllGroups(onSuccess: { (response) in
            let count:Int = response[UID] as? Int ?? 0
            completionHandler(count,nil)
        }) { (error) in
            completionHandler(nil,error)
        }
    }
    
    //This method handles the UI customization for GroupTableViewCell
    func handleGroupTableViewCellAppearance() {
        groupAvtar.layer.cornerRadius = 27.5
        groupAvtar.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    
}

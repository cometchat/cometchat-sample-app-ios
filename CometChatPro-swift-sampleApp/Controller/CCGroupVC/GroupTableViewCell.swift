//
//  GroupTableViewCell.swift
//  CometChatUI
//
//  Created by Admin1 on 21/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    //Outlets Declarations
    @IBOutlet weak var passwordProtected: UIImageView!
    @IBOutlet weak var groupAvtar: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupParticipants: UILabel!
    @IBOutlet weak var recentMessageCount: UIImageView!
    var UID:String!
    var groupType : Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        //Function Calling
        self.handleGroupTableViewCellAppearance()
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

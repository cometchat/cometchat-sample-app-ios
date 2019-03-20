//
//  OneOnOneTableViewCell.swift
//  CometChatUI
//
//  Created by Admin1 on 21/11/18.
//  Copyright © 2018 Admin1. All rights reserved.
//

import UIKit
import CometChatPro

class OneOnOneTableViewCell: UITableViewCell {

    //Outlets Declarations
    @IBOutlet weak var buddyAvtar: UIImageView!
    @IBOutlet weak var buddyName: UILabel!
    @IBOutlet weak var buddyStatus: UILabel!
    @IBOutlet weak var buddyStatusIcon: UIImageView!
    
    
    //variable Declarations
    var UID:String!
    var group:Group!
    
    //This methods getting called when the cell is loaded in the TableView
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Function Calling
        self.handleOneOnOneTableViewCellAppearance()
       
    }
    
    //This method handles the UI customization for nOneTableViewCell
    func handleOneOnOneTableViewCellAppearance(){
        buddyAvtar.layer.cornerRadius = 27.5
        buddyAvtar.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

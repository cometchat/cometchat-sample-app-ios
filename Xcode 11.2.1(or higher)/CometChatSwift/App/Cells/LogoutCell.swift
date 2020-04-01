//
//  LogoutCell.swift
//  ios-chat-uikit-app
//
//  Created by MacMini-03 on 21/01/20.
//  Copyright © 2020 MacMini-03. All rights reserved.
//

import UIKit

protocol LogoutCellDelegate: class {
    func didlogoutButtonPressed(_ sender: UIButton)
}

class LogoutCell: UITableViewCell {

    weak var delegate: LogoutCellDelegate?
    
    @IBOutlet weak var logoutView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        logoutView.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        delegate?.didlogoutButtonPressed(sender as! UIButton)
    }
    
}

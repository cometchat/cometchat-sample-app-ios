//
//  BadgeCountModification.swift
//  CometChatSwift
//
//  Created by admin on 24/08/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatUIKit
class BadgeCountModification: UIViewController {

    @IBOutlet weak var badgeCount: CometChatBadgeCount!
    @IBOutlet weak var badgeCountView: UIView!
    @IBOutlet weak var count: UITextField!
    @IBOutlet weak var badgeCountBackgroundColor: UISegmentedControl!
    
    var countUnreadMessage : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemGray6
            badgeCountView.dropShadow()
        } else {}
    }
    
    @IBAction func badgeCountBackgroundPressed(_ sender: Any) {
        
        switch badgeCountBackgroundColor.selectedSegmentIndex {
        case 0: badgeCount.set(backgroundColor: .systemBlue)
                badgeCountBackgroundColor.selectedSegmentTintColor = .systemBlue
            
        case 1: badgeCount.set(backgroundColor: .systemRed)
                badgeCountBackgroundColor.selectedSegmentTintColor = .systemRed
            
        case 2: badgeCount.set(backgroundColor:  .systemGray)
                badgeCountBackgroundColor.selectedSegmentTintColor = .systemGray
            
        default: break
        }
    }
        

    @IBAction func badgeCountValueChanged(_ sender: UITextField) {
       
        if count.text?.isEmpty == true {
            badgeCount.text = "0"
        }else {
            countUnreadMessage  = Int(count.text ?? "1")
            badgeCount.set(count: countUnreadMessage ?? 1)
            
        }
    }
    
}

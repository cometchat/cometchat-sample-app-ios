//
//  BadgeCountModification.swift
//  CometChatSwift
//
//  Created by admin on 24/08/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatUIKitSwift

class BadgeCountModification: UIViewController {
   
    //MARK: OUTLETS
    @IBOutlet weak var badgeCount: CometChatBadge!
    @IBOutlet weak var badgeCountView: UIView!
    @IBOutlet weak var count: UITextField!
    @IBOutlet weak var badgeCountBackgroundColor: UISegmentedControl!
    
    //MARK: VARIABLES
    var countUnreadMessage : Int?
    
    func setupView() {
        DispatchQueue.main.async {
            let blurredView = self.blurView(view: self.view)
            self.view.addSubview(blurredView)
            self.view.sendSubviewToBack(blurredView)
        }
    }
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemFill
        badgeCount.set(count: 1)
        badgeCountView.dropShadow()
        badgeCount.set(cornerRadius: 27)
        badgeCount.set(backgroundColor: .systemBlue)
        setupView()
    }
    
    //MARK: FUNCTIONS
    @IBAction func onCLoseClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func badgeCountBackgroundPressed(_ sender: Any) {
        setupBadgeCountBackground()
    }
        
    @IBAction func badgeCountValueChanged(_ sender: UITextField) {
        if count.text?.isEmpty == true {
            badgeCount.set(count: 0)
        } else {
            countUnreadMessage  = Int(count.text ?? "0")
            badgeCount.set(count: countUnreadMessage ?? 0)
            setupBadgeCountBackground()
        }
       
    }
    
    func setupBadgeCountBackground() {
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
}

//
//  Localisation+Component.swift
//  CometChatSwift
//
//  Created by admin on 01/09/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import UIKit
import CometChatUIKit

class LocalisationComponent: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var setLanguage: UISegmentedControl!
    @IBOutlet weak var componentDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.dropShadow()

        // Do any additional setup after loading the view.
    }

    @IBAction func launchWithChangedLanguage(_ sender: UIButton) {
        switch setLanguage.selectedSegmentIndex {
        case 0:
            CometChatLocalize.set(locale: .english)
        case 1:
            CometChatLocalize.set(locale: .hindi)
            
        default:
            break
        }
        
        let cometchatDetail = CometChatConversationsWithMessages()
        let navigationController = UINavigationController(rootViewController: cometchatDetail)
        self.present(navigationController, animated: true)
        
    }
    @IBAction func setLanguageSelected(_ sender: UISegmentedControl) {

    }
    

}

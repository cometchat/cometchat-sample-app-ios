//
//  StatusIndicatorModification.swift
//  CometChatSwift
//
//  Created by admin on 24/08/22.
//  Copyright © 2022 MacMini-03. All rights reserved.

import UIKit
import CometChatUIKit
import CometChatPro

class StatusIndicatorModification: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var statusIndicatorView: UIView!
    @IBOutlet weak var statusIndicator: CometChatStatusIndicator!
    @IBOutlet weak var status: UISegmentedControl!

    func setupView() {
        let blurredView = blurView(view: self.view)
        view.addSubview(blurredView)
        view.sendSubviewToBack(blurredView)
    }
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemFill
        self.statusIndicatorView.dropShadow()
        setupView()
    }
        
    //MARK: FUNCTIONS
    @IBAction func ChangeStatusSegment(_ sender: UISegmentedControl) {
        switch status.selectedSegmentIndex {
        case 0:
          // statusIndicator.set(status: .online)
            statusIndicator.layer.backgroundColor = UIColor.green.cgColor
        case 1:
           // statusIndicator.set(status: .offline)
            statusIndicator.layer.backgroundColor = UIColor.gray.cgColor
        default:
            break
        }
    }
    
    @IBAction func onCloseClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

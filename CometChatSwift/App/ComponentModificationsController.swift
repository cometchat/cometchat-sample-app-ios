//
//  ComponentModificationsController.swift
//  ios-chat-uikit-app
//
//  Created by CometChat Inc. on 18/12/19.
//  Copyright © 2020 CometChat Inc. All rights reserved.
//

import UIKit

class ComponentModificationsController: UIViewController {
    
    // Avatar
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatar: CometChatAvatar!
    @IBOutlet weak var avatarCornerRadius: UITextField!
    @IBOutlet weak var avatarBorderWidth: UITextField!
    @IBOutlet weak var borderColor: UISegmentedControl!
    @IBOutlet weak var image: UISegmentedControl!
    
    
    // Status Indicator
    
    @IBOutlet weak var statusIndicatorView: UIView!
    @IBOutlet weak var statusIndicator: CometChatStatusIndicator!
    @IBOutlet weak var statusBorderColor: UISegmentedControl!
    @IBOutlet weak var statusBackgroundColor: UISegmentedControl!
    @IBOutlet weak var status: UISegmentedControl!
    
    
    // Badge Count
    
    @IBOutlet weak var badgeCount: CometChatBadgeCount!
    @IBOutlet weak var badgeCountView: UIView!
    @IBOutlet weak var count: UITextField!
    @IBOutlet weak var badgeCountBackgroundColor: UISegmentedControl!
    
    
    var isAvatarView: Bool = false
    var isStatusIndicatorView: Bool = false
    var isBadgeCountView: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isAvatarView == true {
            avatarView.isHidden = false
        }else if isStatusIndicatorView == true {
            statusIndicatorView.isHidden = false
        }else{
            badgeCountView.isHidden = false
        }
        hideKeyboardWhenTappedArround()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {}
        // Do any additional setup after loading the view.
    }
    
    
    fileprivate func hideKeyboardWhenTappedArround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        statusIndicatorView.addGestureRecognizer(tap)
        avatarView.addGestureRecognizer(tap)
        
    }
    
    @objc  func dismissKeyboard() {
        avatarCornerRadius.resignFirstResponder()
        avatarBorderWidth.resignFirstResponder()
        count.resignFirstResponder()
    }
    
    // Avatar Start
    
    @IBAction func segmentControlPressed(_ sender: Any) {
        if #available(iOS 13.0, *) {
            switch borderColor.selectedSegmentIndex {
            case 0: borderColor.selectedSegmentTintColor = .systemBlue
            case 1: borderColor.selectedSegmentTintColor = .systemRed
            case 2: borderColor.selectedSegmentTintColor = .systemGray
            case 3: borderColor.selectedSegmentTintColor = .systemGreen
            case 4: borderColor.selectedSegmentTintColor = .systemOrange
            case 5: borderColor.selectedSegmentTintColor = .systemBackground
            default: break
            }
        }else{
            switch borderColor.selectedSegmentIndex {
            case 0: borderColor.tintColor = .blue
            case 1: borderColor.tintColor = .red
            case 2: borderColor.tintColor = .gray
            case 3: borderColor.tintColor = .green
            case 4: borderColor.tintColor = .orange
            case 5: borderColor.tintColor = .white
            default: break
            }
        }
    }
    
    @IBAction func modifyAvatarPressed(_ sender: Any) {
        
        let borderWidth = CGFloat(truncating: NumberFormatter().number(from: avatarBorderWidth.text ?? "0") ?? 0)
        let cornerRadius = CGFloat(truncating: NumberFormatter().number(from: avatarCornerRadius.text ?? "0") ?? 0)
        let number = arc4random_uniform(99)
        
        avatar.set(borderWidth: borderWidth).set(cornerRadius: cornerRadius)
        
        if image.selectedSegmentIndex == 0 {
            avatar.set(image: "")
        }else{
            avatar.set(image: "https://randomuser.me/api/portraits/women/\(number).jpg")
        }
        if #available(iOS 13.0, *) {
            switch borderColor.selectedSegmentIndex {
            case 0: avatar.set(borderColor: .systemBlue)
            case 1: avatar.set(borderColor: .systemRed)
            case 2: avatar.set(borderColor: .systemGray)
            case 3: avatar.set(borderColor: .systemGreen)
            case 4: avatar.set(borderColor:  .systemOrange)
            case 5:avatar.set(borderColor:  .black)
            default: break
            }
        }else{
            switch borderColor.selectedSegmentIndex {
            case 0: avatar.set(borderColor: .blue)
            case 1: avatar.set(borderColor: .red)
            case 2: avatar.set(borderColor: .gray)
            case 3: avatar.set(borderColor: .green)
            case 4: avatar.set(borderColor:  .orange)
            case 5:avatar.set(borderColor:  .black)
            default: break
            }
            
        }
    }
    
    // Avatar End
    
    // Status Indicator Start
    
    @IBAction func statusBorderColorPressed(_ sender: Any) {
        if #available(iOS 13.0, *) {
            switch statusBorderColor.selectedSegmentIndex {
            case 0: statusBorderColor.selectedSegmentTintColor = .systemBlue
            case 1: statusBorderColor.selectedSegmentTintColor = .systemRed
            case 2: statusBorderColor.selectedSegmentTintColor = .systemGray
            case 3: statusBorderColor.selectedSegmentTintColor = .systemGreen
            case 4: statusBorderColor.selectedSegmentTintColor = .systemOrange
            case 5: statusBorderColor.selectedSegmentTintColor = .systemBackground
            default: break
            }
        }else{
            switch statusBorderColor.selectedSegmentIndex {
            case 0: statusBorderColor.tintColor = .blue
            case 1: statusBorderColor.tintColor = .red
            case 2: statusBorderColor.tintColor = .gray
            case 3: statusBorderColor.tintColor = .green
            case 4: statusBorderColor.tintColor = .orange
            case 5: statusBorderColor.tintColor = .black
            default: break
            }
        }
        
    }
    
    @IBAction func statusBackgroundColorPressed(_ sender: Any) {
        if #available(iOS 13.0, *) {
            switch statusBackgroundColor.selectedSegmentIndex {
            case 0: statusBackgroundColor.selectedSegmentTintColor = .systemBlue
            case 1: statusBackgroundColor.selectedSegmentTintColor = .systemRed
            case 2: statusBackgroundColor.selectedSegmentTintColor = .systemGray
            case 3: statusBackgroundColor.selectedSegmentTintColor = .systemGreen
            case 4: statusBackgroundColor.selectedSegmentTintColor = .systemOrange
            case 5: statusBackgroundColor.selectedSegmentTintColor = .systemBackground
            default: break
            }
        }else{
            switch statusBackgroundColor.selectedSegmentIndex {
            case 0: statusBackgroundColor.tintColor = .blue
            case 1: statusBackgroundColor.tintColor = .red
            case 2: statusBackgroundColor.tintColor = .gray
            case 3: statusBackgroundColor.tintColor = .green
            case 4: statusBackgroundColor.tintColor = .orange
            case 5: statusBackgroundColor.tintColor = .black
            default: break
            }
        }
    }
    
    @IBAction func modifyStatusPressed(_ sender: Any) {
        
        if status.selectedSegmentIndex == 0 {
            if #available(iOS 13.0, *) {
                switch statusBackgroundColor.selectedSegmentIndex {
                case 0: statusIndicator.set(color: .systemBlue)
                case 1: statusIndicator.set(color:  .systemRed)
                case 2: statusIndicator.set(color:  .systemGray)
                case 3: statusIndicator.set(color: .systemGreen)
                case 4: statusIndicator.set(color: .systemOrange)
                case 5: statusIndicator.set(color:  .systemBackground)
                default: break
                }
                switch statusBorderColor.selectedSegmentIndex {
                case 0: statusIndicator.set(color: .systemBlue)
                case 1: statusIndicator.set(borderColor:  .systemRed)
                case 2: statusIndicator.set(borderColor:  .systemGray)
                case 3: statusIndicator.set(borderColor: .systemGreen)
                case 4: statusIndicator.set(borderColor: .systemOrange)
                case 5: statusIndicator.set(borderColor:  .systemBackground)
                default: break
                }
            }else{
                switch statusBackgroundColor.selectedSegmentIndex {
                case 0: statusIndicator.set(color: .blue)
                case 1: statusIndicator.set(color:  .red)
                case 2: statusIndicator.set(color:  .gray)
                case 3: statusIndicator.set(color: .green)
                case 4: statusIndicator.set(color: .orange)
                case 5: statusIndicator.set(color:  .black)
                default: break
                }
                switch statusBorderColor.selectedSegmentIndex {
                case 0: statusIndicator.set(color: .blue)
                case 1: statusIndicator.set(borderColor:  .red)
                case 2: statusIndicator.set(borderColor:  .gray)
                case 3: statusIndicator.set(borderColor: .green)
                case 4: statusIndicator.set(borderColor: .orange)
                case 5: statusIndicator.set(borderColor:  .black)
                default: break
                }
            }
            
            
            
        }else if status.selectedSegmentIndex == 1{
            statusIndicator.set(status: .online)
            statusIndicator.set(borderColor: .lightText)
            
        }else if status.selectedSegmentIndex == 2{
            statusIndicator.set(status: .offline)
            statusIndicator.set(borderColor: .lightText)
        }
    }
    //Status Indicator End
    
    
    // Badge Count Start
    
    @IBAction func badgeCountBackgroundPressed(_ sender: Any) {
        
        if #available(iOS 13.0, *) {
            switch badgeCountBackgroundColor.selectedSegmentIndex {
            case 0: badgeCountBackgroundColor.selectedSegmentTintColor = .systemBlue
            case 1: badgeCountBackgroundColor.selectedSegmentTintColor = .systemRed
            case 2: badgeCountBackgroundColor.selectedSegmentTintColor = .systemGray
            case 3: badgeCountBackgroundColor.selectedSegmentTintColor = .systemGreen
            case 4: badgeCountBackgroundColor.selectedSegmentTintColor = .systemOrange
            case 5: badgeCountBackgroundColor.selectedSegmentTintColor = .systemBackground
            default: break
            }
        }else{
            switch badgeCountBackgroundColor.selectedSegmentIndex {
            case 0: badgeCountBackgroundColor.tintColor = .blue
            case 1: badgeCountBackgroundColor.tintColor = .red
            case 2: badgeCountBackgroundColor.tintColor = .gray
            case 3: badgeCountBackgroundColor.tintColor = .green
            case 4: badgeCountBackgroundColor.tintColor = .orange
            case 5: badgeCountBackgroundColor.tintColor = .black
            default: break
            }
        }
    }
    
    
    @IBAction func modifyBadgeCountPressed(_ sender: Any) {
        
        badgeCount.set(count: Int(count.text ?? "0") ?? 0)
        
        if #available(iOS 13.0, *) {
            switch badgeCountBackgroundColor.selectedSegmentIndex {
            case 0: badgeCount.set(backgroundColor: .systemBlue)
            case 1: badgeCount.set(backgroundColor:.systemRed)
            case 2: badgeCount.set(backgroundColor: .systemGray)
            case 3: badgeCount.set(backgroundColor: .systemGreen)
            case 4: badgeCount.set(backgroundColor: .systemOrange)
            case 5: badgeCount.set(backgroundColor: .systemBackground)
            default: break
            }
        }else{
            switch badgeCountBackgroundColor.selectedSegmentIndex {
            case 0: badgeCount.set(backgroundColor: .blue)
            case 1: badgeCount.set(backgroundColor:.red)
            case 2: badgeCount.set(backgroundColor: .gray)
            case 3: badgeCount.set(backgroundColor: .green)
            case 4: badgeCount.set(backgroundColor: .orange)
            case 5: badgeCount.set(backgroundColor: .black)
            default: break
            }
        }
        
        
    }
    
    
    // Badge Count End
}



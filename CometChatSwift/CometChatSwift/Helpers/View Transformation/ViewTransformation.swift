//
//  ViewTransformation.swift
//  CometChatSwift
//
//  Created by Pushpsen Airekar on 02/02/21.
//  Copyright © 2021 MacMini-03. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func roundViewCorners(_ corners: CACornerMask, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = corners
        } else {
            // Fallback on earlier versions
        }
        self.layer.cornerRadius = radius
    }
}


extension UIViewController{
    func isModal() -> Bool {
        
        if let navigationController = self.navigationController{
            if navigationController.viewControllers.first != self{
                return false
            }
        }
        
        if self.presentingViewController != nil {
            return true
        }
        
        if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController  {
            return true
        }
        
        if self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        
        return false
    }
}

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}



extension UIView {
    
    func dropShadow() {
        DispatchQueue.main.async {  [weak self] in
            guard let this = self else { return }
            
            this.layer.masksToBounds = false
            
            // shadow
            this.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
            this.layer.shadowOffset = CGSize.zero
            this.layer.shadowOpacity = 0.5
            this.layer.shadowRadius = 6.0
        }
    }
}

extension UIView {
    static func preventDimmingView() {
        guard let originalMethod = class_getInstanceMethod(UIView.self, #selector(addSubview(_:))), let swizzledMethod = class_getInstanceMethod(UIView.self, #selector(swizzled_addSubview(_:))) else { return }
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }

    static func allowDimmingView() {
        guard let originalMethod = class_getInstanceMethod(UIView.self, #selector(addSubview(_:))), let swizzledMethod = class_getInstanceMethod(UIView.self, #selector(swizzled_addSubview(_:))) else { return }
        method_exchangeImplementations(swizzledMethod, originalMethod)
    }

    @objc func swizzled_addSubview(_ view: UIView) {
        let className = "_UIParallaxDimmingView"
        guard let offendingClass = NSClassFromString(className) else { return swizzled_addSubview(view) }
        if (view.isMember(of: offendingClass)) {
            return
        }
        swizzled_addSubview(view)
    }
}

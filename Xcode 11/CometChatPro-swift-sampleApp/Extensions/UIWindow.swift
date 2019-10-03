//
//  UIWindow.swift
//  CometChatPro-swift-sampleApp
//
//  Created by Pushpsen Airekar on 18/02/19.
//  Copyright © 2019 Pushpsen Airekar. All rights reserved.
//

import UIKit

extension UIViewController {
    @objc func topMostViewController() -> UIViewController {
        // Handling Modal views
        if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController()
        }
            // Handling UIViewController's added as subviews to some other views.
        else {
            for view in self.view.subviews
            {
                // Key property which most of us are unaware of / rarely use.
                if let subViewController = view.next {
                    if subViewController is UIViewController {
                        let viewController = subViewController as! UIViewController
                        return viewController.topMostViewController()
                    }
                }
            }
            return self
        }
    }
}

extension UITabBarController {
    override func topMostViewController() -> UIViewController {
        return self.selectedViewController!.topMostViewController()
    }
}

extension UINavigationController {
    override func topMostViewController() -> UIViewController {
        return self.visibleViewController!.topMostViewController()
    }
}

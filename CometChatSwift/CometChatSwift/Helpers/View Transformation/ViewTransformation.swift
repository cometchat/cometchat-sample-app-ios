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
    
    func viewGradient(gradientLayer: CAGradientLayer , color: UIColor) {
        DispatchQueue.main.async {
            gradientLayer.frame = self.bounds
            gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
            gradientLayer.colors =
            [color.cgColor,color.withAlphaComponent(0.76).cgColor]
            self.layer.addSublayer(gradientLayer)
        }
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

///This method provide left padding to the Text Field
extension UITextField {
    func leftPadding() {
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}


class CustomLoader: UIView {
    
    static let instance = CustomLoader()
    var viewColor: UIColor = .black
    var setAlpha: CGFloat = 0.5
    var gifName: String = "customLoading"
    
    lazy var transparentView: UIView = {
        let transparentView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        transparentView.backgroundColor = viewColor.withAlphaComponent(setAlpha)
        transparentView.isUserInteractionEnabled = false
        return transparentView
    }()
    
    lazy var gifImage: UIImageView = {
        var gifImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 80))
        gifImage.contentMode = .scaleAspectFit
        gifImage.center = transparentView.center
        gifImage.isUserInteractionEnabled = false
        gifImage.backgroundColor = .clear
        gifImage.loadGif(name: gifName)
        return gifImage
    }()
    
    func showLoaderView() {
        self.addSubview(self.transparentView)
        self.transparentView.addSubview(self.gifImage)
        self.transparentView.bringSubviewToFront(self.gifImage)
        UIApplication.shared.keyWindow?.addSubview(transparentView)
        
    }
    
    func hideLoaderView() {
        self.transparentView.removeFromSuperview()
    }
    
}

class FontKit {
    
    static func roundedFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
        let font: UIFont
        
        if #available(iOS 13.0, *) {
            if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
                font = UIFont(descriptor: descriptor, size: fontSize)
            } else {
                font = systemFont
            }
        } else {
            font = systemFont
        }
        return font
    }
}


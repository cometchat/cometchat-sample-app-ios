//
//  GradientImageView.swift
//  CometChatSwift
//
//  Created by admin on 03/10/22.
//  Copyright © 2022 MacMini-03. All rights reserved.
//

import Foundation
import UIKit
import CometChatUIKitSwift

@IBDesignable @objc public class GradientImageView: UIImageView {
    @IBInspectable var color: UIColor = CometChatTheme.palatte.primary
    let gradientLayer:CAGradientLayer = CAGradientLayer()
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.viewGradient(gradientLayer: gradientLayer, color: color)
        self.roundViewCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 15)
        self.setNeedsLayout()
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.viewGradient(gradientLayer: gradientLayer, color: color)
        self.roundViewCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 15)
        self.setNeedsLayout()
    }
}





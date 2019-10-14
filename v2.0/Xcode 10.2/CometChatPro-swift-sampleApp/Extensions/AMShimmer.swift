//
//  AMShimmer.swift
//
//  Created by abedalkareem omreyh on 5/13/18.
//  Copyright © 2018 abedalkareem omreyh. All rights reserved.
//  GitHub : https://github.com/Abedalkareem/AMShimmer
//
//  The MIT License (MIT)
//
//  Copyright (c) 2017 Abedalkareem Omreyh
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit

@objc
public class AMShimmer : NSObject {
    
    
    // MARK: - Properties
    
    /// The object that hold the `AMShimmer` settings, like duration, colors and repeatCount.
    public static let settings = AMShimmerSettings()
    public static var isAnimating = false
    
    private static let layerName = "shimmerEffect"
    
    // MARK: - Start / Stop methods
    
    /// Start the shimmer effect for the sent `view`, this method will go through all
    /// `subviews` and add the shimmer effect for it.
    ///
    /// if you sent `view` that don't contain subviews, the shimmer effect will run
    /// directly in the view itself.
    ///
    /// - parameter view: The view that you want to run the shimmer effect for it.
    /// - parameter views: The `subviews` that you don't want it to have shimmer effect.
    /// - parameter isToLastView: The value determines if you want it to have shimmer effect in
    ///             all deepest subviews in your view hierarchy, or the direct subviews.
    ///
    @objc
    public class func start(for view: UIView, except views: [UIView] = [], isToLastView: Bool = false) {
        
        guard view.subviews.count != 0 else {
            startFor(view)
            return
        }
        
        guard !isToLastView else {
            search(view: view, except: views, isToLastView: isToLastView)
            return
        }
        
        view.subviews.forEach { if !views.contains($0) { startFor($0) } }
        
    }
    
    /// Start the shimmer effect for the sent `tableView`, this method will go through all
    /// `visibleCells` and it will search for `views` without `subviews` and add the shimmer effect for it.
    ///
    /// - parameter tableView: The tableView that you want to run the shimmer effect for it's cells.
    ///
    @objc
    public class func start(for tableView: UITableView) {
        tableView.visibleCells.forEach { search(view: $0) }
        tableView.isUserInteractionEnabled = false
         tableView.allowsSelection = false
        isAnimating = true
        
    }
    
    private class func search(view: UIView, except views: [UIView] = [], isToLastView: Bool = false) {
        
        guard !views.contains(view) else {
            return
        }
        
        if view.subviews.count > 0 {
            view.subviews.forEach {   search(view: $0, except: views, isToLastView: isToLastView)}
        } else {
            start(for: view)
        }
    }
    
    /// Stop the shimmer effect for the sent `view`.
    ///
    /// - parameter view: The view that you want to stop the shimmer effect that run on it.
    ///
    @objc
    public class func stop(for view: UIView) {
        
        guard view.subviews.count != 0 else {
            removeShimmerLayer(for: view)
            return
        }
        
        if let tableView = view as? UITableView {
            tableView.isUserInteractionEnabled = true
            tableView.allowsSelection = true
        }
        
        view.subviews.forEach {
            if view.subviews.count > 0 {
                view.subviews.forEach { stop(for: $0) }
            } else {
                removeShimmerLayer(for: $0)
                
            }
        }
        isAnimating = false
        
    }
    
    private class func removeShimmerLayer(for view: UIView) {
        
        view.layer.sublayers?.forEach {
            if $0.name == layerName {
                $0.removeFromSuperlayer()
            }
        }
    }
    
    private class func startFor(_ view: UIView) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.locations = [0.0,0.1,0.3]
        gradientLayer.colors = [settings.lightColor, settings.darkColor, settings.lightColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.name = layerName
        view.layer.addSublayer(gradientLayer)
        
        animate(layer: gradientLayer)
    }
    
    // MARK: - Animation
    
    private class func animate(layer: CAGradientLayer) {
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.duration = settings.duration
        animation.toValue = [0.6, 1.2, 1.5]
        animation.isRemovedOnCompletion = false
        animation.repeatCount = settings.repeatCount
        layer.add(animation, forKey: "shimmerEffectAnimation")
    }
    
}

/// The class that hold the `AMShimmer` settings, like duration, colors and repeatCount.
public class AMShimmerSettings {
    /// The duration of the moving line animation. The defualt `duration` is `0.5`
    var duration = 0.8
    /// The dark color that move through the view. The defualt color is (red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
    var darkColor = #colorLiteral(red: 0.9463138872, green: 0.9463138872, blue: 0.9463138872, alpha: 1).cgColor
    /// The light color arowned the dark color. The defualt color is (red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    var lightColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1).cgColor
    /// The repeat count for the animation, The defualt is `HUGE`.
    var repeatCount = HUGE
}


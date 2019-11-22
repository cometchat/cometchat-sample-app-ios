

import Foundation
import UIKit
import XLActionController

open class SkypeCell: UICollectionViewCell {
    
    @IBOutlet open weak var actionTitleLabel: UILabel!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    func initialize() {
        backgroundColor = .clear
        actionTitleLabel?.textColor = .darkGray
        let backgroundView = UIView()
        backgroundView.backgroundColor = backgroundColor
        selectedBackgroundView = backgroundView
    }
}


open class SkypeActionController: ActionController<SkypeCell, String, UICollectionReusableView, Void, UICollectionReusableView, Void> {

    static let bottomPadding: CGFloat = 20.0

    open var backgroundColor: UIColor = UIColor(red: 18/255.0, green: 165/255.0, blue: 244/255.0, alpha: 1.0)

    fileprivate var contextView: ContextView!
    fileprivate var normalAnimationRect: UIView!
    fileprivate var springAnimationRect: UIView!
    
    let topSpace = CGFloat(40)
    
    public override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        cellSpec = .nibFile(nibName: "SkypeCell", bundle: Bundle(for: SkypeCell.self), height: { _ in 60 })
        settings.animation.scale = nil
        settings.animation.present.duration = 0.5
        settings.animation.present.options = [.curveEaseOut, .allowUserInteraction]
        settings.animation.present.springVelocity = 0.0
        settings.animation.present.damping = 0.7
        settings.statusBar.style = .default

        onConfigureCellForAction = { cell, action, indexPath in
            cell.actionTitleLabel.text = action.data
            cell.actionTitleLabel.textColor = .white
            cell.alpha = action.enabled ? 1.0 : 0.5
        }
    }
  
    required public init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        let width = collectionView.bounds.width - safeAreaInsets.left - safeAreaInsets.right
        let height = contentHeight + topSpace + SkypeActionController.bottomPadding + safeAreaInsets.bottom
        contextView = ContextView(frame: CGRect(x: 0, y: -topSpace, width: width, height: height))
        contextView.animatedBackgroundColor = backgroundColor;
        contextView.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]

        collectionView.clipsToBounds = false
        collectionView.addSubview(contextView)
        collectionView.sendSubviewToBack(contextView)
        
        normalAnimationRect = UIView(frame: CGRect(x: 0, y: view.bounds.height / 2, width: 30, height: 30))
        normalAnimationRect.isHidden = true
        view.addSubview(normalAnimationRect)
        
        springAnimationRect = UIView(frame: CGRect(x: 40, y: view.bounds.height / 2, width: 30, height: 30))
        springAnimationRect.isHidden = true
        view.addSubview(springAnimationRect)
        
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.65)
    }

    @available(iOS 11, *)
    override open func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        contextView.frame.size.height = contentHeight + topSpace + SkypeActionController.bottomPadding + safeAreaInsets.bottom
        contextView.frame.size.width = collectionView.bounds.width - safeAreaInsets.left - safeAreaInsets.right
    }

    override open func onWillPresentView() {
        super.onWillPresentView()
        
        collectionView.frame.origin.y = contentHeight + (topSpace - contextView.topSpace)
        
        startAnimation()
        let initSpace = CGFloat(45.0)
        let initTime = 0.1
        let animationDuration = settings.animation.present.duration - 0.1
        
        let options: UIView.AnimationOptions = [.curveEaseOut, .allowUserInteraction]
        UIView.animate(withDuration: initTime, delay: settings.animation.present.delay, options: options, animations: { [weak self] in
                guard let me = self else {
                    return
                }
                
                var frame = me.springAnimationRect.frame
                frame.origin.y = frame.origin.y - initSpace
                me.springAnimationRect.frame = frame
            }, completion: { [weak self] finished in
                guard let me = self , finished else {
                    self?.finishAnimation()
                    return
                }
                
                UIView.animate(withDuration: animationDuration - initTime, delay: 0, options: options, animations: { [weak self] in
                    guard let me = self else {
                        return
                    }
                    
                    var frame = me.springAnimationRect.frame
                    frame.origin.y -= (me.contentHeight - initSpace)
                    me.springAnimationRect.frame = frame
                    }, completion: { (finish) -> Void in
                        me.finishAnimation()
                })
            })
        
        
        UIView.animate(withDuration: animationDuration - initTime, delay: settings.animation.present.delay + initTime, options: options, animations: { [weak self] in
            guard let me = self else {
                return
            }
            
            var frame = me.normalAnimationRect.frame
            frame.origin.y -= me.contentHeight
            me.normalAnimationRect.frame = frame
        }, completion:nil)
    }
    
    
    override open func dismissView(_ presentedView: UIView, presentingView: UIView, animationDuration: Double, completion: ((_ completed: Bool) -> Void)?) {
        finishAnimation()
        finishAnimation()
        
        let animationSettings = settings.animation.dismiss
        UIView.animate(withDuration: animationDuration,
            delay: animationSettings.delay,
            usingSpringWithDamping: animationSettings.damping,
            initialSpringVelocity: animationSettings.springVelocity,
            options: animationSettings.options,
            animations: { [weak self] in
                self?.backgroundView.alpha = 0.0
            },
            completion:nil)
        
        gravityBehavior.action = { [weak self] in
            if let me = self {
                let progress = min(1.0, me.collectionView.frame.origin.y / (me.contentHeight + (me.topSpace - me.contextView.topSpace)))
                let pixels = min(20, progress * 150.0)
                me.contextView.diff = -pixels
                me.contextView.setNeedsDisplay()
                
                if me.collectionView.frame.origin.y > me.view.bounds.size.height {
                    self?.animator.removeAllBehaviors()
                    completion?(true)
                }
            }
        }
        animator.addBehavior(gravityBehavior)
    }
    
    // MARK: - Private Helpers
    
    fileprivate var diff = CGFloat(0)
    fileprivate var displayLink: CADisplayLink!
    fileprivate var animationCount = 0
    
    fileprivate lazy var animator: UIDynamicAnimator = { [unowned self] in
        let animator = UIDynamicAnimator(referenceView: self.view)
        return animator
    }()
    
    fileprivate lazy var gravityBehavior: UIGravityBehavior = { [unowned self] in
        let gravityBehavior = UIGravityBehavior(items: [self.collectionView])
        gravityBehavior.magnitude = 2.0
        return gravityBehavior
    }()

    @objc fileprivate func update(_ displayLink: CADisplayLink) {
        let normalRectLayer = normalAnimationRect.layer.presentation()
        let springRectLayer = springAnimationRect.layer.presentation()
        
        guard let normalRectFrame = normalRectLayer?.frame,
          let springRectFrame = springRectLayer?.frame else {
            return
        }
        contextView.diff = normalRectFrame.origin.y - springRectFrame.origin.y
        contextView.setNeedsDisplay()
    }
    
    fileprivate func startAnimation() {
        if displayLink == nil {
            self.displayLink = CADisplayLink(target: self, selector: #selector(SkypeActionController.update(_:)))
            self.displayLink.add(to: RunLoop.main, forMode: RunLoop.Mode.default)
        }
        animationCount += 1
    }
    
    fileprivate func finishAnimation() {
        animationCount -= 1
        if animationCount == 0 {
            displayLink.invalidate()
            displayLink = nil
        }
    }
    
    fileprivate class ContextView: UIView {
        let topSpace = CGFloat(25)
        var diff = CGFloat(0)
        var animatedBackgroundColor: UIColor!

        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .clear
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func draw(_ rect: CGRect) {
            let path = UIBezierPath()
            
            path.move(to: CGPoint(x: 0, y: frame.height))
            path.addLine(to: CGPoint(x: frame.width, y: frame.height))
            path.addLine(to: CGPoint(x: frame.width, y: topSpace))
            path.addQuadCurve(to: CGPoint(x: 0, y: topSpace), controlPoint: CGPoint(x: frame.width/2, y: topSpace - diff))
            path.close()

            guard let context = UIGraphicsGetCurrentContext() else {
              return
            }
            context.addPath(path.cgPath)
            animatedBackgroundColor.set()
            context.fillPath()
        }
    }
}

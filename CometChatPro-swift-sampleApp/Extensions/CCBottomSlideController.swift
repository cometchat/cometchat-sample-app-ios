
//  CCBottomSlideController.swift

import UIKit

private var ContentOffsetKVO = 0
private var ConstraintConstantKVO = 1;


// This protocol deald with the Swipe Transitions of UIViewController.
public protocol CCBottomSlideDelegate: class {
    func didPanelCollapse()
    func didPanelExpand()
    func didPanelAnchor()
    func didPanelMove(panelOffset: CGFloat)
}

// This is clas Of Type CCBottomSlideController which deals with the important declarations for sliding the UIViewController from bottom to up and vise-versa.

public class CCBottomSlideController : NSObject, UIGestureRecognizerDelegate
{
    public enum SlideState
    {
        case collapsed
        case expanded
        case anchored
        case hidden
    }
    
    var topConstraint:NSLayoutConstraint!;
    var heightConstraint:NSLayoutConstraint!;
    weak var view:UIView!;
    weak var bottomView:UIView!;
    weak var scrollView:UIScrollView?;
    weak var tabBarController:UITabBarController?;
    weak var navigationController:UINavigationController?;
    
    
    private var expectedHeight:CGFloat!;
    private var initalLocation:CGFloat!;
    private var initialTouchLocation:CGFloat!;
    private var originalConstraint:CGFloat!;
    private var panGestureRecognizer:UIPanGestureRecognizer!;
    private var visibleHeight:CGFloat = 0;
    private var anchorPointInPixels:CGFloat = 0;
    private var lastSetAnchor:CGFloat = 0;
    private var isInMotion = false;
    private var topPadding:CGFloat = 0;
    
    public var currentState = SlideState.collapsed;
    public weak var delegate:CCBottomSlideDelegate?;
    public var isPanelExpanded:Bool = false;
    public var onPanelExpanded: (() -> Void)?
    public var onPanelCollapsed: (() -> Void)?
    public var onPanelAnchored: (() -> Void)?
    public var onPanelMoved: ((CGFloat) -> Void)?
    
    
    public init(topConstraint:NSLayoutConstraint, heightConstraint: NSLayoutConstraint, parent: UIView, bottomView: UIView, tabController:UITabBarController?, navController:UINavigationController?, visibleHeight: CGFloat){
        super.init()
        
        self.topConstraint = topConstraint;
        self.heightConstraint = heightConstraint;
        self.view = parent;
        self.bottomView = bottomView;
        if(tabController != nil)
        {
            self.set(tabController: tabController!);
        }
        if(navController != nil)
        {
            self.set(navController: navController!);
        }
        self.initBottomPanel(visibleHeight: visibleHeight, shouldAnimate: false)
        addConstraintChangeKVO()
    }
    
    public init(parent: UIView, bottomView: UIView, tabController:UITabBarController?, navController:UINavigationController?, visibleHeight: CGFloat){
        super.init()
        
        self.view = parent;
        self.bottomView = bottomView;
        if(tabController != nil)
        {
            self.set(tabController: tabController!);
        }
        if(navController != nil)
        {
            self.set(navController: navController!);
        }
        
        self.setPrimaryConstraints();
        self.initBottomPanel(visibleHeight: visibleHeight, shouldAnimate: false)
        addConstraintChangeKVO()
    }
    
    
    deinit
    {
        print("Bottom panel deiniting");
        removeConstraintChangeKVO()
        
        if scrollView != nil{
            self.removeKVO(scrollView: scrollView!)
        }
        if(panGestureRecognizer != nil){
            bottomView?.removeGestureRecognizer(panGestureRecognizer)
        }
        
        self.bottomView = nil;
        self.view = nil;
        self.topConstraint = nil;
        self.heightConstraint = nil;
    }
    
    private func setPrimaryConstraints()
    {
        
        self.bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        self.topConstraint = NSLayoutConstraint(item: self.bottomView, attribute: .bottom, relatedBy: .equal, toItem: view,
                                                attribute:.bottom, multiplier: 1, constant: 0)
        let startConstraint = NSLayoutConstraint(item: self.bottomView, attribute: .leading, relatedBy: .equal, toItem: view,
                                                 attribute: .leading, multiplier: 1, constant: 0)
        let endConstraint = NSLayoutConstraint(item: self.bottomView, attribute: .trailing, relatedBy: .equal, toItem: view,
                                               attribute: .trailing, multiplier: 1, constant: 0)
        self.heightConstraint = NSLayoutConstraint(item: self.bottomView, attribute: .height, relatedBy: .equal, toItem: nil,
                                                   attribute: .notAnAttribute, multiplier: 1, constant: view.frame.height)
        
        
        view.addConstraints([startConstraint, endConstraint, self.topConstraint, self.heightConstraint])
        self.view.layoutIfNeeded()
        
    }
    
    public func viewWillTransition(to size:CGSize, with coordinator: UIViewControllerTransitionCoordinator){
        //Start Animation to new Size
        reinitBottomController(with: size)
        coordinator.animate(alongsideTransition: nil, completion: {
            _ in
            //Need to reinit to acquire new height of Status bar, Navigation bar and so on/
            self.initBottomPanel(visibleHeight: self.visibleHeight, shouldAnimate: true)
            self.setAnchorPoint(anchor: self.lastSetAnchor);
        })
    }
    
    
    //MARK: Setters
    public func set(navController: UINavigationController)
    {
        self.navigationController = navController;
    }
    
    public func set(tabController: UITabBarController)
    {
        self.tabBarController = tabController;
    }
    
    public func set(table:UITableView)
    {
        if (scrollView != nil){
            self.removeKVO(scrollView: scrollView!)
        }
        
        scrollView = table;
        //scrollView!.panGestureRecognizer.require(toFail: panGestureRecognizer)
        self.addKVO(scrollView: scrollView!);
    }
    
    
    //MARK: Toggles
    public func expandPanel()
    {
        if(currentState != .expanded){
            performExpandPanel()
        }
    }
    
    public func anchorPanel()
    {
        if(currentState != .anchored){
            movePanelToAnchor()
        }
    }
    
    public func closePanel()
    {
        if(currentState != .collapsed){
            performClosePanel()
        }
    }
    
    public func hidePanel()
    {
        if(currentState != .hidden)
        {
            performHidePanel()
        }
    }
    
    public func setSlideEnabled(_ enabled: Bool)
    {
        self.panGestureRecognizer?.isEnabled = enabled;
        
    }
    
    
    //MARK: init
    private func reinitBottomController(with size:CGSize){
        let extrasHeight = UIApplication.shared.statusBarFrame.height +
            (self.navigationController?.navigationBar.frame.height ?? 0)
        
        expectedHeight = size.height - extrasHeight;
        self.anchorPointInPixels = expectedHeight * (1 - lastSetAnchor);
        heightConstraint.constant = expectedHeight;
        
        if(currentState == .expanded){
            self.topConstraint.constant = self.topPadding;
        }else if(currentState == .anchored){
            self.topConstraint.constant = anchorPointInPixels;
        }else if(currentState == .collapsed){
            //performClosePanel()
            heightConstraint.constant = expectedHeight;
            topConstraint.constant = (size.height - visibleHeight - (self.tabBarController?.tabBar.frame.size.height ?? 0));
        }else{
            performHidePanel()
        }
        
        originalConstraint = (size.height - extrasHeight - visibleHeight - (self.tabBarController?.tabBar.frame.size.height ?? 0));
        bottomView.layoutIfNeeded()
    }
    
    
    private func initBottomPanel(visibleHeight:CGFloat, shouldAnimate:Bool)
    {
        self.visibleHeight = visibleHeight
        
        panGestureRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(self.moveViewWithGestureRecognizer(panGestureRecognizer:)))
        panGestureRecognizer.delegate = self;
        bottomView.addGestureRecognizer(panGestureRecognizer);
        updateConstraint(visibleHeight, shouldAnimate: shouldAnimate);
    }
    
    private func updateConstraint(_ visibleHeight:CGFloat, shouldAnimate:Bool) -> Void
    {        
        let extrasHeight = UIApplication.shared.statusBarFrame.height +
            (self.navigationController?.navigationBar.frame.height ?? 0)
        expectedHeight = self.view.bounds.size.height - extrasHeight;
        originalConstraint = (self.view.bounds.size.height - extrasHeight - visibleHeight - (self.tabBarController?.tabBar.frame.size.height ?? 0));
        heightConstraint.constant = expectedHeight;
        
        
        if(currentState == .expanded){
            if(shouldAnimate){
                performExpandPanel()
            }else{
                self.topConstraint.constant = self.topPadding;
            }
        }else if(currentState == .anchored){
            if(shouldAnimate){
                movePanelToAnchor()
            }else{
                self.topConstraint.constant = anchorPointInPixels;
            }
            
        }else if(currentState == .collapsed){
            if(shouldAnimate){
                performClosePanel()
            }else{
                topConstraint.constant = originalConstraint
            }
        }else{
            performHidePanel()
        }
        
        bottomView.layoutIfNeeded()
    }
    
    public func setExpandedTopMargin(pixels: CGFloat)
    {
        var checkedPixels = pixels;
        if(checkedPixels < 0){
            checkedPixels = 0;
        }
        
        self.topPadding = pixels;
    }
    
    
    public func setAnchorPoint(anchor:CGFloat)
    {
        var checkedAnchor = anchor;
        
        
        if(checkedAnchor > 1)
        {
            checkedAnchor = 1;
        }else if(checkedAnchor < 0)
        {
            checkedAnchor = 0;
        }
        lastSetAnchor = anchor;
        self.anchorPointInPixels = self.expectedHeight * (1 - checkedAnchor);
    }
    
    
    //MARK: Gesture recognition
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if(currentState != .collapsed && scrollView != nil){
            if let tempTableView:UITableView = scrollView as? UITableView{
                
                let check = tempTableView.isEditing;
                let locationInTable = touch.location(in: bottomView);
                if(check && tempTableView.frame.contains(locationInTable)){
                    return false;
                }
            }
        }
        
        return true;
    }
    
    
    public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        initalLocation = topConstraint.constant;
        initialTouchLocation = touches.first?.location(in: self.view).y
    }
    
    @objc func moveViewWithGestureRecognizer(panGestureRecognizer:UIPanGestureRecognizer ){
        let touchLocation:CGPoint = panGestureRecognizer.location(in: self.view);
        if initialTouchLocation == nil{
            initialTouchLocation = touchLocation.y;
            initalLocation = topConstraint.constant;
        }
        
        if(panGestureRecognizer.state == .changed){
            
            topConstraint.constant = initalLocation - (initialTouchLocation - touchLocation.y)
            
            if(topConstraint.constant < self.topPadding)
            {
                topConstraint.constant = self.topPadding;
            }else if(topConstraint.constant > originalConstraint)
            {
                topConstraint.constant = originalConstraint;
            }
            
            isInMotion = true;
            
            UIView.animate(withDuration: 0.1, animations: {
                self.view.layoutIfNeeded();
            }, completion: { _ in
                self.isInMotion = false;
            });
            
            
        }else if(panGestureRecognizer.state == .ended){
            
            if(!panGestureRecognizer.isUp(theViewYouArePassing: self.view)){
                
                if(initialTouchLocation - touchLocation.y > 23){
                    if(topConstraint.constant < anchorPointInPixels - 23){
                        self.performExpandPanel()
                    }else{
                        self.movePanelToAnchor()
                    }
                }else{
                    
                    
                    if(topConstraint.constant > anchorPointInPixels + 23)
                    {
                        self.performClosePanel()
                    }else{
                        self.movePanelToAnchor()
                    }
                    
                }
            }else {
                
                
                if(topConstraint.constant > anchorPointInPixels + 23){
                    self.performClosePanel()
                }else{
                    self.movePanelToAnchor()
                }
                
                
            }
            initialTouchLocation = nil;
        }
        
    }
    
    
    private func movePanel(by offset:CGFloat)
    {
        if(initalLocation == nil)
        {
            initalLocation = topConstraint.constant
        }
        
        topConstraint.constant = (initalLocation - offset);
        
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded();
        }, completion: { _ in
            self.isInMotion = false;
        });
        
    }
    
    private func movePanelToAnchor()
    {
        currentState = .anchored
        
        isPanelExpanded = true;
        isInMotion = true;
        
        self.topConstraint.constant = anchorPointInPixels;
        
        self.view.setNeedsLayout();
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded();
            
        }, completion: { _ in
            self.isInMotion = false;
        });
        
        
        delegate?.didPanelAnchor();
        self.onPanelAnchored?();
    }
    
    private func performExpandPanel()
    {
        
        currentState = .expanded;
        isInMotion = true;
        
        isPanelExpanded = true;
        self.topConstraint.constant = self.topPadding;
        
        self.view.setNeedsLayout();
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded();
        }, completion: { _ in
            self.isInMotion = false;
        });
        
        delegate?.didPanelExpand();
        self.onPanelExpanded?();
    }
    
    
    private func performClosePanel()
    {
        currentState = .collapsed
        isInMotion = true;
        
        isPanelExpanded = false;
        self.view.layoutIfNeeded();
        
        UIView.animate(withDuration: 0.25, animations: {
            self.topConstraint.constant = self.originalConstraint;
            self.view.layoutIfNeeded();
        }, completion: { _ in
            self.isInMotion = false;
        });
        
        delegate?.didPanelCollapse();
        self.onPanelCollapsed?();
    }
    
    private func performHidePanel()
    {
        currentState = .hidden
        isInMotion = true;
        isPanelExpanded = false;
        self.view.layoutIfNeeded();
        
        UIView.animate(withDuration: 0.25, animations: {
            self.topConstraint.constant = self.originalConstraint + self.visibleHeight;
            self.view.layoutIfNeeded();
        }, completion: { _ in
            self.isInMotion = false;
        });
        
        delegate?.didPanelCollapse();
        self.onPanelCollapsed?();
        
    }
    
    private func addConstraintChangeKVO()
    {
        topConstraint?.addObserver(self, forKeyPath: "constant", options: [.initial, .new], context: &ConstraintConstantKVO);
    }
    
    private func removeConstraintChangeKVO()
    {
        topConstraint?.removeObserver(self, forKeyPath: "constant", context: &ConstraintConstantKVO);
    }
    
    //MARK: Tableview
    private func removeKVO(scrollView: UIScrollView) {
        scrollView.removeObserver(
            self,
            forKeyPath: "contentOffset",
            context: &ContentOffsetKVO
        )
    }
    
    private func addKVO(scrollView: UIScrollView) {
        scrollView.addObserver(
            self,
            forKeyPath: "contentOffset",
            options: [.initial, .new],
            context: &ContentOffsetKVO
        )
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
            
        case .some("contentOffset"):
            checkOffset();
        case .some("constant"):
            firePanelMoved();
        default:
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
        
    }
    
    private func firePanelMoved()
    {
        let offset:CGFloat = 1 - (topConstraint.constant/originalConstraint);
        self.delegate?.didPanelMove(panelOffset: offset)
        self.onPanelMoved?(offset)
        
    }
    
    func checkOffset()
    {        
        if scrollView == nil || isInMotion{
            return
        }
        
        if(scrollView!.contentOffset.y < -50)
        {
            if(currentState == .anchored){
                self.closePanel();
            }else if(currentState == .expanded){
                self.movePanelToAnchor()
            }
        }else if(scrollView!.contentOffset.y > 50){
            if(currentState == .anchored || anchorPointInPixels <= self.topPadding){
                self.expandPanel()
            }else if(currentState == .collapsed){
                self.movePanelToAnchor()
            }
        }
    }
    
    
}

public extension UIPanGestureRecognizer {
    
    func isLeft(theViewYouArePassing: UIView) -> Bool {
        let vel : CGPoint = velocity(in: theViewYouArePassing)
        if vel.x > 0 {
            return false
        } else {
            return true
        }
    }
    
    
    func isUp(theViewYouArePassing: UIView) -> Bool {
        let vel : CGPoint = velocity(in: theViewYouArePassing)
        if vel.y <= 0 {
            return false
        } else {
            return true
        }
    }
}

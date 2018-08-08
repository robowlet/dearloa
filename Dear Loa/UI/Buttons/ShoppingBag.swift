//
//  ShoppingBag.swift
//  Dear Loa
//
//  Created by Rob Miguel on 8/8/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation

import UIKit

class ShoppingBag: UITabBarItem {
    
    @IBInspectable var userInteractionEnabled: Bool = true {
        didSet {
            self.cartView.isUserInteractionEnabled = self.userInteractionEnabled
        }
    }
    
    private var cartView: CartButtonView!
    
    // ----------------------------------
    //  MARK: - Init -
    //
    override init() {
        super.init()
        
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initialize()
    }
    
    override var customView: UIView? {
        didSet {
            if self.customView !== self.cartView {
                self.customView = self.cartView
            }
        }
    }
    
    private func initialize() {
        self.cartView   = self.createCartButtonView()
        self.customView = self.cartView
        
        self.updateBadgeCount(animated: false)
        self.registerNotifications()
    }
    
    deinit {
        self.unregisterNotifications()
    }
    
    // ----------------------------------
    //  MARK: - Notifications -
    //
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(itemCountDidChange(_:)), name: Notification.Name.CartControllerItemsDidChange, object: nil)
    }
    
    private func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func itemCountDidChange(_ notification: Notification) {
        self.updateBadgeCount(animated: true)
        print("Badge count change notification received")
    }
    
    // ----------------------------------
    //  MARK: - Cart View -
    //
    private func createCartButtonView() -> CartButtonView {
        
        let cartView   = CartButtonView(type: .system)
        let cartImage  = #imageLiteral(resourceName: "cart")
        cartView.frame = CGRect(origin: .zero, size: cartImage.size).insetBy(dx: -10.0, dy: -5.0)
        
        cartView.contentHorizontalAlignment = .right
        cartView.setImage(cartImage, for: .normal)
        cartView.addTarget(self, action: #selector(cartAction(_:)), for: .touchUpInside)
        
        return cartView
    }
    
    // ----------------------------------
    //  MARK: - Update -
    //
    private func updateBadgeCount(animated: Bool) {
        self.cartView.setBadge(CartController.shared.itemCount, animated: animated)
    }
    
    // ----------------------------------
    //  MARK: - Actions -
    //
    @objc private func cartAction(_ sender: Any) {
        if let target = self.target,
            let selector = self.action {
            
            _ = target.perform(selector, with: sender)
        }
    }
}

// ----------------------------------
//  MARK: - CartButtonView -
//
private class CartButtonView: UIButton {
    
    private var badgeView: BadgeView!
    
    private var badgeTransformMin     = CATransform3DMakeScale(0.001, 0.001, 0.001)
    private var badgeTransformMid     = CATransform3DMakeScale(0.5, 0.5, 0.5)
    private var badgeTransformMax     = CATransform3DMakeScale(1.5, 1.5, 1.5)
    private var badgeTransformDefault = CATransform3DIdentity
    
    // ----------------------------------
    //  MARK: - Init -
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initialize()
    }
    
    private func initialize() {
        self.clipsToBounds = false
        self.initBadgeView()
    }
    
    private func initBadgeView() {
        self.badgeView = BadgeView(frame: .zero)
        self.addSubview(self.badgeView)
    }
    
    // ----------------------------------
    //  MARK: - Badge -
    //
    func setBadge(_ badge: Int, animated: Bool) {
        
        let setter = {
            self.badgeView.badge    = badge
            self.badgeView.isHidden = badge < 1
            
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
        
        guard self.badgeView.badge != badge else {
            setter()
            return
        }
        
        if animated {
            
            if self.badgeView.badge > 0 {
                
                if badge > 0 {
                    self.applyBadgeAnimation(.scale(badge > self.badgeView.badge ? .up : .down), changeHandler: setter)
                } else {
                    self.applyBadgeAnimation(.disappear, changeHandler: setter)
                }
                
            } else {
                self.applyBadgeAnimation(.appear, changeHandler: setter)
            }
            
        } else {
            setter()
        }
    }
    
    // ----------------------------------
    //  MARK: - Animations -
    //
    enum BadgeAnimationType {
        
        enum ScaleDirection {
            case up
            case down
        }
        
        case scale(ScaleDirection)
        case appear
        case disappear
    }
    
    private func applyBadgeAnimation(_ type: BadgeAnimationType, changeHandler: @escaping () -> Void) {
        switch type {
        case .scale(let direction):
            
            let transform: CATransform3D
            switch direction {
            case .up:
                transform = self.badgeTransformMax
            case .down:
                transform = self.badgeTransformMid
            }
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: [], animations: {
                self.badgeView.layer.transform = transform
            }, completion: { complete in
                
                changeHandler()
                
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: [], animations: {
                    self.badgeView.layer.transform = self.badgeTransformDefault
                }, completion: nil)
            })
            
        case .appear:
            
            changeHandler()
            
            self.badgeView.layer.transform = self.badgeTransformMin
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: [], animations: {
                self.badgeView.layer.transform = self.badgeTransformDefault
            }, completion: nil)
            
        case .disappear:
            
            UIView.animate(withDuration: 0.1, delay: 0.0, options: [], animations: {
                self.badgeView.layer.transform = self.badgeTransformMin
            }, completion: { complete in
                self.badgeView.layer.transform = self.badgeTransformDefault
                changeHandler()
            })
        }
    }
    
    // ----------------------------------
    //  MARK: - Layout -
    //
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layoutBadge()
    }
    
    private func layoutBadge() {
        self.badgeView.sizeToFit()
        self.badgeView.center = CGPoint(
            x: floor(self.bounds.width - 2.0),
            y: floor(0.0               + 5.0)
        )
    }
}

private class BadgeView: UIView {
    
    var badge: Int = 0 {
        didSet {
            self.label.text = "\(self.badge)"
            self.setNeedsLayout()
        }
    }
    
    private var label: UILabel!
    
    // ----------------------------------
    //  MARK: - Init -
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initialize()
    }
    
    private func initialize() {
        self.clipsToBounds   = true
        self.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.337254902, blue: 0.2156862745, alpha: 1).withAlphaComponent(0.9)
        
        self.initLabel()
    }
    
    private func initLabel() {
        self.label               = UILabel(frame: .zero)
        self.label.font          = UIFont(name: "AppleSDGothicNeo-Bold", size: 10.0)
        self.label.textAlignment = .center
        self.label.lineBreakMode = .byClipping
        self.label.numberOfLines = 1
        self.label.textColor     = .white
        self.label.shadowColor   = .clear
        
        self.addSubview(self.label)
    }
    
    // ----------------------------------
    //  MARK: - Layout -
    //
    override func sizeToFit() {
        super.sizeToFit()
        
        self.label.sizeToFit()
        
        var bounds        = self.label.bounds.insetBy(dx: -5.0, dy: -1.0).ceiled
        bounds.size.width = max(bounds.size.height, bounds.size.width) // prevent height exceeding width
        self.bounds       = bounds
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var frame        = self.bounds
        frame.origin.y  += 1.0 / UIScreen.main.scale
        self.label.frame = frame
        
        self.layer.cornerRadius = self.bounds.height * 0.5
    }
}

private extension CGRect {
    
    var ceiled: CGRect {
        return CGRect(
            x:      ceil(self.origin.x),
            y:      ceil(self.origin.y),
            width:  ceil(self.width),
            height: ceil(self.height)
        )
    }
}

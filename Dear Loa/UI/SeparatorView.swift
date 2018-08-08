//
//  SeparatorView.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import UIKit

class SeparatorView: UIView {
    
    enum Position: Int {
        case top
        case left
        case bottom
        case right
    }
    
    @IBInspectable dynamic private var separatorPosition: Int = 0 {
        willSet(positionValue) {
            self.position = Position(rawValue: positionValue)!
        }
    }
    
    var position: Position = .top {
        didSet {
            guard let superview = self.superview else {
                return
            }
            
            self.updateFrameIn(superview)
            self.updateAutoresizeMask()
        }
    }
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(position: Position) {
        self.position = position
        
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // ----------------------------------
    //  MARK: - Superview -
    //
    override func willMove(toSuperview newSuperview: UIView?) {
        if let superview = newSuperview {
            self.updateFrameIn(superview)
            self.updateAutoresizeMask()
        }
    }
    
    // ----------------------------------
    //  MARK: - Updates -
    //
    private func updateFrameIn(_ superview: UIView) {
        
        let length = 1.0 / UIScreen.main.scale
        var frame  = superview.bounds
        
        switch self.position {
        case .top:
            frame.size.height = length
            frame.size.width  = superview.bounds.width
        case .bottom:
            frame.size.height = length
            frame.size.width  = superview.bounds.width
            frame.origin.y    = superview.bounds.height - length
        case .left:
            frame.size.height = superview.bounds.height
            frame.size.width  = length
            frame.origin.y    = superview.bounds.height - length
        case .right:
            frame.size.height = superview.bounds.height
            frame.size.width  = length
            frame.origin.x    = superview.bounds.width - length
        }
        
        self.frame = frame
    }
    
    private func updateAutoresizeMask() {
        switch self.position {
        case .top:
            self.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        case .left:
            self.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        case .bottom:
            self.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        case .right:
            self.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        }
    }
}

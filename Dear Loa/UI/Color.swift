//
//  Color.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import UIKit

extension UIColor {
    
    private convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(
            red:   r/255.0,
            green: g/255.0,
            blue:  b/255.0,
            alpha: 1.0
        )
    }
    
    static let applicationGreen = UIColor(r: 100.0, g: 183.0, b: 56.0)
}

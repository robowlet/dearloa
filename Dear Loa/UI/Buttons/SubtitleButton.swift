//
//  SubtitleButton.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//


import UIKit

class SubtitleButton: RoundedButton {
    
    @IBInspectable var subtitle: String = ""
    
    override func setTitle(_ title: String?, for state: UIControlState) {
        
        guard let title = title else {
            super.setTitle(nil, for: state)
            return
        }
        
        let currentFont  = self.titleLabel!.font!
        let currentColor = self.titleColor(for: state) ?? .white
        
        let style           = NSMutableParagraphStyle()
        style.alignment     = .center
        style.lineBreakMode = .byClipping
        
        let attributedTitle = NSMutableAttributedString(string: title, attributes: [
            NSAttributedStringKey.font           : currentFont,
            NSAttributedStringKey.paragraphStyle : style,
            NSAttributedStringKey.foregroundColor: currentColor
            ])
        
        let attributedSubtitle = NSAttributedString(string: "\n\(self.subtitle)", attributes: [
            NSAttributedStringKey.font           : UIFont(descriptor: currentFont.fontDescriptor, size: currentFont.pointSize * 0.6),
            NSAttributedStringKey.paragraphStyle : style,
            NSAttributedStringKey.foregroundColor: currentColor.withAlphaComponent(0.6)
            ])
        
        attributedTitle.append(attributedSubtitle)
        
        self.titleLabel?.numberOfLines = 0
        
        super.setAttributedTitle(attributedTitle, for: state)
    }
}

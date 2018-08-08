//
//  SelectableCell.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import UIKit

protocol Selectable: class {
    
    var highlightView: UIView { get }
}

extension Selectable {
    
    func applyHighlightIn(view: UIView) {
        self.highlightView.frame           = view.bounds
        self.highlightView.backgroundColor = view.tintColor.withAlphaComponent(0.04)
        view.addSubview(self.highlightView)
    }
    
    func removeHighlight() {
        self.highlightView.removeFromSuperview()
    }
}

class SelectableCollectionCell: UICollectionViewCell, Selectable {
    
    lazy var highlightView = UIView()
    
    override var isHighlighted: Bool {
        willSet(highlighted) {
            
            if highlighted {
                self.applyHighlightIn(view: self.contentView)
            } else {
                self.removeHighlight()
            }
        }
    }
}

class SelectableTableCell: UITableViewCell, Selectable {
    
    lazy var highlightView = UIView()
    
    override var isHighlighted: Bool {
        willSet(highlighted) {
            
            if highlighted {
                self.applyHighlightIn(view: self.contentView)
            } else {
                self.removeHighlight()
            }
        }
    }
}

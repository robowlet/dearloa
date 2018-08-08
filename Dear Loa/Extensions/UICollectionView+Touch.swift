//
//  UICollectionView+Touch.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func rectForItem(at indexPath: IndexPath) -> CGRect? {
        if let attributes = self.layoutAttributesForItem(at: indexPath) {
            return attributes.frame
        }
        return nil
    }
}

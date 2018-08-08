//
//  StorefrontTableView.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import UIKit

protocol StorefrontTableViewDelegate: class {
    func tableViewShouldBeginPaging(_ table: StorefrontTableView) -> Bool
    func tableViewWillBeginPaging(_ table: StorefrontTableView)
    func tableViewDidCompletePaging(_ table: StorefrontTableView)
}

class StorefrontTableView: UITableView, Paginating {
    
    @IBInspectable private dynamic var cellNibName: String?
    
    weak var paginationDelegate: StorefrontTableViewDelegate?
    
    var paginationThreshold: CGFloat             = 500.0
    var paginationState:     PaginationState     = .ready
    var paginationDirection: PaginationDirection = .verical
    
    // ----------------------------------
    //  MARK: - Awake -
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let className = self.value(forKey: "cellNibName") as? String {
            self.register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
        }
    }
    
    // ----------------------------------
    //  MARK: - Layout -
    //
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.trackPaging()
    }
    
    func shouldBeginPaging() -> Bool {
        return self.paginationDelegate?.tableViewShouldBeginPaging(self) ?? false
    }
    
    func willBeginPaging() {
        print("Paging table view...")
        self.paginationDelegate?.tableViewWillBeginPaging(self)
    }
    
    func didCompletePaging() {
        print("Finished paging table view.")
        self.paginationDelegate?.tableViewDidCompletePaging(self)
    }
}

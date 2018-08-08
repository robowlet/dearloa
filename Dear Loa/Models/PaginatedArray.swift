//
//  PaginatedArray.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation
import MobileBuySDK

struct PageableArray<T: ViewModel> {
    
    private(set) var items: [T]
    
    var hasNextPage: Bool {
        return pageInfo.hasNextPage
    }
    
    var hasPreviousPage: Bool {
        return pageInfo.hasPreviousPage
    }
    
    private var pageInfo: Storefront.PageInfo
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(with items: [T], pageInfo: Storefront.PageInfo) {
        self.items    = items
        self.pageInfo = pageInfo
    }
    
    init<M>(with items: [M], pageInfo: Storefront.PageInfo) where M: ViewModeling, M.ViewModelType == T {
        self.items    = items.viewModels
        self.pageInfo = pageInfo
    }
    
    // ----------------------------------
    //  MARK: - Adding -
    //
    mutating func appendPage(from pageableArray: PageableArray<T>) {
        self.items.append(contentsOf: pageableArray.items)
        self.pageInfo = pageableArray.pageInfo
    }
}

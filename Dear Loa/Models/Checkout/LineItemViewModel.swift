//
//  LineItemViewModel.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation
import MobileBuySDK

final class LineItemViewModel: ViewModel {
    
    typealias ModelType = Storefront.CheckoutLineItemEdge
    
    let model:    ModelType
    let cursor:   String
    
    let variantID:       String?
    let title:           String
    let quantity:        Int
    let individualPrice: Decimal
    let totalPrice:      Decimal
    
    // ----------------------------------
    //  MARK: - Init -
    //
    required init(from model: ModelType) {
        self.model           = model
        self.cursor          = model.cursor
        
        self.variantID       = model.node.variant!.id.rawValue
        self.title           = model.node.title
        self.quantity        = Int(model.node.quantity)
        self.individualPrice = model.node.variant!.price
        self.totalPrice      = self.individualPrice * Decimal(self.quantity)
    }
}

extension Storefront.CheckoutLineItemEdge: ViewModeling {
    typealias ViewModelType = LineItemViewModel
}

//
//  ShippingRateViewModel.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation
import MobileBuySDK

final class ShippingRateViewModel: ViewModel {
    
    typealias ModelType = Storefront.ShippingRate
    
    let model:  ModelType
    
    let handle: String
    let title:  String
    let price:  Decimal
    
    // ----------------------------------
    //  MARK: - Init -
    //
    required init(from model: ModelType) {
        self.model  = model
        
        self.handle = model.handle
        self.title  = model.title
        self.price  = model.price
    }
}

extension Storefront.ShippingRate: ViewModeling {
    typealias ViewModelType = ShippingRateViewModel
}

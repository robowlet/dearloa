//
//  ShippingRateViewModel+PayShippingRate.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation
import MobileBuySDK

extension ShippingRateViewModel {
    
    var payShippingRate: PayShippingRate {
        
        return PayShippingRate(
            handle:        self.handle,
            title:         self.title,
            price:         self.price,
            deliveryRange: nil
        )
    }
}

extension Array where Element == ShippingRateViewModel {
    
    var payShippingRates: [PayShippingRate] {
        return self.map {
            $0.payShippingRate
        }
    }
}

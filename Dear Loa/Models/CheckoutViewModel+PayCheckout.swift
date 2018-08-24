//
//  CheckoutViewModel+PayCheckout.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation
import MobileBuySDK

extension CheckoutViewModel {
    
    var payCheckout: PayCheckout {
        
        let payItems = self.lineItems.map { item in
            PayLineItem(price: item.individualPrice, quantity: item.quantity)
        }
        
//        return PayCheckout(
//            id:              self.id,
//            lineItems:       payItems,
//            discount:        nil,
//            shippingAddress: self.shippingAddress?.payAddress,
//            shippingRate:    self.shippingRate?.payShippingRate,
//            subtotalPrice:   self.subtotalPrice,
//            needsShipping:   self.requiresShipping,
//            totalTax:        self.totalTax,
//            paymentDue:      self.paymentDue
//        )
        
        return PayCheckout(
            id:                 self.id,
            lineItems:          payItems,
            giftCards:          nil,
            discount:           nil,
            shippingAddress:    self.shippingAddress?.payAddress,
            shippingRate:       self.shippingRate?.payShippingRate,
            subtotalPrice:      self.subtotalPrice,
            needsShipping:      self.requiresShipping,
            totalTax:           self.totalTax,
            paymentDue:         self.paymentDue)
    }
}


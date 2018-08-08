//
//  Fragment+PaymentQuery.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/30/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation
import MobileBuySDK

extension Storefront.PaymentQuery {
    
    @discardableResult
    func fragmentForPayment() -> Storefront.PaymentQuery { return self
        .id()
        .ready()
        .test()
        .amount()
        .checkout { $0
            .fragmentForCheckout()
        }
        .creditCard { $0
            .firstDigits()
            .lastDigits()
            .maskedNumber()
            .brand()
            .firstName()
            .lastName()
            .expiryMonth()
            .expiryYear()
        }
        .errorMessage()
    }
}

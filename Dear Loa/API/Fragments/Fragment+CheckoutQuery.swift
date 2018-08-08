//
//  Fragment+CheckoutQuery.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/30/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation
import MobileBuySDK

extension Storefront.CheckoutQuery {
    
    @discardableResult
    func fragmentForCheckout() -> Storefront.CheckoutQuery { return self
        .id()
        .ready()
        .requiresShipping()
        .taxesIncluded()
        .email()
        
        .shippingAddress { $0
            .firstName()
            .lastName()
            .phone()
            .address1()
            .address2()
            .city()
            .country()
            .countryCode()
            .province()
            .provinceCode()
            .zip()
        }
        
        .shippingLine { $0
            .handle()
            .title()
            .price()
        }
        
        .note()
        .lineItems(first: 250) { $0
            .edges { $0
                .cursor()
                .node { $0
                    .variant { $0
                        .id()
                        .price()
                    }
                    .title()
                    .quantity()
                }
            }
        }
        .webUrl()
        .currencyCode()
        .subtotalPrice()
        .totalTax()
        .totalPrice()
        .paymentDue()
    }
}

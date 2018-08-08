//
//  CheckoutViewModel.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation
import MobileBuySDK

final class CheckoutViewModel: ViewModel {
    
    typealias ModelType = Storefront.Checkout
    
    let model:  ModelType
    
    enum PaymentType: String {
        case applePay   = "apple_pay"
        case creditCard = "credit_card"
    }
    
    let id:               String
    let ready:            Bool
    let requiresShipping: Bool
    let taxesIncluded:    Bool
    let shippingAddress:  AddressViewModel?
    let shippingRate:     ShippingRateViewModel?
    
    let note:             String?
    let webURL:           URL
    
    let lineItems:        [LineItemViewModel]
    let currencyCode:     String
    let subtotalPrice:    Decimal
    let totalTax:         Decimal
    let totalPrice:       Decimal
    let paymentDue:       Decimal
    
    // ----------------------------------
    //  MARK: - Init -
    //
    required init(from model: ModelType) {
        self.model            = model
        
        self.id               = model.id.rawValue
        self.ready            = model.ready
        self.requiresShipping = model.requiresShipping
        self.taxesIncluded    = model.taxesIncluded
        self.shippingAddress  = model.shippingAddress?.viewModel
        self.shippingRate     = model.shippingLine?.viewModel
        
        self.note             = model.note
        self.webURL           = model.webUrl
        
        self.lineItems        = model.lineItems.edges.viewModels
        self.currencyCode     = model.currencyCode.rawValue
        self.subtotalPrice    = model.subtotalPrice
        self.totalTax         = model.totalTax
        self.totalPrice       = model.totalPrice
        self.paymentDue       = model.paymentDue
    }
}

extension Storefront.Checkout: ViewModeling {
    typealias ViewModelType = CheckoutViewModel
}

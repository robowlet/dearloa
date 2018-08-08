//
//  PaymentViewModel.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation
import MobileBuySDK

final class PaymentViewModel: ViewModel {
    
    typealias ModelType = Storefront.Payment
    
    let model:  ModelType
    
    let id:         String
    let isReady:    Bool
    let isTest:     Bool
    let checkout:   CheckoutViewModel
    let creditCard: CreditCardViewModel?
    let amount:     Decimal
    let error:      String?
    
    // ----------------------------------
    //  MARK: - Init -
    //
    required init(from model: ModelType) {
        self.model      = model
        
        self.id         = model.id.rawValue
        self.checkout   = model.checkout.viewModel
        self.creditCard = model.creditCard?.viewModel
        self.amount     = model.amount
        self.isTest     = model.test
        self.isReady    = model.ready
        self.error      = model.errorMessage
    }
}

extension Storefront.Payment: ViewModeling {
    typealias ViewModelType = PaymentViewModel
}

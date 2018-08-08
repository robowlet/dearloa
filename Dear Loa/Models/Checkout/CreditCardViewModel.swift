//
//  CreditCardViewModel.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation
import MobileBuySDK

final class CreditCardViewModel: ViewModel {
    
    typealias ModelType = Storefront.CreditCard
    
    let model:  ModelType
    
    let firstName:    String?
    let lastName:     String?
    
    let firstDigits:  String?
    let lastDigits:   String?
    let maskedDigits: String?
    
    let expMonth:     Int?
    let expYear:      Int?
    let brand:        String?
    
    // ----------------------------------
    //  MARK: - Init -
    //
    required init(from model: ModelType) {
        self.model        = model
        
        self.firstName    = model.firstName
        self.lastName     = model.lastName
        
        self.firstDigits  = model.firstDigits
        self.lastDigits   = model.lastDigits
        self.maskedDigits = model.maskedNumber
        
        self.expMonth     = model.expiryMonth == nil ? nil : Int(model.expiryMonth!)
        self.expYear      = model.expiryYear  == nil ? nil : Int(model.expiryYear!)
        self.brand        = model.brand
    }
}

extension Storefront.CreditCard: ViewModeling {
    typealias ViewModelType = CreditCardViewModel
}

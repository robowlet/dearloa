//
//  AddressViewModel+PayAddress.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation
import MobileBuySDK

extension AddressViewModel {
    
    var payAddress: PayAddress {
        
        return PayAddress(
            addressLine1: self.address1,
            addressLine2: self.address2,
            city:         self.city,
            country:      self.country,
            province:     self.province,
            zip:          self.zip,
            firstName:    self.firstName,
            lastName:     self.lastName,
            phone:        self.phone,
            email:        nil
        )
    }
}

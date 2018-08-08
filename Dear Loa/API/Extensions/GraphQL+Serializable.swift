//
//  GraphQL+Serializable.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation
import MobileBuySDK

extension GraphQL.AbstractResponse: Serializable {
    
    static func deserialize(from representation: SerializedRepresentation) -> Self? {
        return try? self.init(fields: representation)
    }
    
    func serialize() -> SerializedRepresentation {
        return self.fields
    }
}

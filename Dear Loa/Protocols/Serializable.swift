//
//  Serializable.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation

typealias SerializedRepresentation = [String : Any]

protocol Serializable {
    
    static func deserialize(from representation: SerializedRepresentation) -> Self?
    
    func serialize() -> SerializedRepresentation
}

// ----------------------------------
//  MARK: - Collection Conveniences -
//
extension Array where Element: Serializable {
    
    static func deserialize(from representation: [SerializedRepresentation]) -> [Element]? {
        return representation.compactMap {
            Element.deserialize(from: $0)
        }
    }
    
    func serialize() -> [SerializedRepresentation] {
        return self.map {
            $0.serialize()
        }
    }
}

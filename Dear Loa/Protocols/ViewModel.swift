//
//  ViewModel.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation

protocol ViewModel: Serializable {
    
    associatedtype ModelType: Serializable
    
    var model: ModelType { get }
    
    init(from model: ModelType)
}

// ----------------------------------
//  MARK: - Serializable -
//
extension ViewModel {
    
    static func deserialize(from representation: SerializedRepresentation) -> Self? {
        if let model = ModelType.deserialize(from: representation) {
            return Self.init(from: model)
        }
        return nil
    }
    
    func serialize() -> SerializedRepresentation {
        return self.model.serialize()
    }
}

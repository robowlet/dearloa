//
//  ImageViewModel.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation
import MobileBuySDK

final class ImageViewModel: ViewModel {
    
    typealias ModelType = Storefront.ImageEdge
    
    let model:    ModelType
    let cursor:   String
    
    let url:      URL
    
    // ----------------------------------
    //  MARK: - Init -
    //
    required init(from model: ModelType) {
        self.model    = model
        self.cursor   = model.cursor
        
        self.url      = model.node.transformedSrc
    }
}

extension Storefront.ImageEdge: ViewModeling {
    typealias ViewModelType = ImageViewModel
}

//
//  ProductViewModel.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import Foundation
import MobileBuySDK

//qwerty2
struct VariantBuilder {
    static func getSizes(product: ProductViewModel) -> [String] {
        var sizes = [String]()
        for variant in product.variants.items {
            let string = variant.title
            let size = string.split(separator: "/")[0].trimmingCharacters(in: .whitespacesAndNewlines)
            if !sizes.contains(size) {
                sizes.append(size) // assuming the array sorts them correctly
            }
        }
        return sizes
    }
    
    static func getColors(product: ProductViewModel) -> [String] {
        var colors = [String]()
        for variant in product.variants.items {
            let string = variant.title
            let color = string.split(separator: "/")[1].trimmingCharacters(in: .whitespacesAndNewlines)
            if !colors.contains(color) {
                colors.append(color) // assuming the array sorts them correctly
            }
        }
        return colors
    }
    
    static func getVariant(from product: ProductViewModel, forSize size: String, andColor color: String) -> VariantViewModel {
        // combine size and color with a " / " in the middle
        var finalTitle = size + " / " + color
        // querry the product.variants.items.titles for a match
        let finalVariantIndex = product.variants.items.firstIndex { ( item ) -> Bool in
            return item.title == finalTitle
        }
        
        // grab the matching index
        // retun the variant at that index
        return product.variants.items[finalVariantIndex!]
    }
}

final class ProductViewModel: ViewModel {
    
    typealias ModelType = Storefront.ProductEdge
    
    let model:    ModelType
    let cursor:   String
    
    let id:       String
    let title:    String
    let summary:  String
    let price:    String
    let images:   PageableArray<ImageViewModel>
    let variants: PageableArray<VariantViewModel>
    
    // ----------------------------------
    //  MARK: - Init -
    //
    required init(from model: ModelType) {
        self.model    = model
        self.cursor   = model.cursor
        
        let variants = model.node.variants.edges.viewModels.sorted {
            $0.price < $1.price
        }
        
        let lowestPrice = variants.first?.price
        
        self.id       = model.node.id.rawValue
        self.title    = model.node.title
        self.summary  = model.node.descriptionHtml
        self.price    = lowestPrice == nil ? "No price" : Currency.stringFrom(lowestPrice!)
        
        self.images   = PageableArray(
            with:     model.node.images.edges,
            pageInfo: model.node.images.pageInfo
        )
        
        self.variants = PageableArray(
            with:     model.node.variants.edges,
            pageInfo: model.node.variants.pageInfo
        )
    }
}

extension Storefront.ProductEdge: ViewModeling {
    typealias ViewModelType = ProductViewModel
}

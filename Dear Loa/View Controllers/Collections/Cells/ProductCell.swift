//
//  ProductCell.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import UIKit

class ProductCell: SelectableCollectionCell, ViewModelConfigurable {
    
    typealias ViewModelType = ProductViewModel
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var imageView:  UIImageView!
    
    private(set) var viewModel: ProductViewModel?
    
    func configureFrom(_ viewModel: ProductViewModel) {
        self.viewModel = viewModel
        
        self.titleLabel.text = viewModel.title
        self.priceLabel.text = viewModel.price
        self.imageView.setImageFrom(viewModel.images.items.first?.url)
    }
}

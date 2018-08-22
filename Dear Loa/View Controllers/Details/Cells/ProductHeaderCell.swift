//
//  ProductHeaderCell.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import UIKit

protocol ProductHeaderDelegate: class {
    func productHeader(_ cell: ProductHeaderCell, didAddToCart sender: Any)
}

class ProductHeaderCell: UITableViewCell, ViewModelConfigurable {
    typealias ViewModelType = ProductViewModel
    
    weak var delegate: ProductHeaderDelegate?
    //qwerty
    //var sizeTappedCompletion: (() -> Void)?
    
    @IBOutlet private weak var titleLabel:  UILabel!
    @IBOutlet private weak var priceButton: UIButton!
    
    ///////////////////////
    @IBOutlet weak var sizeButton: UIButton!
    @IBOutlet weak var colorButton: UIButton!
    //////////////////////
    
    var viewModel: ViewModelType?
    
    // ----------------------------------
    //  MARK: - Configure -
    //
    func configureFrom(_ viewModel: ViewModelType) {
        self.viewModel = viewModel
        
        //self.titleLabel.text = viewModel.title
        self.priceButton.setTitle(viewModel.price, for: .normal)
        
        /////////////////////
        self.sizeButton.layer.cornerRadius = 4
        self.colorButton.layer.cornerRadius = 4
        ////////////////////
    }
}

extension ProductHeaderCell {
    
    @IBAction func addToCartAction(_ sender: Any) {
        self.delegate?.productHeader(self, didAddToCart: sender)
    }
//    @IBAction func sizeButtonTapped(_ sender: Any) {
//        sizeTappedCompletion?()
//    }
}

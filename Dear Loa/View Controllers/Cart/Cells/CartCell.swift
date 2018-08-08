//
//  CartCell.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import UIKit

protocol CartCellDelegate: class {
    func cartCell(_ cell: CartCell, didUpdateQuantity quantity: Int)
}

class CartCell: UITableViewCell, ViewModelConfigurable {
    
    typealias ViewModelType = CartItemViewModel
    
    weak var delegate: CartCellDelegate?
    
    @IBOutlet private weak var thumbnailView: UIImageView!
    @IBOutlet private weak var titleLabel:    UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var priceLabel:    UILabel!
    @IBOutlet private weak var quantityLabel: UILabel!
    @IBOutlet private weak var stepper:       UIStepper!
    
    var viewModel: ViewModelType?
    
    // ----------------------------------
    //  MARK: - Configure -
    //
    func configureFrom(_ viewModel: ViewModelType) {
        self.viewModel = viewModel
        
        self.titleLabel.text    = viewModel.title
        self.subtitleLabel.text = viewModel.subtitle
        self.priceLabel.text    = viewModel.price
        self.quantityLabel.text = viewModel.quantityDescription
        self.stepper.value      = Double(viewModel.quantity)
        
        self.thumbnailView.setImageFrom(viewModel.imageURL)
    }
}

// ----------------------------------
//  MARK: - Actions -
//
extension CartCell {
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        self.delegate?.cartCell(self, didUpdateQuantity: Int(sender.value))
    }
}

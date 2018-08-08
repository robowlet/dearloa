//
//  ProductDetailsCell.swift
//  Dear Loa
//
//  Created by Rob Miguel on 7/31/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import UIKit

class ProductDetailsCell: UITableViewCell, ViewModelConfigurable {
    typealias ViewModelType = ProductViewModel
    
    @IBOutlet private weak var contentLabel: UILabel!
    
    var viewModel: ViewModelType?
    
    // ----------------------------------
    //  MARK: - Configure -
    //
    func configureFrom(_ viewModel: ViewModelType) {
        self.viewModel = viewModel
        
        /* ---------------------------------
         ** This lable is intended to render
         ** only styled text represented by
         ** HTML. It will not display embeded
         ** video or other complex HTML objects.
         */
        self.contentLabel.attributedText = viewModel.summary.interpretAsHTML(font: "Apple SD Gothic Neo", size: 17.0)
    }
}

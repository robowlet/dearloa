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

class ProductHeaderCell: UITableViewCell, ViewModelConfigurable, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //////////////////////////////
    // SIZE PICKER
    private var sizePicker: UIPickerView!
    private let sizeValues: NSArray = ["0-3 months", "3-6 months", "6-9 months", "9-12 months", "12-18 months", "18-24 months", "2T", "3T", "4T"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {return 1}
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {return sizeValues.count}
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {return sizeValues[row] as? String}
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row: \(row)")
        print("value: \(sizeValues[row])")
        sizeButton.titleLabel?.text = "\(sizeValues[row])"
        sizePicker.isHidden = true
//        colorButton.titleLabel?.text = "\(colorValues[row])"
//        colorPicker.isHidden = true
        
    }
    
    // COLOR PICKER
    private var colorPicker: UIPickerView!
    private let colorValues: NSArray = ["Blue", "Green", "Red", "Yellow", "Black", "Pink", "White", "Gold"]
    
    
    
    /////////////////////////////
    
    typealias ViewModelType = ProductViewModel
    
    weak var delegate: ProductHeaderDelegate?
    //qwerty
    //var sizeTappedCompletion: (() -> Void)?
    
    @IBOutlet private weak var titleLabel:  UILabel!
    @IBOutlet private weak var priceButton: UIButton!
    
    ///////////////////////
    @IBOutlet weak var sizeButton: UIButton!
    @IBOutlet weak var colorButton: UIButton!
    
    @IBAction func sizeButtonTapped(_ sender: Any) {
        sizePicker = UIPickerView()
        
        sizePicker.frame = CGRect(x: 0, y: 0, width: (self.superview?.bounds.width)!, height: 100.0)
        sizePicker.delegate = self
        sizePicker.dataSource = self
        sizePicker.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.superview?.addSubview(sizePicker)
        //sizeButton.titleLabel?.text = "ahdfkahkh"
    }

    @IBAction func colorButtonTapped(_ sender: Any) {
        colorPicker = UIPickerView()
        colorPicker.frame = CGRect(x: 0, y: 0, width: (self.superview?.bounds.width)!, height: 100.0)
        colorPicker.delegate = self
        colorPicker.dataSource = self
        colorPicker.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.superview?.addSubview(colorPicker)
    }
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

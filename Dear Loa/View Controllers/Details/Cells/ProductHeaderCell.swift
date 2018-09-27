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
    
    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    
    @IBAction func sizeTapped(_ sender: Any) {
        pickerValues = sizeValues
        pickerDidSelectValue = { row in
            self.sizeTextField.placeholder = self.sizeValues[row]
            self.selectedSize = self.sizeValues[row]
            // set the size on the selected item in the cart...?
        }
    }
    @IBAction func colorTapped(_ sender: Any) {
        pickerValues = colorValues
        pickerDidSelectValue = { row in
            self.colorTextField.placeholder = self.colorValues[row]
            self.selectedColor = self.colorValues[row]
            // set the color on the selected item in the cart...?
        }
    }
    //////////////////////////////
    

    
    func createSizePicker() {
        let sizePicker = UIPickerView()
        sizePicker.delegate = self
    }
    
    
    // SIZE PICKER
    
    
    
    private var sizePicker: UIPickerView!
    private let sizeValues = ["0-3 months",
                              "3-6 months",
                              "6-9 months",
                              "9-12 months",
                              "12-18 months",
                              "18-24 months",
                              "2T",
                              "3T",
                              "4T"]
    
    // COLOR PICKER
    private var colorPicker: UIPickerView!
    private let colorValues = ["Cream Floral",
                               "Nutmeg Gingham",
                               "Fall Liberty Floral",
                               "Navy",
                               "Charcoal Grey",
                               "Pink",
                               "White",
                               "Gold",
                               "Blah"]
    
    var pickerValues = [String]()
    var pickerDidSelectValue: ((Int) -> Void)?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerValues[row] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row: \(row)")
        print("value: \(pickerValues[row])")
        pickerDidSelectValue?(row)
        
//        sizeTextField.placeholder = "\(sizeValues[row])"
//        colorTextField.placeholder = "\(colorValues[row])"
    }
    

    /////////////////////////////
    
    typealias ViewModelType = ProductViewModel
    
    weak var delegate: ProductHeaderDelegate?
    
    //qwerty
    //var sizeTappedCompletion: (() -> Void)?
    
    @IBOutlet private weak var titleLabel:  UILabel!
    @IBOutlet private weak var priceButton: UIButton!
    
    var viewModel: ViewModelType?
    
    // ----------------------------------
    //  MARK: - Configure -
    //
    func configureFrom(_ viewModel: ViewModelType) {
        self.viewModel = viewModel
        
        //self.titleLabel.text = viewModel.title
        self.priceButton.setTitle(viewModel.price, for: .normal)
        priceButton.isEnabled = false
        priceButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        setupPickers()
    }
    
    func setupPickers() {
        // UIPickerView
        let sizePicker: UIPickerView
        sizePicker = UIPickerView()
        sizePicker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        sizePicker.showsSelectionIndicator = true
        sizePicker.delegate = self
        sizePicker.dataSource = self
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(displayP3Red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneClicked(sender:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneClicked(sender:)))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        doneButton.tintColor = #colorLiteral(red: 0.1529411765, green: 0.168627451, blue: 0.2078431373, alpha: 1)
        cancelButton.tintColor = #colorLiteral(red: 0.1529411765, green: 0.168627451, blue: 0.2078431373, alpha: 1)
        
        sizeTextField.inputView = sizePicker
        sizeTextField.tintColor = UIColor.clear // hides the cursor
        sizeTextField.inputAccessoryView = toolBar
        
//        colorTextField.inputView = picker
//        colorTextField.inputAccessoryView = toolBar
        
        let colorPicker: UIPickerView
        colorPicker = UIPickerView()
        colorPicker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        colorPicker.showsSelectionIndicator = true
        colorPicker.delegate = self
        colorPicker.dataSource = self
        
        colorTextField.inputView = colorPicker
        colorTextField.tintColor = UIColor.clear
        colorTextField.inputAccessoryView = toolBar
        
        
        
    }
    
    var selectedSize: String?
    var selectedColor: String?
    
    
    @objc func doneClicked (sender: UIBarButtonItem) {
        self.sizeTextField.resignFirstResponder()
        self.colorTextField.resignFirstResponder()
        
        if selectedColor != nil && selectedSize != nil {
            priceButton.isEnabled = true
            priceButton.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.5058823529, blue: 0.537254902, alpha: 1)
        }
        
    }
}


extension ProductHeaderCell {
    

    @IBAction func addToCartAction(_ sender: Any) {
        self.delegate?.productHeader(self, didAddToCart: sender)
        
//        // the alert view
//        let alert = UIAlertController(title: "", message: "alert disappears after 5 seconds", preferredStyle: .alert)
//        self.present(alert, animated: true, completion: nil)
//        
//        // change to desired number of seconds (in this case 5 seconds)
//        let when = DispatchTime.now() + 5
//        DispatchQueue.main.asyncAfter(deadline: when){
//            // your code with delay
//            alert.dismiss(animated: true, completion: nil)
//        }
//        
        
        
    }
//    @IBAction func sizeButtonTapped(_ sender: Any) {
//        sizeTappedCompletion?()
//    }
}

//var currentSize = [Picker]
//var currentColor = [Picker]
//for variant in Product.variant {
//    if currentSize == variant.size {
//
//    }
//}




//
//  VariantPicker.swift
//  Dear Loa
//
//  Created by Rob Miguel on 8/23/18.
//  Copyright © 2018 robmgl. All rights reserved.
//

import UIKit

class VariantPicker: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // UIPickerView.
    private var myVariantPicker: UIPickerView!
    
    @IBOutlet weak var variantPicker: UIPickerView?
    
    //values of picker
    private let myValues: NSArray = ["one", "two", "three"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myVariantPicker = UIPickerView()
        
        let CGRectThing = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 280.0)
        
        // set size
        myVariantPicker.frame = CGRectThing
        
        myVariantPicker.delegate = self
        
        myVariantPicker.dataSource = self
        
        self.view.addSubview(myVariantPicker)
        
        
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myValues.count
    }
    
    // delegate method to return the value shown in the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myValues[row] as? String
    }
    
    // delegate method called when the row was selected.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row: \(row)")
        print("value: \(myValues[row])")
    }
    
    
}

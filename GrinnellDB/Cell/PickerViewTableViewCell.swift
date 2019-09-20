//
//  PickerViewTableViewCell.swift
//  GrinnellDB
//
//  Created by Zixuan on 9/10/19.
//  Copyright © 2019 Zixuan. All rights reserved.
//

import UIKit

class PickerViewTableViewCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    var options: [String] = [] {
        didSet {
            pickerView.reloadAllComponents()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
        pickerView.delegate = self
        textField.isUserInteractionEnabled = false
        pickerView.isHidden = true
        
        //self.textField.addDoneButtonOnKeyboard()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = options[row] == "None" ? nil : options[row]
    }
}

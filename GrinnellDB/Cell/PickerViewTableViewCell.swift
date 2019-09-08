//
//  PickerViewTableViewCell.swift
//  GrinnellDB
//
//  Created by Zixuan on 9/7/19.
//  Copyright © 2019 Zixuan. All rights reserved.
//

import UIKit

class PickerViewTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerCell: UIPickerView! {
        didSet {
            pickerCell.delegate = self
        }
    }
    
    var options: [String] = [] {
        didSet {
            pickerCell.reloadAllComponents()
            print(options)
        }
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

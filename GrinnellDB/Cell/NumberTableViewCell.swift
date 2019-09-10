//
//  NumberTableViewCell.swift
//  GrinnellDB
//
//  Created by Zixuan on 9/7/19.
//  Copyright © 2019 Zixuan. All rights reserved.
//

import UIKit

class NumberTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var numberField: UITextField! {
        didSet {
            numberField.delegate = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        numberField.keyboardType = UIKeyboardType.numberPad
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //numberField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

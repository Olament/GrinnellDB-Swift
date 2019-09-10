//
//  TextTableViewCell.swift
//  GrinnellDB
//
//  Created by Zixuan on 9/7/19.
//  Copyright © 2019 Zixuan. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell, UITextFieldDelegate {

    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

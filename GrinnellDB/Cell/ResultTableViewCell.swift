//
//  ResultTableViewCell.swift
//  GrinnellDB
//
//  Created by Zixuan on 9/14/19.
//  Copyright © 2019 Zixuan. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UITextView!
    @IBOutlet weak var detail: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        name.isUserInteractionEnabled = false
        detail.isUserInteractionEnabled = false
        
        detail.textContainer.lineBreakMode = .byWordWrapping
    }
}

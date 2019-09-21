//
//  AttributeTableViewCell.swift
//  GrinnellDB
//
//  Created by Zixuan on 9/20/19.
//  Copyright © 2019 Zixuan. All rights reserved.
//

import UIKit

class AttributeTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.subtitle.lineBreakMode = .byWordWrapping
        self.subtitle.numberOfLines = 0
    }
}

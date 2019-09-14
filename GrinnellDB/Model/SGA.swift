//
//  SGA.swift
//  GrinnellDB
//
//  Created by Zixuan on 9/14/19.
//  Copyright © 2019 Zixuan. All rights reserved.
//

import Foundation

class SGA: Person {
    let officePhone: String
    let officeEmail: String
    let officeAddress: String
    let officeBox: String
    let positionName: String
    let officeHours: [String]
    
    override init(dictionary dic: [String : Any]) {        
        officePhone = dic["officePhone"] as! String
        officeEmail = dic["officeEmail"] as! String
        officeAddress = dic["officeAddress"] as! String
        officeBox = dic["officeBox"] as! String
        positionName = dic["positionName"] as! String
        officeHours = dic["officeHours"] as! [String]
        
        super.init(dictionary: dic)
    }
}

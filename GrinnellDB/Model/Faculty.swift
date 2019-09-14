//
//  Faculty.swift
//  GrinnellDB
//
//  Created by Zixuan on 9/14/19.
//  Copyright © 2019 Zixuan. All rights reserved.
//

import Foundation

class Faculty: Person {
    let titles: [String]
    let departments: [String]
    let spouse: String
    
    override init(dictionary dic: [String: Any]) {        
        titles = dic["titles"] as! [String]
        departments = dic["departments"] as! [String]
        spouse = dic["spouse"] as! String
        
        super.init(dictionary: dic)
    }
}

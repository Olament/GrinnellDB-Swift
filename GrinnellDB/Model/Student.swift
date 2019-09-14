//
//  File.swift
//  GrinnellDB
//
//  Created by Zixuan on 9/13/19.
//  Copyright © 2019 Zixuan. All rights reserved.
//

import Foundation

class Student: Person {
    let nickName: String
    let classYear: String
    let major: String
    let minor: String
    
    override init(dictionary dic: [String : Any]) {
        nickName = dic["nickName"] as! String
        classYear = dic["classYear"] as! String
        major = dic["major"] as! String
        minor = dic["minor"] as! String
        
        super.init(dictionary: dic)
    }
}

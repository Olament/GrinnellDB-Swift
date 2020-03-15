//
//  File.swift
//  GrinnellDB
//
//  Created by Zixuan on 9/13/19.
//  Copyright © 2019 Zixuan. All rights reserved.
//

import Foundation

class Student: Person {
    
    var nickName: String?
    var classYear: String?
    var major: String?
    var minor: String?
    
    private enum CodingKeys: String, CodingKey {
        case nickName
        case classYear
        case major
        case minor
    }
        
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.nickName = try? container.decode(String.self, forKey: .nickName)
        self.classYear = try? container.decode(String.self, forKey: .classYear)
        self.major = try? container.decode(String.self, forKey: .major)
        self.minor = try? container.decode(String.self, forKey: .minor)

        try super.init(from: decoder)
    }
}

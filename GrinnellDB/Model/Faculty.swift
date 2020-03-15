//
//  Faculty.swift
//  GrinnellDB
//
//  Created by Zixuan on 9/14/19.
//  Copyright © 2019 Zixuan. All rights reserved.
//

import Foundation

class Faculty: Person {
    var title: String?
    var department: String?
    var spouse: String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case department
        case spouse
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try? container.decode(String.self, forKey: .title)
        self.department = try? container.decode(String.self, forKey: .department)
        self.spouse = try? container.decode(String.self, forKey: .spouse)
        
        try super.init(from: decoder)
    }
}

//
//  SGA.swift
//  GrinnellDB
//
//  Created by Zixuan on 9/14/19.
//  Copyright © 2019 Zixuan. All rights reserved.
//

import Foundation

class SGA: Person {
    var major: String?
    var classYear: String?
    var officePhone: String?
    var officeEmail: String?
    var officeAddress: String?
    var officeBox: String?
    var positionName: String?
    var officeHours: String?
    
    private enum CodingKeys: String, CodingKey {
        case major
        case classYear
        case SGAphone
        case SGAemail
        case SGAoffice
        case SGAbox
        case SGAtitle
        case SGAofficeHour
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.major = try? container.decode(String.self, forKey: .major)
        self.classYear = try? container.decode(String.self, forKey: .classYear)
        self.officePhone = try? container.decode(String.self, forKey: .SGAphone)
        self.officeEmail = try? container.decode(String.self, forKey: .SGAemail)
        self.officeAddress = try? container.decode(String.self, forKey: .SGAoffice)
        self.officeBox = try? container.decode(String.self, forKey: .SGAbox)
        self.positionName = try? container.decode(String.self, forKey: .SGAtitle)
        self.officeHours = try? container.decode(String.self, forKey: .SGAofficeHour)

        try super.init(from: decoder)
    }
}

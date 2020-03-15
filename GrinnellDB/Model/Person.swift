//
//  File.swift
//  GrinnellDB
//
//  Created by Zixuan on 9/13/19.
//  Copyright © 2019 Zixuan. All rights reserved.
//

import Foundation

class Person: Decodable {
    /* define type of Person */
    enum personType: String, Decodable {
        case faculty = "Faculty"
        case student = "Student"
        case SGA = "SGA"
    }

    var type: personType = personType.student
    let firstName: String?
    let lastName: String?
    let userName: String?
    let box: String?
    let email: String?
    let address: String?
    let phone: String?
    let imgPath: String?
    let homeAddress: String?
    
    private enum CodingKeys: String, CodingKey {
        case type
        case firstName
        case lastName
        case userName
        case box
        case email
        case address
        case phone
        case imgPath
        case homeAddress
    }
}

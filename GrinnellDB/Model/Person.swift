//
//  File.swift
//  GrinnellDB
//
//  Created by Zixuan on 9/13/19.
//  Copyright © 2019 Zixuan. All rights reserved.
//

import Foundation

class Person {
    /* define type of Person */
    enum personType: String {
        case faculty = "faculty"
        case student = "student"
        case SGA = "SGA"
    }
    
    let type: personType
    let firstName: String
    let lastName: String
    let userName: String
    let box: String
    let email: String
    let address: String
    let phone: String
    let imgPath: URL
    let homeAddress: String
    
    /* i know, ugly way to implement it here, will fix later */
    init(dictionary dic: [String: Any]) {
        type = personType(rawValue: dic["personType"] as! String)!
        firstName = dic["firstName"] as! String
        lastName = dic["lastName"] as! String
        userName = dic["userName"] as! String
        box = dic["box"] as! String
        email = dic["email"] as! String
        address = dic["address"] as! String
        phone = dic["phone"] as! String
        imgPath = URL(string: dic["imgPath"] as! String)!
        homeAddress = dic["homeAddress"] as! String
    }
}

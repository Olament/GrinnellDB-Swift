//
//  QueryResult.swift
//  GrinnellDB
//
//  Created by Zixuan on 3/14/20.
//  Copyright © 2020 Zixuan. All rights reserved.
//

import Foundation

struct QueryResult: Decodable {
    let errMessage: String
    let numberOfPeople: Int?
    let currentPage: Int?
    let maximumPage: Int?
    let status: Int
    let content: [Person]?
    
    enum QueryResultKey: CodingKey {
        case errMessage
        case numberOfPeople
        case currentPage
        case maximumPage
        case status
        case content
    }

    enum PersonTypeKey: CodingKey {
        case type
    }
    
    enum PersonTypes: String, Decodable {
        case student = "Student"
        case faculty = "Faculty"
        case sga = "SGA"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QueryResultKey.self)
        
        /* init other value */
        self.errMessage = try container.decode(String.self, forKey: QueryResultKey.errMessage)
        self.numberOfPeople = try? container.decode(Int.self, forKey: QueryResultKey.numberOfPeople)
        self.currentPage = try? container.decode(Int.self, forKey: QueryResultKey.currentPage)
        self.maximumPage = try? container.decode(Int.self, forKey: QueryResultKey.maximumPage)
        self.status = try container.decode(Int.self, forKey: QueryResultKey.status)
        
        /* init content */
        var arrayForType = try? container.nestedUnkeyedContainer(forKey: QueryResultKey.content)
        var people: [Person] = []
        
        if let personArrayForType = arrayForType {
            var personArrayForType = personArrayForType
            var personArray = personArrayForType
            while (!personArrayForType.isAtEnd) {
                let person = try personArrayForType.nestedContainer(keyedBy: PersonTypeKey.self)
                let type = try person.decode(PersonTypes.self, forKey: PersonTypeKey.type)
                
                switch type {
                case .faculty:
                    people.append(try personArray.decode(Faculty.self))
                case .student:
                    people.append(try personArray.decode(Student.self))
                case .sga:
                    people.append(try personArray.decode(SGA.self))
                }
            }
        }
        
        self.content = people
    }
}

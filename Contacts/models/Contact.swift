//
//  Contact.swift
//  Contacts
//
//  Created by 123 on 11.11.2019.
//

import Foundation

struct Contact: Codable, Equatable {
    let id: String
    let name: String
    let secondaryName: String
    let phone: String
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.name == rhs.name && lhs.secondaryName == rhs.secondaryName
    }
    
}

extension Contact {
    init(id: String, data: JSON) {
        self.id = id
        self.name  = data["name"] as? String ?? ""
        self.secondaryName   = data["secondaryName"] as? String ?? ""
        self.phone   = data["phone"] as? String ?? ""
    }
}
 

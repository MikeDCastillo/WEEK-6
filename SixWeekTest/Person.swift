//
//  Person.swift
//  SixWeekTest
//
//  Created by Michael Castillo on 3/17/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import Foundation

struct Person {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
}


//MARK: - Dictionary Representation / Failable Init grabbing from dictionary

extension Person {
    
    init?(dictionary: [String: String]) {
        guard let name = dictionary["name"] else { return nil }
        
        self.name = name
    }
    
    var dictionaryRepresentation: [String: String] {
        return ["name": name]
    }
    
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: dictionaryRepresentation, options: .prettyPrinted)
    }
    
    
}

//
//  Name.swift
//  
//
//  Created by Alex Nagy on 04.07.2022.
//

import SwiftUI
import FirebaseService
import BetterCodable
import Firebase
import FirebaseFirestoreSwift

struct Name: Codable {
    
    @DefaultEmptyString var first: String
    @DefaultEmptyString var last: String
    
    init(first: String? = nil,
         last: String? = nil) {
        self.first = first ?? ""
        self.last = last ?? ""
    }
    
}

struct DefaultNameStrategy: DefaultCodableStrategy {
    static var defaultValue: Name { return Name() }
}

typealias DefaultEmptyName = DefaultCodable<DefaultNameStrategy>



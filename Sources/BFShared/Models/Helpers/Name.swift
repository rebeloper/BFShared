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

public struct Name: Codable, Hashable {
    
    @DefaultEmptyString public var first: String
    @DefaultEmptyString public var last: String
    
    public init(first: String? = nil,
                last: String? = nil) {
        self.first = first ?? ""
        self.last = last ?? ""
    }
    
}

public struct DefaultNameStrategy: DefaultCodableStrategy {
    public static var defaultValue: Name { return Name() }
}

public typealias DefaultEmptyName = DefaultCodable<DefaultNameStrategy>



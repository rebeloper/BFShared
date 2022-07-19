//
//  Address.swift
//  
//
//  Created by Alex Nagy on 05.07.2022.
//

import SwiftUI
import FirebaseService
import BetterCodable
import Firebase
import FirebaseFirestoreSwift

public struct Address: Codable, Hashable {
    
    @DefaultEmptyString public var line1: String
    @DefaultEmptyString public var line2: String
    @DefaultEmptyString public var city: String
    @DefaultEmptyString public var state: String
    @DefaultEmptyString public var country: String
    
    public init(line1: String? = nil,
         line2: String? = nil,
         city: String? = nil,
         state: String? = nil,
         country: String? = nil) {
        self.line1 = line1 ?? ""
        self.line2 = line2 ?? ""
        self.city = city ?? ""
        self.state = state ?? ""
        self.country = country ?? ""
    }
    
}

public struct DefaultAddressStrategy: DefaultCodableStrategy {
    public static var defaultValue: Address { return Address() }
}

public typealias DefaultEmptyAddress = DefaultCodable<DefaultAddressStrategy>



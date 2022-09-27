//
//  Customer.swift
//  
//
//  Created by Alex Nagy on 11.07.2022.
//

import SwiftUI
import FirebaseService
import BetterCodable
import Firebase
import FirebaseFirestoreSwift

public struct Customer: Codable, Identifiable, Firestorable, Hashable {
    
    @DocumentID public var id: String?
    @DefaultEmptyString public var uid: String
    @DefaultTimestamp public var createdAt: Timestamp
    @DefaultEmptyName public var name: Name
    @DefaultZeroInt public var role: Int
    @DefaultEmptyString public var phone: String
    @DefaultEmptyString public var fcmToken: String
    @DefaultEmptyString public var profileImageUrl: String
    @DefaultEmptyArray public var favoriteMerchants: [String]
    @DefaultZeroDouble public var latitude: Double
    @DefaultZeroDouble public var longitude: Double
    @DefaultEmptyString public var geoHash: String
    
    public init(uid: String? = nil,
                createdAt: Timestamp? = nil,
                name: Name? = nil,
                role: Int? = nil,
                phone: String? = nil,
                fcmToken: String? = nil,
                profileImageUrl: String? = nil,
                favoriteMerchants: [String]? = nil,
                latitude: Double? = nil,
                longitude: Double? = nil,
                geoHash: String? = nil) {
        self.uid = uid ?? ""
        self.createdAt = createdAt ?? Timestamp()
        self.name = name ?? Name()
        self.role = role ?? 0
        self.phone = phone ?? ""
        self.fcmToken = fcmToken ?? ""
        self.profileImageUrl = profileImageUrl ?? ""
        self.favoriteMerchants = favoriteMerchants ?? []
        self.latitude = latitude ?? 0
        self.longitude = longitude ?? 0
        self.geoHash = geoHash ?? ""
    }
    
}

public struct DefaultCustomerStrategy: DefaultCodableStrategy {
    public static var defaultValue: Customer { return Customer() }
}

public typealias DefaultEmptyCustomer = DefaultCodable<DefaultCustomerStrategy>




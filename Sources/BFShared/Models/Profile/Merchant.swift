//
//  Merchant.swift
//  
//
//  Created by Alex Nagy on 05.07.2022.
//

import SwiftUI
import FirebaseService
import BetterCodable
import Firebase
import FirebaseFirestoreSwift

public struct Merchant: Codable, Identifiable, Firestorable, Hashable {
    
    @DocumentID public var id: String?
    @DefaultEmptyString public var uid: String
    @DefaultTimestamp public var createdAt: Timestamp
    @DefaultEmptyName public var name: Name
    @DefaultZeroDouble public var latitude: Double
    @DefaultZeroDouble public var longitude: Double
    @DefaultEmptyString public var geoHash: String
    @DefaultEmptyBrainFreezeMerchantStripeAccount public var stripeAccount: MerchantStripeAccount
    @DefaultEmptyString public var companyName: String
    @DefaultEmptyString public var phone: String
    @DefaultEmptyString public var description: String
    @DefaultEmptyString public var fcmToken: String
    @DefaultEmptyString public var profileImageUrl: String
    @DefaultEmptyString public var tags: String
    
    public init(uid: String? = nil,
                createdAt: Timestamp? = nil,
                name: Name? = nil,
                latitude: Double? = nil,
                longitude: Double? = nil,
                geoHash: String? = nil,
                stripeAccount: MerchantStripeAccount? = nil,
                companyName: String? = nil,
                phone: String? = nil,
                description: String? = nil,
                fcmToken: String? = nil,
                profileImageUrl: String? = nil,
                tags: String? = nil) {
        self.uid = uid ?? ""
        self.createdAt = createdAt ?? Timestamp()
        self.name = name ?? Name()
        self.latitude = latitude ?? 0
        self.longitude = longitude ?? 0
        self.geoHash = geoHash ?? ""
        self.stripeAccount = stripeAccount ?? MerchantStripeAccount()
        self.companyName = companyName ?? ""
        self.phone = phone ?? ""
        self.description = description ?? ""
        self.fcmToken = fcmToken ?? ""
        self.profileImageUrl = profileImageUrl ?? ""
        self.tags = tags ?? ""
    }
    
}

public struct DefaultMerchantStrategy: DefaultCodableStrategy {
    public static var defaultValue: Merchant { return Merchant() }
}

public typealias DefaultEmptyMerchant = DefaultCodable<DefaultMerchantStrategy>


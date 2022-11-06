//
//  Coupon.swift
//  
//
//  Created by Alex Nagy on 17.08.2022.
//

import SwiftUI
import FirebaseService
import BetterCodable
import Firebase
import FirebaseFirestoreSwift

public struct Coupon: Codable, Identifiable, Firestorable, Hashable {
    
    @DocumentID public var id: String?
    @DefaultEmptyString public var uid: String
    @DefaultTimestamp public var createdAt: Timestamp
    @DefaultTimestamp public var startsAt: Timestamp
    @DefaultTimestamp public var expiresAt: Timestamp
    @DefaultEmptyString public var name: String
    @DefaultZeroInt public var discount: Int
    @DefaultEmptyString public var merchantUid: String
    @DefaultZeroInt public var discountType: Int
    @DefaultEmptyArray public var productUids: [String]
    @DefaultZeroInt public var count: Int
    @DefaultZeroInt public var limit: Int
    @DefaultFalse public var isAvailable: Bool
    
    public init(uid: String? = nil,
                createdAt: Timestamp? = nil,
                startsAt: Timestamp? = nil,
                expiresAt: Timestamp? = nil,
                name: String? = nil,
                discount: Int? = nil,
                discountType: Int? = nil,
                merchantUid: String? = nil,
                productUids: [String]? = nil,
                count: Int? = nil,
                limit: Int? = nil,
                isAvailable: Bool? = nil) {
        self.uid = uid ?? ""
        self.createdAt = createdAt ?? Timestamp()
        self.startsAt = startsAt ?? Timestamp()
        self.expiresAt = expiresAt ?? Timestamp()
        self.name = name ?? ""
        self.discount = discount ?? 0
        self.discountType = discountType ?? 0
        self.merchantUid = merchantUid ?? ""
        self.productUids = productUids ?? []
        self.count = count ?? 0
        self.limit = limit ?? 0
        self.isAvailable = isAvailable ?? false
    }
    
}

public struct DefaultCouponStrategy: DefaultCodableStrategy {
    public static var defaultValue: Coupon { return Coupon() }
}

public typealias DefaultEmptyCoupon = DefaultCodable<DefaultCouponStrategy>


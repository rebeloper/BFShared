//
//  Order.swift
//  
//
//  Created by Alex Nagy on 17.08.2022.
//

import SwiftUI
import FirebaseService
import BetterCodable
import Firebase
import FirebaseFirestoreSwift

public struct Order: Codable, Identifiable, Firestorable, Hashable {
    
    @DocumentID public var id: String?
    @DefaultEmptyString public var uid: String
    @DefaultTimestamp public var createdAt: Timestamp
    @DefaultEmptyString public var customerUid: String
    @DefaultEmptyString public var merchantUid: String
    @DefaultEmptyName public var customerName: Name
    @DefaultEmptyString public var customerPhone: String
    @DefaultEmptyString public var merchantCompanyName: String
    @DefaultEmptyString public var merchantAddress: String
    @DefaultEmptyString public var merchantPhone: String
    @DefaultEmptyArray public var products: [Product]
    @DefaultEmptyCoupon public var coupon: Coupon
    @DefaultZeroInt public var tip: Int
    @DefaultEmptyString public var instructions: String
    @DefaultZeroInt public var status: Int
    
    public init(uid: String? = nil,
                createdAt: Timestamp? = nil,
                customerUid: String? = nil,
                merchantUid: String? = nil,
                customerName: Name? = nil,
                customerPhone: String? = nil,
                merchantCompanyName: String? = nil,
                merchantAddress: String? = nil,
                merchantPhone: String? = nil,
                products: [Product]? = nil,
                coupon: Coupon? = nil,
                tip: Int? = nil,
                instructions: String? = nil,
                status: Int? = nil) {
        self.uid = uid ?? ""
        self.createdAt = createdAt ?? Timestamp()
        self.customerUid = customerUid ?? ""
        self.merchantUid = merchantUid ?? ""
        self.customerName = customerName ?? Name()
        self.customerPhone = customerPhone ?? ""
        self.merchantCompanyName = merchantCompanyName ?? ""
        self.merchantAddress = merchantAddress ?? ""
        self.merchantPhone = merchantPhone ?? ""
        self.products = products ?? []
        self.coupon = coupon ?? Coupon()
        self.tip = tip ?? 0
        self.instructions = instructions ?? ""
        self.status = status ?? 0
    }
    
}

public struct DefaultOrderStrategy: DefaultCodableStrategy {
    public static var defaultValue: Order { return Order() }
}

public typealias DefaultEmptyOrder = DefaultCodable<DefaultOrderStrategy>



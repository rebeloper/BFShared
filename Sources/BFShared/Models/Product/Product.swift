//
//  Product.swift
//  
//
//  Created by Alex Nagy on 09.08.2022.
//

import SwiftUI
import FirebaseService
import BetterCodable
import Firebase
import FirebaseFirestoreSwift

public struct Product: Codable, Identifiable, Firestorable, Hashable {
    
    @DocumentID public var id: String?
    @DefaultEmptyString public var uid: String
    @DefaultTimestamp public var createdAt: Timestamp
    @DefaultEmptyString public var name: String
    @DefaultEmptyString public var description: String
    @DefaultEmptyString public var merchantUid: String
    @DefaultEmptyString public var productImageUrl: String
    @DefaultFalse public var isAvailable: Bool
    @DefaultZeroInt public var price: Int
    @DefaultZeroInt public var maxFlavorsCount: Int
    @DefaultEmptyArray public var options: [ProductOption]
    @DefaultZeroInt public var quantity: Int
    
    public init(uid: String? = nil,
                createdAt: Timestamp? = nil,
                name: String? = nil,
                description: String? = nil,
                merchantUid: String? = nil,
                productImageUrl: String? = nil,
                isAvailable: Bool? = nil,
                price: Int? = nil,
                maxFlavorsCount: Int? = nil,
                options: [ProductOption]? = nil,
                quantity: Int? = nil) {
        self.uid = uid ?? ""
        self.createdAt = createdAt ?? Timestamp()
        self.name = name ?? ""
        self.description = description ?? ""
        self.merchantUid = merchantUid ?? ""
        self.productImageUrl = productImageUrl ?? ""
        self.isAvailable = isAvailable ?? false
        self.price = price ?? 0
        self.maxFlavorsCount = maxFlavorsCount ?? 0
        self.options = options ?? []
        self.quantity = quantity ?? 0
    }
    
}

public struct DefaultProductStrategy: DefaultCodableStrategy {
    public static var defaultValue: Product { return Product() }
}

public typealias DefaultEmptyProduct = DefaultCodable<DefaultProductStrategy>



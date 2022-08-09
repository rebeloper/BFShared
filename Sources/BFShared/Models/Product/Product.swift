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

// a product that is created by the Admin for a particular merchant
public struct Product: Codable, Identifiable, Firestorable, Hashable {
    
    @DocumentID public var id: String?
    @DefaultEmptyString public var uid: String
    @DefaultTimestamp public var createdAt: Timestamp
    @DefaultEmptyString public var name: String
    @DefaultEmptyString public var description: String
    @DefaultEmptyString public var merchantUid: String
    @DefaultEmptyString public var productImageUrl: String
    @DefaultEmptyString public var instructions: String
    @DefaultFalse public var isAvailable: Bool
    @DefaultZeroInt public var price: Int
    @DefaultZeroInt public var maxFlavorsCount: Int
    
    public init(uid: String? = nil,
         createdAt: Timestamp? = nil,
         name: String? = nil,
         description: String? = nil,
         merchantUid: String? = nil,
         productImageUrl: String? = nil,
         instructions: String? = nil,
         isAvailable: Bool? = nil,
         price: Int? = nil,
         maxFlavorsCount: Int? = nil) {
        self.uid = uid ?? ""
        self.createdAt = createdAt ?? Timestamp()
        self.name = name ?? ""
        self.description = description ?? ""
        self.merchantUid = merchantUid ?? ""
        self.productImageUrl = productImageUrl ?? ""
        self.instructions = instructions ?? ""
        self.isAvailable = isAvailable ?? false
        self.price = price ?? 0
        self.maxFlavorsCount = maxFlavorsCount ?? 0
    }
    
}

public struct DefaultProductStrategy: DefaultCodableStrategy {
    public static var defaultValue: Product { return Product() }
}

public typealias DefaultEmptyProduct = DefaultCodable<DefaultProductStrategy>



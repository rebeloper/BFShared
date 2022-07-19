//
//  TemplateProductOption.swift
//  
//
//  Created by Alex Nagy on 12.07.2022.
//

import SwiftUI
import FirebaseService
import BetterCodable
import Firebase
import FirebaseFirestoreSwift

// a template for product size that can be used when creating a product
public struct TemplateProductOption: Codable, Identifiable, Firestorable, Hashable {
    
    @DocumentID public var id: String?
    @DefaultEmptyString public var uid: String
    @DefaultTimestamp public var createdAt: Timestamp
    @DefaultZeroInt public var type: Int
    @DefaultEmptyString public var name: String
    @DefaultZeroInt public var price: Int
    
    public init(uid: String? = nil,
                createdAt: Timestamp? = nil,
                type: Int? = nil,
                name: String? = nil,
                price: Int? = nil) {
        self.uid = uid ?? ""
        self.createdAt = createdAt ?? Timestamp()
        self.type = type ?? 0
        self.name = name ?? ""
        self.price = price ?? 0
    }
    
}

public struct DefaultTemplateProductSizeStrategy: DefaultCodableStrategy {
    public static var defaultValue: TemplateProductOption { return TemplateProductOption() }
}

public typealias DefaultEmptyTemplateProductSize = DefaultCodable<DefaultTemplateProductSizeStrategy>


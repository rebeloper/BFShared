//
//  TemplateProductSize.swift
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
public struct TemplateProductSize: Codable, Identifiable, Firestorable {
    
    @DocumentID public var id: String?
    @DefaultEmptyString public var uid: String
    @DefaultTimestamp public var createdAt: Timestamp
    @DefaultEmptyString public var name: String
    @DefaultZeroInt public var price: Int
    @DefaultFalse public var isAvailable: Bool
    @DefaultFalse public var isChecked: Bool
    
    public init(uid: String? = nil,
         createdAt: Timestamp? = nil,
         name: String? = nil,
         price: Int? = nil,
         isAvailable: Bool? = nil,
         isChecked: Bool? = nil) {
        self.uid = uid ?? ""
        self.createdAt = createdAt ?? Timestamp()
        self.name = name ?? ""
        self.price = price ?? 0
        self.isAvailable = isAvailable ?? false
        self.isChecked = isChecked ?? false
    }
    
}

public struct DefaultTemplateProductSizeStrategy: DefaultCodableStrategy {
    public static var defaultValue: TemplateProductSize { return TemplateProductSize() }
}

public typealias DefaultEmptyTemplateProductSize = DefaultCodable<DefaultTemplateProductSizeStrategy>


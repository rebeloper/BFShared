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
struct TemplateProductSize: Codable, Identifiable, Firestorable {
    
    @DocumentID var id: String?
    @DefaultEmptyString var uid: String
    @DefaultTimestamp var createdAt: Timestamp
    @DefaultEmptyString var name: String
    @DefaultZeroInt var price: Int
    @DefaultFalse var isAvailable: Bool
    @DefaultFalse var isChecked: Bool
    
    init(uid: String? = nil,
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

struct DefaultTemplateProductSizeStrategy: DefaultCodableStrategy {
    static var defaultValue: TemplateProductSize { return TemplateProductSize() }
}

typealias DefaultEmptyTemplateProductSize = DefaultCodable<DefaultTemplateProductSizeStrategy>





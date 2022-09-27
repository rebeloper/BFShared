//
//  ProductSize.swift
//  
//
//  Created by Alex Nagy on 27.09.2022.
//

import SwiftUI
import FirebaseService
import BetterCodable
import Firebase
import FirebaseFirestoreSwift

public struct ProductSize: Codable, Identifiable, Hashable {
    
    @DocumentID public var id: String?
    @DefaultEmptyString public var name: String
    @DefaultZeroInt public var price: Int
    
    public init(name: String? = nil,
                price: Int? = nil) {
        self.name = name ?? ""
        self.price = price ?? 0
    }
    
}

public struct DefaultProductSizeStrategy: DefaultCodableStrategy {
    public static var defaultValue: ProductSize { return ProductSize() }
}

public typealias DefaultEmptyProductSize = DefaultCodable<DefaultProductSizeStrategy>




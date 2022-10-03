//
//  ProductOption.swift
//  
//
//  Created by Alex Nagy on 27.09.2022.
//

import SwiftUI
import FirebaseService
import BetterCodable
import Firebase
import FirebaseFirestoreSwift

public struct ProductOption: Codable, Identifiable, Hashable {
    
    @DocumentID public var id: String?
    @DefaultZeroInt public var type: Int
    @DefaultEmptyString public var name: String
    @DefaultZeroInt public var price: Int
    
    public init(type: Int? = nil,
                name: String? = nil,
                price: Int? = nil) {
        self.type = type ?? 0
        self.name = name ?? ""
        self.price = price ?? 0
    }
    
}

public struct DefaultProductOptionStrategy: DefaultCodableStrategy {
    public static var defaultValue: ProductOption { return ProductOption() }
}

public typealias DefaultEmptyProductOption = DefaultCodable<DefaultProductOptionStrategy>




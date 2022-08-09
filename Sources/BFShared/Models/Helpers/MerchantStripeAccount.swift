//
//  MerchantStripeAccount.swift
//  
//
//  Created by Alex Nagy on 05.07.2022.
//

import SwiftUI
import FirebaseService
import BetterCodable
import Firebase
import FirebaseFirestoreSwift

public struct MerchantStripeAccount: Codable, Hashable {
    
    @DefaultEmptyString public var merchantId: String
    @DefaultZeroInt public var serviceFeePercentage: Int
    
    public init(merchantId: String? = nil,
                serviceFeePercentage: Int? = nil) {
        self.merchantId = merchantId ?? ""
        self.serviceFeePercentage = serviceFeePercentage ?? 0
    }
    
}

public struct DefaultBrainFreezeMerchantStripeAccountStrategy: DefaultCodableStrategy {
    public static var defaultValue: MerchantStripeAccount { return MerchantStripeAccount() }
}

public typealias DefaultEmptyBrainFreezeMerchantStripeAccount = DefaultCodable<DefaultBrainFreezeMerchantStripeAccountStrategy>




//
//  StripeConnectAccount.swift
//  
//
//  Created by Alex Nagy on 29.08.2022.
//

import SwiftUI
import FirebaseService
import BetterCodable
import Firebase
import FirebaseFirestoreSwift

public struct StripeConnectAccount: Codable, Identifiable, Firestorable, Hashable {
    
    @DocumentID public var id: String?
    @DefaultEmptyString public var uid: String
    @DefaultEmptyString public var accountId: String
    
    public init(accountId: String? = nil,
                uid: String? = nil) {
        self.accountId = accountId ?? ""
        self.uid = uid ?? ""
    }
    
}

public struct DefaultStripeConnectAccountStrategy: DefaultCodableStrategy {
    public static var defaultValue: StripeConnectAccount { return StripeConnectAccount() }
}

public typealias DefaultEmptyStripeConnectAccount = DefaultCodable<DefaultStripeConnectAccountStrategy>


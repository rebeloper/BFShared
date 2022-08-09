//
//  Admin.swift
//  
//
//  Created by Alex Nagy on 04.07.2022.
//

import SwiftUI
import FirebaseService
import BetterCodable
import Firebase
import FirebaseFirestoreSwift

public struct Admin: Codable, Identifiable, Firestorable, Hashable {
    
    @DocumentID public var id: String?
    @DefaultEmptyString public var uid: String
    @DefaultTimestamp public var createdAt: Timestamp
    @DefaultEmptyName public var name: Name
    @DefaultZeroInt public var role: Int
    @DefaultEmptyString public var phone: String
    @DefaultEmptyString public var fcmToken: String
    @DefaultEmptyString public var profileImageUrl: String
    
    public init(uid: String? = nil,
                createdAt: Timestamp? = nil,
                name: Name? = nil,
                role: Int? = nil,
                phone: String? = nil,
                fcmToken: String? = nil,
                profileImageUrl: String? = nil) {
        self.uid = uid ?? ""
        self.createdAt = createdAt ?? Timestamp()
        self.name = name ?? Name()
        self.role = role ?? 0
        self.phone = phone ?? ""
        self.fcmToken = fcmToken ?? ""
        self.profileImageUrl = profileImageUrl ?? ""
    }
    
}

public struct DefaultAdminStrategy: DefaultCodableStrategy {
    public static var defaultValue: Admin { return Admin() }
}

public typealias DefaultEmptyAdmin = DefaultCodable<DefaultAdminStrategy>



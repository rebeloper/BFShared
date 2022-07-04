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

struct Admin: Codable, Identifiable, Firestorable {
    
    @DocumentID var id: String?
    @DefaultEmptyString var uid: String
    @DefaultTimestamp var createdAt: Timestamp
    @DefaultEmptyName var name: Name
    @DefaultZeroInt var role: Int
    @DefaultEmptyString var phone: String
    @DefaultEmptyString var fcmToken: String
    @DefaultEmptyString var profileImageUrl: String
    
    init(uid: String? = nil,
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

struct DefaultAdminStrategy: DefaultCodableStrategy {
    static var defaultValue: Admin { return Admin() }
}

typealias DefaultEmptyAdmin = DefaultCodable<DefaultAdminStrategy>



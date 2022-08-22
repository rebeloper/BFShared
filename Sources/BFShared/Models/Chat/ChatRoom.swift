//
//  ChatRoom.swift
//  
//
//  Created by Alex Nagy on 22.08.2022.
//

import SwiftUI
import FirebaseService
import BetterCodable
import Firebase
import FirebaseFirestoreSwift

public struct ChatRoom: Codable, Identifiable, Firestorable, Hashable {
    
    @DocumentID public var id: String?
    @DefaultEmptyString public var uid: String
    @DefaultTimestamp public var createdAt: Timestamp
    @DefaultTimestamp public var updatedAt: Timestamp
    @DefaultEmptyString public var lastMessage: String
    @DefaultEmptyName public var adminName: Name
    @DefaultEmptyName public var merchantName: Name
    @DefaultEmptyString public var merchantCompanyName: String
    @DefaultEmptyString public var adminUid: String
    @DefaultEmptyString public var merchantUid: String
    
    public init(uid: String? = nil,
                createdAt: Timestamp? = nil,
                updatedAt: Timestamp? = nil,
                lastMessage: String? = nil,
                adminName: Name? = nil,
                merchantName: Name? = nil,
                merchantCompanyName: String? = nil,
                adminUid: String? = nil,
                merchantUid: String? = nil) {
        self.uid = uid ?? ""
        self.createdAt = createdAt ?? Timestamp()
        self.updatedAt = updatedAt ?? Timestamp()
        self.lastMessage = lastMessage ?? ""
        self.adminName = adminName ?? Name()
        self.merchantName = merchantName ?? Name()
        self.merchantCompanyName = merchantCompanyName ?? ""
        self.adminUid = adminUid ?? ""
        self.merchantUid = merchantUid ?? ""
    }
    
}

public struct DefaultChatRoomStrategy: DefaultCodableStrategy {
    public static var defaultValue: ChatRoom { return ChatRoom() }
}

public typealias DefaultEmptyChatRoom = DefaultCodable<DefaultChatRoomStrategy>


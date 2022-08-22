//
//  ChatMessage.swift
//  
//
//  Created by Alex Nagy on 22.08.2022.
//

import SwiftUI
import FirebaseService
import BetterCodable
import Firebase
import FirebaseFirestoreSwift

public struct ChatMessage: Codable, Identifiable, Firestorable, Hashable {
    
    @DocumentID public var id: String?
    @DefaultEmptyString public var uid: String
    @DefaultTimestamp public var createdAt: Timestamp
    @DefaultEmptyString public var text: String
    @DefaultEmptyString public var adminUid: String
    @DefaultEmptyString public var merchantUid: String
    @DefaultEmptyString public var senderUid: String
    
    public init(uid: String? = nil,
         createdAt: Timestamp? = nil,
         text: String? = nil,
         adminUid: String? = nil,
         merchantUid: String? = nil,
         senderUid: String? = nil) {
        self.uid = uid ?? ""
        self.createdAt = createdAt ?? Timestamp()
        self.text = text ?? ""
        self.adminUid = adminUid ?? ""
        self.merchantUid = merchantUid ?? ""
        self.senderUid = senderUid ?? ""
    }
    
}

public struct DefaultChatMessageStrategy: DefaultCodableStrategy {
    public static var defaultValue: ChatMessage { return ChatMessage() }
}

public typealias DefaultEmptyChatMessage = DefaultCodable<DefaultChatMessageStrategy>

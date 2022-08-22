//
//  ProfileService.swift
//  
//
//  Created by Alex Nagy on 05.07.2022.
//

import SwiftUI
import FirebaseService
import FirebaseAuth
import FirebaseFirestore
import Combine

public class ProfileService: ObservableObject {
    
    public init() {}
    
    @Published public var admin = Admin()
    @Published public var customer = Customer()
    @Published public var merchant = Merchant()
    
    public var cancellables: Set<AnyCancellable> = []
    
    public func signIn(withEmail email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    public func signUp(withEmail email: String, password: String) async throws -> String {
        try await Auth.auth().createUser(withEmail: email, password: password).user.uid
    }
    
    public func logout() throws {
        try Auth.auth().signOut()
    }
    
    @MainActor
    public func createAdminIfNonExistent() async throws {
        admin = try await FirestoreManager.createIfNonExistent(admin, withUid: admin.uid, atPath: Path.Firestore.admins)
    }
    
    @MainActor
    public func createCustomerIfNonExistent() async throws {
        customer = try await FirestoreManager.createIfNonExistent(customer, withUid: customer.uid, atPath: Path.Firestore.customers)
    }
    
    @MainActor
    public func createMerchantIfNonExistent() async throws {
        merchant = try await FirestoreManager.createIfNonExistent(merchant, withUid: merchant.uid, atPath: Path.Firestore.merchants)
    }
    
    @MainActor
    public func fetchAdmin(uid: String) async throws {
        admin = try await FirestoreManager.read(atPath: Path.Firestore.admins, uid: uid)
    }
    
    @MainActor
    public func fetchAdmins() async throws -> [Admin] {
        return try await FirestoreManager.query(path: Path.Firestore.admins)
    }
    
    @MainActor
    public func fetchCustomer(uid: String) async throws {
        customer = try await FirestoreManager.read(atPath: Path.Firestore.customers, uid: uid)
    }
    
    @MainActor
    public func fetchMerchant(uid: String) async throws {
        merchant = try await FirestoreManager.read(atPath: Path.Firestore.merchants, uid: uid)
    }
    
    @MainActor
    public func fetchMerchants() async throws -> [Merchant] {
        return try await FirestoreManager.query(path: Path.Firestore.merchants)
    }
    
    @MainActor
    public func fetchMerchants(geoHash: String) async throws -> [Merchant] {
        let queryItem = QueryItem("geoHash", .isEqualTo, geoHash)
        return try await FirestoreManager.query(path: Path.Firestore.merchants, queryItems: [queryItem])
    }
    
    @MainActor
    public func update(merchant: Merchant) async throws {
        self.merchant = try await FirestoreManager.update(merchant, atPath: Path.Firestore.merchants)
    }
    
    @MainActor
    public func update(admin: Admin) async throws {
        self.admin = try await FirestoreManager.update(admin, atPath: Path.Firestore.admins)
    }
    
    @MainActor
    public func update(customer: Customer) async throws {
        self.customer = try await FirestoreManager.update(customer, atPath: Path.Firestore.customers)
    }
    
    @MainActor
    public func fetchProducts(for merchant: Merchant) async throws -> [Product] {
        let queryItems = [
            QueryItem("merchantUid", .isEqualTo, merchant.uid)
        ]
        return try await FirestoreManager.query(path: Path.Firestore.products, queryItems: queryItems)
    }
    
    @MainActor
    public func fetchAvailableProducts(for merchant: Merchant) async throws -> [Product] {
        let queryItems = [
            QueryItem("isAvailable", .isEqualTo, true),
            QueryItem("merchantUid", .isEqualTo, merchant.uid)
        ]
        return try await FirestoreManager.query(path: Path.Firestore.products, queryItems: queryItems)
    }
    
    @MainActor
    public func delete(product: Product) async throws {
        let _ = try await FirestoreManager.delete(product, atPath: Path.Firestore.products)
    }
    
    @MainActor
    public func create(product: Product) async throws {
        let _ = try await FirestoreManager.create(product, atPath: Path.Firestore.products)
    }
    
    @MainActor
    public func update(product: Product) async throws {
        let _ = try await FirestoreManager.update(product, atPath: Path.Firestore.products)
    }
    
    @MainActor
    public func saveMerchantProfile(image: UIImage, oldImageUrl: String) async throws -> URL {
        try await StorageService.handleImageChange(newImage: image, folderPath: Path.Storage.merchantProfileImages, compressionQuality: 0.5, oldImageUrl: oldImageUrl)
    }
    
    @MainActor
    public func create(order: Order) async throws {
        let _ = try await FirestoreManager.create(order, atPath: Path.Firestore.orders)
    }
    
    @MainActor
    public func fetchOrders(for merchant: Merchant, status: OrderStatus) async throws -> [Order] {
        let queryItems = [
            QueryItem("status", .isEqualTo, status.rawValue),
            QueryItem("merchantUid", .isEqualTo, merchant.uid)
        ]
        return try await FirestoreManager.query(path: Path.Firestore.orders, queryItems: queryItems)
    }
    
    @MainActor
    public func update(order: Order) async throws {
        let _ = try await FirestoreManager.update(order, atPath: Path.Firestore.orders)
    }
    
    @MainActor
    public func create(chatRoom: ChatRoom) async throws {
        let _ = try await FirestoreManager.create(chatRoom, atPath: Path.Firestore.chatRooms)
    }
    
    @MainActor
    public func fetchChatRoomsForAdmin(_ admin: Admin) async throws -> [ChatRoom] {
        let queryItems = [
            QueryItem("adminUid", .isEqualTo, admin.uid)
        ]
        return try await FirestoreManager.query(path: Path.Firestore.chatRooms, queryItems: queryItems)
    }
    
    @MainActor
    public func fetchChatRoomsForMerchant(_ merchant: Merchant) async throws -> [ChatRoom] {
        let queryItems = [
            QueryItem("merchantUid", .isEqualTo, merchant.uid)
        ]
        return try await FirestoreManager.query(path: Path.Firestore.chatRooms, queryItems: queryItems)
    }
    
    @MainActor
    public func update(chatRoom: ChatRoom) async throws {
        let _ = try await FirestoreManager.update(chatRoom, atPath: Path.Firestore.chatRooms)
    }
    
    @MainActor
    public func create(chatMessage: ChatMessage, chatRoom: ChatRoom) async throws {
        let _ = try await FirestoreManager.create(chatMessage, atPath: Path.Firestore.chatMessages)
        var chatRoom = chatRoom
        chatRoom.updatedAt = Timestamp()
        chatRoom.lastMessage = chatMessage.text
        try await update(chatRoom: chatRoom)
    }
    
    @MainActor
    public func listenToChatMessages(for chatRoom: ChatRoom) async throws -> [ChatMessage] {
        let queryItems = [
            QueryItem("adminUid", .isEqualTo, chatRoom.adminUid),
            QueryItem("merchantUid", .isEqualTo, chatRoom.merchantUid)
        ]
        return try await withCheckedThrowingContinuation({ continuation in
            FirestoreManager<ChatMessage>.listenTo(Path.Firestore.chatMessages, queryItems: queryItems).sink { result in
                switch result {
                case .finished:
                    break
                case .failure(let err):
                    continuation.resume(throwing: err)
                }
            } receiveValue: { chatMessages in
                continuation.resume(returning: chatMessages)
            }.store(in: &cancellables)
        })
    }
}


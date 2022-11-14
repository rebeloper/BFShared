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
    public func fetchCustomers(geoHash: String) async throws -> [Customer] {
        let queryItem = QueryItem("geoHash", .isEqualTo, geoHash)
        return try await FirestoreManager.query(path: Path.Firestore.customers, queryItems: [queryItem])
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
    public func fetchProduct(uid: String) async throws -> Product {
        try await FirestoreManager.read(atPath: Path.Firestore.products, uid: uid)
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
    public func saveCustomerProfile(image: UIImage, oldImageUrl: String) async throws -> URL {
        try await StorageService.handleImageChange(newImage: image, folderPath: Path.Storage.customerProfileImages, compressionQuality: 0.5, oldImageUrl: oldImageUrl.removingPercentEncoding!)
        // TODO: - Remove removingPercentEncoding once it's fixed in the Firebase SDK
    }
    
    @MainActor
    public func saveMerchantProfile(image: UIImage, oldImageUrl: String) async throws -> URL {
        try await StorageService.handleImageChange(newImage: image, folderPath: Path.Storage.merchantProfileImages, compressionQuality: 0.5, oldImageUrl: oldImageUrl.removingPercentEncoding!)
    }
    
    @MainActor
    public func saveProduct(image: UIImage, oldImageUrl: String) async throws -> URL {
        try await StorageService.handleImageChange(newImage: image, folderPath: Path.Storage.productImages, compressionQuality: 0.5, oldImageUrl: oldImageUrl.removingPercentEncoding!)
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
    public func fetchOrders(for customer: Customer) async throws -> [Order] {
        let queryItems = [
            QueryItem("customerUid", .isEqualTo, customer.uid)
        ]
        let orders: [Order] = try await FirestoreManager.query(path: Path.Firestore.orders, queryItems: queryItems)
        let sortedOrders = orders.sorted { o0, o1 in
            o0.createdAt.dateValue() > o1.createdAt.dateValue()
        }
        return sortedOrders
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
    public func listenToChatMessages(for chatRoom: ChatRoom, completion: @escaping (Result<[ChatMessage], Error>) -> ()) {
        let queryItems = [
            QueryItem("adminUid", .isEqualTo, chatRoom.adminUid),
            QueryItem("merchantUid", .isEqualTo, chatRoom.merchantUid)
        ]
        let promise = FirestoreManager<ChatMessage>.listenTo(Path.Firestore.chatMessages, queryItems: queryItems)
        PassthroughPromise.fulfill(promise, storedIn: &cancellables) { result in
            switch result {
            case .success(let chatMessages):
                let orderedChatMessages = chatMessages.sorted { cm0, cm1 in
                    cm0.createdAt.dateValue() < cm1.createdAt.dateValue()
                }
                completion(.success(orderedChatMessages))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    @MainActor
    public func create(coupon: Coupon) async throws {
        let _ = try await FirestoreManager.create(coupon, atPath: Path.Firestore.coupons)
    }
    
    @MainActor
    public func fetchCoupons() async throws -> [Coupon] {
        try await FirestoreManager.read(atPath: Path.Firestore.coupons)
    }
    
    @MainActor
    public func delete(coupon: Coupon) async throws {
        let _ = try await FirestoreManager.delete(coupon, atPath: Path.Firestore.coupons)
    }
    
    @MainActor
    public func fetch(couponString: String) async -> Coupon? {
        do {
            let queryItem = QueryItem("name", .isEqualTo, couponString.uppercased())
            let coupons: [Coupon] = try await FirestoreManager.query(path: Path.Firestore.coupons, queryItems: [queryItem], queryLimit: nil)
            guard let coupon = coupons.first else { return nil }
            guard coupon.isAvailable else { return nil }
            guard coupon.count < coupon.limit else { return nil }
            guard coupon.startsAt.dateValue() < Date() else { return nil }
            guard coupon.expiresAt.dateValue() > Date() else { return nil }
            return coupon
        } catch {
            return nil
        }
    }
    
    @MainActor
    public func fetchCoupons(merchant: Merchant) async throws -> [Coupon] {
        let queryItem = QueryItem("merchantUid", .isEqualTo, merchant.uid)
        return try await FirestoreManager.query(path: Path.Firestore.coupons, queryItems: [queryItem])
    }
    
    @MainActor
    public func consume(coupon: Coupon) async throws {
        try await Firestore.firestore().collection(Path.Firestore.coupons).document(coupon.uid).updateData(["count": FieldValue.increment(1.0)])
    }
    
    @MainActor
    public func updateFCMToken(_ fcmToken: String, uid: String) async throws {
        try await fetchCustomer(uid: uid)
        var updatedCustomer = customer
        updatedCustomer.fcmToken = fcmToken
        customer = try await FirestoreManager.update(updatedCustomer, atPath: Path.Firestore.customers)
    }
}


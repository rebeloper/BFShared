//
//  ProfileService.swift
//  
//
//  Created by Alex Nagy on 05.07.2022.
//

import SwiftUI
import FirebaseService
import FirebaseAuth

public class ProfileService: ObservableObject {
    
    public init() {}
    
    @Published public var admin = Admin()
    @Published public var customer = Customer()
    @Published public var merchant = Merchant()
    
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
    public func fetchCustomer(uid: String) async throws {
        customer = try await FirestoreManager.read(atPath: Path.Firestore.customers, uid: uid)
    }
    
    @MainActor
    public func fetchMerchant(uid: String) async throws {
        merchant = try await FirestoreManager.read(atPath: Path.Firestore.merchants, uid: uid)
    }
    
    // MARK: - Template Product Option
    @MainActor
    public func createTemplateProduct(option: TemplateProductOption) async throws {
        let _ = try await FirestoreManager.create(option, atPath: Path.Firestore.templateProductOptions)
    }
    
    @MainActor
    public func fetchTemplateProductOptions(_ type: TemplateProductOptionType) async throws -> [TemplateProductOption] {
        let queryItem = QueryItem("type", .isEqualTo, type.rawValue)
        return try await FirestoreManager.query(path: Path.Firestore.templateProductOptions, queryItems: [queryItem])
    }
    
    @MainActor
    public func deleteTemplateProduct(option: TemplateProductOption) async throws {
        let _ = try await FirestoreManager.delete(option, atPath: Path.Firestore.templateProductOptions)
    }
    
    @MainActor
    public func updateTemplateProduct(option: TemplateProductOption) async throws {
        let _ = try await FirestoreManager.update(option, atPath: Path.Firestore.templateProductOptions)
    }
    
    @MainActor
    public func fetchMerchants() async throws -> [Merchant] {
        return try await FirestoreManager.query(path: Path.Firestore.merchants)
    }
    
    @MainActor
    public func updateMerchant(_ merchant: Merchant) async throws {
        let _ = try await FirestoreManager.update(merchant, atPath: Path.Firestore.merchants)
    }
    
    @MainActor
    public func fetchProducts(for merchant: Merchant) async throws -> [Product] {
        let queryItem = QueryItem("merchantUid", .isEqualTo, merchant.uid)
        return try await FirestoreManager.query(path: Path.Firestore.products, queryItems: [queryItem])
    }
}


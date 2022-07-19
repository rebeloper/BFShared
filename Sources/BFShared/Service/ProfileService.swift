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
    
    @MainActor
    public func createTemplateProduct(size: TemplateProductSize) async throws {
        try await FirestoreManager.create(size, atPath: Path.Firestore.templateProductSizes)
    }
    
    @MainActor
    public func fetchTemplateProductSizes() async throws -> [TemplateProductSize] {
        try await FirestoreManager.read(atPath: Path.Firestore.templateProductSizes)
    }
    
    @MainActor
    public func deleteTemplateProductSize(uid: String) async throws {
        try await FirestoreManager<TemplateProductSize>.delete(atPath: Path.Firestore.templateProductSizes, withUid: uid)
    }
}


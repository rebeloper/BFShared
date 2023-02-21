//
//  StripeService.swift
//  
//
//  Created by Alex Nagy on 29.08.2022.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFunctions
import Stripe
import UIKit
import FirebaseService
import Combine

public class StripeService : ObservableObject {
    
    public init() {}
    
    public var cancellables: Set<AnyCancellable> = []
    
    @Published public var paymentSheet: PaymentSheet?
    @Published public var paymentResult: PaymentSheetResult?
    @Published public var isLoading = false
    
    @Published public var operationMessage = ""
    
    @Published public var setupPreparePaymentTimeout = 0
    
    @Published public var stripeConnectAccountLinkUrl = ""
    
    @Published public var accountId = ""
    
    public let taxPercentage: Double = 10.25
    public let serviceFeePercentage: Double = 9 // make sure this is exactly the same as set up in the: firebase functions:config:set stripe.application_fee_percentage="9"
    
    public func setupPreparePayment(amount: Int, currency: String, stripeConnectAccountId: String, timeout: Int = 4, completion: @escaping (Error?) -> ()) {
        guard amount > 1 else {
            completion(FirebaseError.custom(description: "Total must be greater than 1", code: 0))
            return
        }
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(FirebaseError.noUid)
            return
        }
        getCustomerId(uid: uid, timeout: timeout) { success in
            if success {
                self.preparePayment(amount: amount, currency: currency, stripeConnectAccountId: stripeConnectAccountId, completion: completion)
            }
        }
    }
    
    // we want to make sure that the customer_id is created before we prepare the payment
    public func getCustomerId(uid: String, timeout: Int, completion: @escaping (Bool) -> ()) {
        self.setupPreparePaymentTimeout += 1
        if self.setupPreparePaymentTimeout <= timeout {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                var ref: DocumentReference? = nil
                ref = Firestore.firestore().collection("stripe_customers").document(uid)
                
                print("Getting customer for uid: \(uid)")
                self.operationMessage = "Getting customer..."
                
                ref?.getDocument(completion: { snapshot, err in
                    if let err = err {
                        print("Did not find customer id: \(err.localizedDescription)")
                        print("Please, wait while we create your customer id, retrying in 2 seconds...")
                        self.operationMessage = "Did not find customer id: \(err.localizedDescription)\nPlease, wait while we create your customer id, retrying in 2 seconds..."
                        self.getCustomerId(uid: uid, timeout: timeout, completion: completion)
                        return
                    }
                    guard let snapshot = snapshot else {
                        print("Did not find customer id: no snapshot")
                        print("Please, wait while we create your customer id, retrying in 2 seconds...")
                        self.operationMessage = "Did not find customer id: no snapshot\nPlease, wait while we create your customer id, retrying in 2 seconds..."
                        self.getCustomerId(uid: uid, timeout: timeout, completion: completion)
                        return
                    }
                    guard let document = snapshot.data() else {
                        print("Did not find customer id: no document")
                        print("Please, wait while we create your customer id, retrying in 2 seconds...")
                        self.operationMessage = "Did not find customer id: no document\nPlease, wait while we create your customer id, retrying in 2 seconds..."
                        self.getCustomerId(uid: uid, timeout: timeout, completion: completion)
                        return
                    }
                    
                    guard let customer_id = document["customer_id"] as? String else {
                        print("Did not find customer id: no customer_id")
                        print("Please, wait while we create your customer id, retrying in 2 seconds...")
                        self.operationMessage = "Did not find customer id: no customer_id\nPlease, wait while we create your customer id, retrying in 2 seconds..."
                        self.getCustomerId(uid: uid, timeout: timeout, completion: completion)
                        return
                    }
                    print("Found customer id: \(customer_id)")
                    print("Preparing payment...")
                    self.operationMessage = "Found customer id\nPreparing payment..."
                    completion(true)
                })
            }
        } else {
            self.operationMessage = "Did not find customer id: no customer_id"
            completion(false)
        }
    }
    
    public func preparePayment(amount: Int, currency: String, stripeConnectAccountId: String, completion: @escaping (Error?) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(FirebaseError.noUid)
            return
        }
        self.paymentSheet = nil
        self.paymentResult = nil
        self.isLoading = true
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = Firestore.firestore().collection("stripe_customers").document(uid).collection("payments").addDocument(data: [
            "amount": amount,
            "currency": currency,
            "stripeConnectAccountId": stripeConnectAccountId
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(err)
            } else {
                print("Document added with ID: \(ref!.documentID)")
                print("Please, wait while we create your payment...")
                self.operationMessage = "Please, wait while we create your payment..."
                completion(nil)
            }
        }
        ref?.addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else {
                completion(FirebaseError.noDocumentSnapshot)
                return
            }
            guard let document = snapshot.data() else {
                completion(FirebaseError.noData)
                return
            }
            print("Received payment data: \(document)")
            self.operationMessage = "Received payment data..."
            
            let err = document["error"]
            
            if err != nil {
                self.operationMessage = "Error: \(String(describing: (err as? Error)?.localizedDescription))"
                completion(err as? Error)
                return
            }
            
            let customer = document["customer"] as? String
            let ephemeralKey = document["ephemeralKey"] as? String
            let clientSecret = document["client_secret"] as? String
            
            if customer != nil,
               ephemeralKey != nil,
               clientSecret != nil {
                // MARK: Create a PaymentSheet instance
                
                print("Creating the PaymentSheet...")
                self.operationMessage = "Creating the PaymentSheet..."
                
                var configuration = PaymentSheet.Configuration()
                configuration.merchantDisplayName = "BrainFreeze, LLC"
                configuration.customer = .init(id: customer!, ephemeralKeySecret: ephemeralKey!)
                configuration.primaryButtonColor = UIColor(named: "stripeYellow") ?? .blue
                
                DispatchQueue.main.async {
                    self.paymentSheet = PaymentSheet(paymentIntentClientSecret: clientSecret!, configuration: configuration)
                    self.isLoading = false
                    self.operationMessage = ""
                    completion(nil)
                }
            }
        }
    }
    
    public func onPaymentCompletion(result: PaymentSheetResult) {
        self.paymentSheet = nil
        self.paymentResult = result
    }
    
    @MainActor
    public func setUpStripeConnectAccount() async throws {
        guard let url = try await Functions.functions().httpsCallable("stripeConnectAccountLinkUrl").call().data as? String
        else { throw FirebaseError.noData }
        stripeConnectAccountLinkUrl = url
    }
    
    @MainActor
    public func getAccountId() async throws {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw FirebaseError.noUid
        }
        let promise = FirestoreService<StripeConnectAccount>.read(atPath: Path.Firestore.stripe_connect_accounts, uid: uid)
        let stripeConnectAccount = try await AsyncPromise.fulfill(promise, storedIn: &cancellables)
        self.accountId = stripeConnectAccount.accountId
    }
    
    @MainActor
    public func getAccountId(merchant: Merchant) async throws {
        let promise = FirestoreService<StripeConnectAccount>.read(atPath: Path.Firestore.stripe_connect_accounts, uid: merchant.uid)
        let stripeConnectAccount = try await AsyncPromise.fulfill(promise, storedIn: &cancellables)
        self.accountId = stripeConnectAccount.accountId
    }
}









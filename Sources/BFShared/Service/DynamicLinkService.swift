//
//  DynamicLinkService.swift
//  
//
//  Created by Alex Nagy on 03.10.2022.
//

import SwiftUI
import FirebaseDynamicLinks
import FirebaseService
import Combine

public class DynamicLinkService: ObservableObject {
    
    public init() {}
    
    public struct Setup {
        static let scheme = "https"
        static let host = "brainfreeze.app"
        static let path = "/links"
#if DEBUG
        static let domainURIPrefix = "https://brainfreezebackenddev.page.link"
#else
        static let domainURIPrefix = "https://brainfreezebackend.page.link"
#endif
        static let imageURL = "https://unsplash.com/photos/Wpg3Qm0zaGk/download?ixid=MnwxMjA3fDB8MXxzZWFyY2h8M3x8aWNlY3JlYW18fDB8fHx8MTY0Mzk3MTI3NA&force=true&w=640"
    }
    
    public var cancellables: Set<AnyCancellable> = []
    
    @Published public var url: String = ""
    @Published public var queryItems: [URLQueryItem] = []
    
    @MainActor
    public func createDynamicLink(title: String, description: String, info: [String: String], bundleIdentifier: String) async throws {
        
        var components = URLComponents()
        components.scheme = Setup.scheme
        components.host = Setup.host
        components.path = Setup.path
        
        components.queryItems = []
        info.forEach { data in
            let item = URLQueryItem(name: data.key, value: data.value)
            print(item)
            components.queryItems?.append(item)
        }
        
        print("Link is: \(components.string ?? "N/A")")
        guard let link = components.url else { throw CustomError.with(description: "Failed to create link", code: 0) }
        let dynamicLinksDomainURIPrefix = Setup.domainURIPrefix
        guard let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix) else { throw CustomError.with(description: "Failed to create link components", code: 1) }
        
        linkBuilder.iOSParameters = DynamicLinkIOSParameters(bundleID: bundleIdentifier)
//        linkBuilder.iOSParameters?.appStoreID = Setup.appleID
        
        linkBuilder.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
        linkBuilder.socialMetaTagParameters?.title = title
        linkBuilder.socialMetaTagParameters?.descriptionText = description
        linkBuilder.socialMetaTagParameters?.imageURL = URL(string: Setup.imageURL)

        guard let longDynamicLink = linkBuilder.url else { throw CustomError.with(description: "Failed to create dynamic link", code: 2) }
        print("The long URL is: \(longDynamicLink)")
        
        linkBuilder.options = DynamicLinkComponentsOptions()
        linkBuilder.options?.pathLength = .short
        let url = try await linkBuilder.shorten()
        print("The short URL is: \(url.0.absoluteString)")
        print("The short URL info: \(url.1)")
        
        self.url = url.0.absoluteString
    }
    
    @MainActor
    public func handleIncomingDynamicLink(url: URL) {
        #warning("Please do proper error handling")
        print("Incoming URL parameter is: \(url)")
        let linkHandled = DynamicLinks.dynamicLinks()
            .handleUniversalLink(url) { dynamicLink, error in
                guard error == nil else {
                    fatalError("Error handling the incoming dynamic link.")
                }
                if let dynamicLink = dynamicLink {
                    self.handleDynamicLink(dynamicLink)
                }
            }
        if linkHandled {
            print("Link Handled")
        } else {
            print("No Link Handled")
        }
    }
    
    @MainActor
    public func handleDynamicLink(_ dynamicLink: DynamicLink) {
        print("Recieved dynamic link: \(dynamicLink)")
        guard let url = dynamicLink.url else { return }
        
        print("Your incoming link parameter is \(url.absoluteString)")
        guard
            dynamicLink.matchType == .unique ||
                dynamicLink.matchType == .default
        else {
            return
        }
        
        parseComponents(from: url)
    }
    
    @MainActor
    public func parseComponents(from url: URL) {
        guard url.scheme == "https" else {
            return
        }
        guard url.pathComponents.contains("links") else {
            return
        }
        
        let components = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
        )!
        self.queryItems = components.queryItems ?? []
    }
    
    
    @Published public var merchant: Merchant = Merchant()
    @Published public var product: Product = Product()
    
    public func fetchMerchant(uid: String) async throws {
        let promise = FirestoreService<Merchant>.read(atPath: Path.Firestore.merchants, uid: uid)
        merchant = try await AsyncPromise.fulfill(promise, storedIn: &cancellables)
    }
    
    public func fetchProduct(uid: String) async throws {
        let promise = FirestoreService<Product>.read(atPath: Path.Firestore.products, uid: uid)
        product = try await AsyncPromise.fulfill(promise, storedIn: &cancellables)
    }
}


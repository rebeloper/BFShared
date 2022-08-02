//
//  FunctionsService.swift
//  
//
//  Created by Alex Nagy on 02.08.2022.
//

import SwiftUI
import FirebaseFunctions
import FirebaseService

public enum CallableFunctionName: String {
    case createUser = "createUser"
    case sendPushNotification = "sendPushNotification"
}

public class FunctionsService: ObservableObject {
    
    public init() {}
    
    @discardableResult
    public func callCreateUser(displayName: String, email: String, password: String) async throws -> HTTPSCallableResult {
        let data = [
            "displayName": displayName,
            "email": email,
            "password": password
        ]
        
        return try await CallableFunctionsService.call(CallableFunctionName.createUser.rawValue, data: data)
    }

    @discardableResult
    public func callPushNotification(title: String, message: String, recipientFCMToken: String) async throws -> HTTPSCallableResult {
        let data = [
            "title": title,
            "message": message,
            "fcmToken": recipientFCMToken
        ]
        return try await CallableFunctionsService.call(CallableFunctionName.sendPushNotification.rawValue, data: data)
    }

}



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
    public func callCreateUser(email: String,
                               password: String,
                               firstName: String,
                               lastName: String,
                               companyName: String,
                               phone: String,
                               description: String,
                               tags: String) async throws -> HTTPSCallableResult {
        let data = [
            "displayName": "\(firstName) \(lastName)",
            "email": email,
            "password": password,
            "firstName": firstName,
            "lastName": lastName,
            "companyName": companyName,
            "phone": phone,
            "description": description,
            "tags": tags
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



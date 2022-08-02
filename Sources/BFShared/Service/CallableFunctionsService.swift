//
//  CallableFunctionsService.swift
//  
//
//  Created by Alex Nagy on 02.08.2022.
//

import SwiftUI
import FirebaseFunctions

public enum CallableFunctionName: String {
    case sendCreateUser = "sendCreateUser"
    case sendPushNotification = "sendPushNotification"
}

class CallableFunctionsService: ObservedObservableObject {

    func call(_ name: CallableFunctionName, data: Any? = nil) async throws {
        try await Functions.functions().httpsCallable(name.rawValue).call(data)
    }
    
    func callCreateUser(email: String, password: String) async throws {
        let data = [
            "email": email,
            "password": password
        ]
        try await call(.sendCreateUser, data: data)
    }

    func callPushNotification(title: String, message: String, recipientFCMToken: String) async throws {
        let data = [
            "title": title,
            "message": message,
            "fcmToken": recipientFCMToken
        ]
        try await call(.sendPushNotification, data: data)
    }

}



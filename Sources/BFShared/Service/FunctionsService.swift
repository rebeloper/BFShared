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
                               profileImageUrl: String,
                               latitude: Double,
                               longitude: Double,
                               geoHash: String,
                               firstName: String,
                               lastName: String,
                               companyName: String,
                               phone: String,
                               description: String,
                               tags: String,
                               operation: [DayOfOperation]) async throws -> HTTPSCallableResult {
        let data = [
            "displayName": "\(firstName) \(lastName)",
            "email": email,
            "password": password,
            "profileImageUrl": profileImageUrl,
            "latitude": latitude,
            "longitude": longitude,
            "geoHash": geoHash,
            "firstName": firstName,
            "lastName": lastName,
            "companyName": companyName,
            "phone": phone,
            "description": description,
            "tags": tags,
            "mondayStartsAtHour": operation[0].startsAt.hour,
            "mondayStartsAtMinute": operation[0].startsAt.minute,
            "tuesdayStartsAtHour": operation[1].startsAt.hour,
            "tuesdayStartsAtMinute": operation[1].startsAt.minute,
            "wednesdayStartsAtHour": operation[2].startsAt.hour,
            "wednesdayStartsAtMinute": operation[2].startsAt.minute,
            "thursdayStartsAtHour": operation[3].startsAt.hour,
            "thursdayStartsAtMinute": operation[3].startsAt.minute,
            "fridayStartsAtHour": operation[4].startsAt.hour,
            "fridayStartsAtMinute": operation[4].startsAt.minute,
            "saturdayStartsAtHour": operation[5].startsAt.hour,
            "saturdayStartsAtMinute": operation[5].startsAt.minute,
            "sundayStartsAtHour": operation[6].startsAt.hour,
            "sundayStartsAtMinute": operation[6].startsAt.minute,
            "mondayClosesAtHour": operation[0].startsAt.hour,
            "mondayClosesAtMinute": operation[0].startsAt.minute,
            "tuesdayClosesAtHour": operation[1].startsAt.hour,
            "tuesdayClosesAtMinute": operation[1].startsAt.minute,
            "wednesdayClosesAtHour": operation[2].startsAt.hour,
            "wednesdayClosesAtMinute": operation[2].startsAt.minute,
            "thursdayClosesAtHour": operation[3].startsAt.hour,
            "thursdayClosesAtMinute": operation[3].startsAt.minute,
            "fridayClosesAtHour": operation[4].startsAt.hour,
            "fridayClosesAtMinute": operation[4].startsAt.minute,
            "saturdayClosesAtHour": operation[5].startsAt.hour,
            "saturdayClosesAtMinute": operation[5].startsAt.minute,
            "sundayClosesAtHour": operation[6].startsAt.hour,
            "sundayClosesAtMinute": operation[6].startsAt.minute,
        ] as [String : Any]
        
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



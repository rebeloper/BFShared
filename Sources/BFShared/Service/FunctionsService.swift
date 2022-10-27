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
            "mondayClosesAtHour": operation[0].closesAt.hour,
            "mondayClosesAtMinute": operation[0].closesAt.minute,
            "tuesdayClosesAtHour": operation[1].closesAt.hour,
            "tuesdayClosesAtMinute": operation[1].closesAt.minute,
            "wednesdayClosesAtHour": operation[2].closesAt.hour,
            "wednesdayClosesAtMinute": operation[2].closesAt.minute,
            "thursdayClosesAtHour": operation[3].closesAt.hour,
            "thursdayClosesAtMinute": operation[3].closesAt.minute,
            "fridayClosesAtHour": operation[4].closesAt.hour,
            "fridayClosesAtMinute": operation[4].closesAt.minute,
            "saturdayClosesAtHour": operation[5].closesAt.hour,
            "saturdayClosesAtMinute": operation[5].closesAt.minute,
            "sundayClosesAtHour": operation[6].closesAt.hour,
            "sundayClosesAtMinute": operation[6].closesAt.minute,
            "isMondayClosed": operation[0].isClosed,
            "isTuesdayClosed": operation[1].isClosed,
            "isWednesdayClosed": operation[2].isClosed,
            "isThursdayClosed": operation[3].isClosed,
            "isFridayClosed": operation[4].isClosed,
            "isSaturdayClosed": operation[5].isClosed,
            "isSundayClosed": operation[6].isClosed,
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



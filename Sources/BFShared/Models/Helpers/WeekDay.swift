//
//  WeekDay.swift
//  
//
//  Created by Alex Nagy on 28.10.2022.
//

import SwiftUI
import FirebaseService
import BetterCodable
import Firebase
import FirebaseFirestoreSwift

public struct WeekDay: Codable, Hashable {
    
    @DefaultNow public var opensDate: Date
    @DefaultNow public var closesDate: Date
    
    public init(opensDate: Date? = nil,
                closesDate: Date? = nil) {
        self.opensDate = opensDate ?? Date()
        self.closesDate = closesDate ?? Date()
    }
    
}

public struct DefaultWeekDayStrategy: DefaultCodableStrategy {
    public static var defaultValue: WeekDay { return WeekDay() }
}

public typealias DefaultEmptyWeekDay = DefaultCodable<DefaultWeekDayStrategy>



//
//  DayOfOperation.swift
//  
//
//  Created by Alex Nagy on 27.10.2022.
//

import SwiftUI
import FirebaseService
import BetterCodable
import Firebase
import FirebaseFirestoreSwift

public struct DayOfOperation: Codable, Hashable {
    
    @DefaultZeroInt public var day: Int
    @DefaultEmptyHourAndMinuteOfOperation public var startsAt: HourAndMinuteOfOperation
    @DefaultEmptyHourAndMinuteOfOperation public var closesAt: HourAndMinuteOfOperation
    
    public init(day: Int? = nil,
                startsAt: HourAndMinuteOfOperation? = nil,
                closesAt: HourAndMinuteOfOperation? = nil) {
        self.day = day ?? 0
        self.startsAt = startsAt ?? HourAndMinuteOfOperation()
        self.closesAt = closesAt ?? HourAndMinuteOfOperation()
    }
    
}

public struct DefaultDayOfOperationStrategy: DefaultCodableStrategy {
    public static var defaultValue: DayOfOperation { return DayOfOperation() }
}

public typealias DefaultEmptyDayOfOperation = DefaultCodable<DefaultDayOfOperationStrategy>


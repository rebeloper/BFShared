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
    @DefaultFalse public var isClosed: Bool
    @DefaultEmptyHourAndMinuteOfOperation public var startsAt: HourAndMinuteOfOperation
    @DefaultEmptyHourAndMinuteOfOperation public var closesAt: HourAndMinuteOfOperation
    
    public init(day: Int? = nil,
                isClosed: Bool? = nil,
                startsAt: HourAndMinuteOfOperation? = nil,
                closesAt: HourAndMinuteOfOperation? = nil) {
        self.day = day ?? 0
        self.isClosed = isClosed ?? false
        self.startsAt = startsAt ?? HourAndMinuteOfOperation()
        self.closesAt = closesAt ?? HourAndMinuteOfOperation()
    }
    
}

public struct DefaultDayOfOperationStrategy: DefaultCodableStrategy {
    public static var defaultValue: DayOfOperation { return DayOfOperation() }
}

public typealias DefaultEmptyDayOfOperation = DefaultCodable<DefaultDayOfOperationStrategy>


//
//  HourAndMinuteOfOperation.swift
//  
//
//  Created by Alex Nagy on 27.10.2022.
//

import SwiftUI
import FirebaseService
import BetterCodable
import Firebase
import FirebaseFirestoreSwift

public struct HourAndMinuteOfOperation: Codable, Hashable {
    
    @DefaultZeroInt public var hour: Int
    @DefaultZeroInt public var minute: Int
    
    public init(hour: Int? = nil,
                minute: Int? = nil) {
        self.hour = hour ?? 0
        self.minute = minute ?? 0
    }
    
}

public struct DefaultHourAndMinuteOfOperationStrategy: DefaultCodableStrategy {
    public static var defaultValue: HourAndMinuteOfOperation { return HourAndMinuteOfOperation() }
}

public typealias DefaultEmptyHourAndMinuteOfOperation = DefaultCodable<DefaultHourAndMinuteOfOperationStrategy>

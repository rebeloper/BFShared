//
//  Int+.swift
//  
//
//  Created by Alex Nagy on 19.07.2022.
//

import Foundation

public extension Int {
    func toStripeDouble() -> Double {
        Double(self) / 100
    }
    
    func toStripeString(currency: String = "$ ") -> String {
        if self == 0 {
            return "FREE"
        } else {
            if self % 10 == 0 {
                if self % 100 == 0 {
                    return "\(currency)\(self / 100).00"
                } else {
                    return "\(currency)\(self.toStripeDouble().convert(maxDecimals: 1))0"
                }
            } else {
                return "\(currency)\(self.toStripeDouble().convert(maxDecimals: 2))"
            }
        }
    }
}

//
//  Int+.swift
//  
//
//  Created by Alex Nagy on 19.07.2022.
//

import Foundation

public extension Int {
    func toStripeDouble() -> Double {
        let double = Double(self)
        if self % 100 == 0 {
            return Double(Int(double / 100))
        } else {
            return double / 100
        }
    }
    
    func toStripeString(currency: String = "$ ") -> String {
        "\(currency)\(self.toStripeDouble().convert(maxDecimals: 2))"
    }
}

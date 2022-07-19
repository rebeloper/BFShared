//
//  Int+.swift
//  
//
//  Created by Alex Nagy on 19.07.2022.
//

import Foundation

extension Int {
    func toStripeDouble() -> Double {
        Double(self) / 100
    }
}

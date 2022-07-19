//
//  Double+.swift
//  
//
//  Created by Alex Nagy on 19.07.2022.
//

import Foundation

extension Double {
    func toStripeInt() -> Int {
        Int(self * 100)
    }
}

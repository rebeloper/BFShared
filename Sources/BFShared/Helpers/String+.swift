//
//  String+.swift
//  
//
//  Created by Alex Nagy on 23.01.2023.
//

import Foundation

extension String {
    func orderId() -> String {
        String(self.suffix(5))
    }
}

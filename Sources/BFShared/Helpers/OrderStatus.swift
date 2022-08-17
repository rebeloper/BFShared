//
//  OrderStatus.swift
//  
//
//  Created by Alex Nagy on 17.08.2022.
//

import Foundation

public enum OrderStatus: Int {
    case none = 0, ordered, inReview, preparing, readyForPickup, completed
}

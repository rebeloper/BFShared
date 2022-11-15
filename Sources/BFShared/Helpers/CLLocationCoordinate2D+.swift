//
//  CLLocationCoordinate2D+.swift
//  
//
//  Created by Alex Nagy on 11.08.2022.
//

import CoreLocation

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        UUID().uuidString
    }
}

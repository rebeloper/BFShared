//
//  CLPlacemark+.swift
//  
//
//  Created by Alex Nagy on 11.08.2022.
//

import CoreLocation

public extension CLPlacemark {
    func address() -> String {
        let thoroughfare = self.thoroughfare == nil ? "" : "\(self.thoroughfare!), "
        let subThoroughfare = self.subThoroughfare == nil ? "" : "\(self.subThoroughfare!), "
        let locality = self.locality == nil ? "" : "\(self.locality!), "
        let subLocality = self.subLocality == nil ? "" : "\(self.subLocality!), "
        let administrativeArea = self.administrativeArea == nil ? "" : "\(self.administrativeArea!), "
        let country = self.country == nil ? "" : "\(self.country!)"
        return "\(thoroughfare)\(subThoroughfare)\(locality)\(subLocality)\(administrativeArea)\(country)"
    }
}

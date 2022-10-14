//
//  Path.swift
//  
//
//  Created by Alex Nagy on 05.07.2022.
//

import Foundation

public struct Path {
    
    public struct Firestore {
        public static let admins = "admins"
        public static let merchants = "merchants"
        public static let customers = "customers"
        
        public static let templateProductOptions = "templateProductOptions"
        
        public static let products = "products"
        public static let orders = "orders"
        
        public static let chatRooms = "chatRooms"
        public static let chatMessages = "chatMessages"
        
        public static let stripe_connect_accounts = "stripe_connect_accounts"
        
        public static let coupons = "coupons"
    }
    
    public struct Storage {
        public static let merchantProfileImages = "merchantProfileImages"
        public static let customerProfileImages = "customerProfileImages"
        public static let productImages = "productImages"
    }
    
}

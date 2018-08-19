//
//  Cart.swift
//  MovileHack
//
//  Created by Movile Hack on 18/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

final class Cart {
    // MARK: - Singleton
    static private var sharedInstance: Cart?
    
    // MARK: - Variables
    private var products = [String : UInt]()
    
    // MARK: - Singleton Methods
    static func getSharedInstance() -> Cart {
        guard let sharedInstance = self.sharedInstance else {
            let sharedInstance = Cart()
            self.sharedInstance = sharedInstance
            return sharedInstance
        }

        return sharedInstance
    }
    
    private init() {}
    
    // MARK: - Methods
    func clear() {
        self.products = [:]

        TabBarUtils.setCartTabbarNumber(self.products.count)
        
        NotificationCenter.default.post(name: .CartCleared, object: nil)
    }
    
//    func addProducts(_ products: [MarketableProduct]) {
//        for marketableProduct in products {
//            if let productQuantity = self.products[marketableProduct.product.id] {
//                self.products[product.id] = productQuantity + quantity
//            } else {
//                self.products[product.id] = quantity
//            }
//        }
//        TabBarUtils.setCartTabbarNumber(self.products.count)
//    }
}

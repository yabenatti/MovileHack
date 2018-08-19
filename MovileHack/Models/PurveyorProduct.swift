//
//  PurveyorProduct.swift
//  MovileHack
//
//  Created by Movile Hack on 19/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import Foundation

final class PurveyorProduct : Hashable, Equatable {
    // MARK: - Properties
    let id: String
    let product: Product
    let purveyor: Purveyor
    let quantity: Double
    let unit: ProductUnit
    let price: Double
    let deliveryTime: Double
    
    // MARK: - Initialization
    init(id: String, product: Product, purveyor: Purveyor, quantity: Double, unit: ProductUnit, price: Double, deliveryTime: Double) {
        self.id = id
        self.product = product
        self.purveyor = purveyor
        self.quantity = quantity
        self.unit = unit
        self.price = price
        self.deliveryTime = deliveryTime
    }
    
    // MARK: - Hashable
    var hashValue: Int {
        return self.id.hashValue
    }
    
    // MARK: - Equatable
    static func == (lhs: PurveyorProduct, rhs: PurveyorProduct) -> Bool {
        return lhs.id == rhs.id
    }
}

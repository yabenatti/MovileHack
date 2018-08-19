//
//  PurveyorProduct.swift
//  MovileHack
//
//  Created by Movile Hack on 19/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import Foundation

final class PurveyorProduct {
    let product: Product
    let purveyor: Purveyor
    let quantity: UInt
    let unit: ProductUnit
    
    init(product: Product, purveyor: Purveyor, quantity: UInt, unit: ProductUnit) {
        self.product = product
        self.purveyor = purveyor
        self.quantity = quantity
        self.unit = unit
    }
}

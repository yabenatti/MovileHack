//
//  MealProduct.swift
//  MovileHack
//
//  Created by Movile Hack on 19/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

final class MealProduct {
    // MARK: - Properties
    let product: Product
    let quantity: Double
    let unit: ProductUnit

    // MARK: - Initialization
    init(product: Product, quantity: Double, unit: ProductUnit) {
        self.product = product
        self.quantity = quantity
        self.unit = unit
    }
}

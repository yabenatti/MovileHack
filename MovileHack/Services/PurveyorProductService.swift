//
//  PurveyorProductService.swift
//  MovileHack
//
//  Created by Movile Hack on 19/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

final class PurveyorProductService {
    private class func getBasePriceFor(productId: String, purveyorId: String) -> Double {
        let purveyorModifier: Double
        if purveyorId == "500" {
            purveyorModifier = 0.53
        } else if purveyorId == "501" {
            purveyorModifier = 0.64
        } else if purveyorId == "502" {
            purveyorModifier = 0.31
        } else {
            purveyorModifier = 1.0
        }
        if productId == "100" {
            return 0.37 * purveyorModifier
        } else if productId == "101" {
            return 0.56 * purveyorModifier
        } else if productId == "102" {
            return 0.44 * purveyorModifier
        } else if productId == "103" {
            return 0.045 * purveyorModifier
        } else if productId == "104" {
            return 0.06 * purveyorModifier
        } else {
            return 1.0 * purveyorModifier
        }
    }
    
    class func getTopPurveyorProducts(mealProduct: MealProduct, completion: @escaping ([PurveyorProduct]?) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(arc4random_uniform(1000)) / 1000.0) {
            var featuredProduct: PurveyorProduct?
            var fastestProduct: PurveyorProduct?
            var cheapestProduct: PurveyorProduct?
            let dispatchGroup = DispatchGroup()
            
            dispatchGroup.enter()
            FacadeService.getPurveyor(purveyorId: "500", completion: { (purveyor) in
                if let purveyor = purveyor {
                    featuredProduct = PurveyorProduct(id: "1000", product: mealProduct.product, purveyor: purveyor, quantity: mealProduct.quantity, unit: mealProduct.unit, price: self.getBasePriceFor(productId: mealProduct.product.id, purveyorId: purveyor.id) * mealProduct.quantity, deliveryTime: 5.0)
                }
                dispatchGroup.leave()
            })
            dispatchGroup.enter()
            FacadeService.getPurveyor(purveyorId: "501", completion: { (purveyor) in
                if let purveyor = purveyor {
                    fastestProduct = PurveyorProduct(id: "1001", product: mealProduct.product, purveyor: purveyor, quantity: mealProduct.quantity, unit: mealProduct.unit, price: self.getBasePriceFor(productId: mealProduct.product.id, purveyorId: purveyor.id) * mealProduct.quantity, deliveryTime: 2.8)
                }
                dispatchGroup.leave()
            })
            dispatchGroup.enter()
            FacadeService.getPurveyor(purveyorId: "502", completion: { (purveyor) in
                if let purveyor = purveyor {
                    cheapestProduct = PurveyorProduct(id: "1002", product: mealProduct.product, purveyor: purveyor, quantity: mealProduct.quantity, unit: mealProduct.unit, price: self.getBasePriceFor(productId: mealProduct.product.id, purveyorId: purveyor.id) * mealProduct.quantity, deliveryTime: 9.25)
                }
                dispatchGroup.leave()
            })
            
            dispatchGroup.notify(queue: .main, execute: {
                guard let featuredProduct = featuredProduct, let fastestProduct = fastestProduct, let cheapestProduct = cheapestProduct else {
                    completion(nil)
                    return
                }
                completion([featuredProduct, fastestProduct, cheapestProduct])
            })
        }
    }
}

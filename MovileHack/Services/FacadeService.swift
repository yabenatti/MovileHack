//
//  FacadeService.swift
//  MovileHack
//
//  Created by Movile Hack on 19/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import Foundation

final class FacadeService {
    // MARK: - Meal Service
    class func getAllUserMeals(completion: @escaping ([Meal]?) -> ()) {
        MealService.getAllUserMeals(completion: completion)
    }
    
    // MARK: - Product Service
    class func getProductsFor(mealId: String, completion: @escaping ([Product]?) -> ()) {
        ProductService.getProductsFor(mealId: mealId, completion: completion)
    }
}

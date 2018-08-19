//
//  MealService.swift
//  MovileHack
//
//  Created by Movile Hack on 19/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

final class MealService {
    class func getAllUserMeals(completion: @escaping ([Meal]?) -> ()) {
        let dispatchGroup = DispatchGroup()
        var meals = [Meal]()
        
        dispatchGroup.enter()
        FacadeService.getProductsFor(mealId: "1") { (products) in
            if let products = products {
                let meal = Meal(id: "1", name: "Salada de Frutas", imageUrl: nil)
                var mealProducts = [MealProduct]()
                mealProducts.append(MealProduct(product: products[0], quantity: 7, unit: .Unit)) //Banana
                mealProducts.append(MealProduct(product: products[1], quantity: 4.5, unit: .Unit)) //Maçã
                mealProducts.append(MealProduct(product: products[2], quantity: 4, unit: .Unit)) //Laranja
                meal.products = mealProducts
                meals.append(meal)
            }
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        FacadeService.getProductsFor(mealId: "2") { (products) in
            if let products = products {
                let meal = Meal(id: "2", name: "Esfiha de Frango", imageUrl: nil)
                var mealProducts = [MealProduct]()
                mealProducts.append(MealProduct(product: products[0], quantity: 10, unit: .Grams)) //Frango
                mealProducts.append(MealProduct(product: products[1], quantity: 20, unit: .Grams)) //Massa
                meal.products = mealProducts
                meals.append(meal)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(meals)
        }
    }
}

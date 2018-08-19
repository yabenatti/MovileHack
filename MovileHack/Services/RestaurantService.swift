//
//  RestaurantService.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-19.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import Foundation

final class RestaurantService {
    class func getCurrentRestaurant(completion: @escaping (Restaurant) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(arc4random_uniform(1000)) / 1000.0) {
            let restaurant = Restaurant(id: "1", name: "Jessie Magalhães", email: "jessie@magalhaes.com", phoneNumber: "+55 (019) 999-0158", website: "", imageUrl: "")
            completion(restaurant)
        }
    }
}

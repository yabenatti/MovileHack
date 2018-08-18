//
//  Meal.swift
//  MovileHack
//
//  Created by Movile Hack on 18/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class Meal {
    // MARK: - Properties
    let id: String
    let name: String
    let mealDescription: String?
    let photoUrl: String?
    var photo: UIImage?
    
    // MARK: - Initializers
    init(id: String, name: String, photoUrl: String?) {
        self.id = id
        self.name = name
        self.photoUrl = photoUrl
        self.photo = nil
        self.mealDescription = nil
    }
    
    // FIXME: Implement Photo download
}

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
    let imageUrl: String?
    var image: UIImage?
    
    // MARK: - Initializers
    init(id: String, name: String, imageUrl: String?) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.image = nil
    }
    
    // FIXME: Implement Photo download
}

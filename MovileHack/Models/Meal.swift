//
//  Meal.swift
//  MovileHack
//
//  Created by Movile Hack on 18/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class Meal {
    let id: String
    let name: String
    let photoUrl: String?
    var photo: UIImage?
    
    init(id: String, name: String, photoUrl: String?) {
        self.id = id
        self.name = name
        self.photoUrl = photoUrl
        self.photo = nil
    }
    
    // FIXME: Implement Photo download
}

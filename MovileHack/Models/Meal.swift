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
    var products = [Product]()
    
    // MARK: - Initializers
    init(id: String, name: String, imageUrl: String?) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.image = nil
        
        self.getMealImage()
    }
    
    func getMealImage() {
        guard let urlString = self.imageUrl, let photoUrl = URL(string: urlString) else {
            return
        }
        
        let request = URLRequest(url: photoUrl)
        let photoDownloadTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    NotificationCenter.default.post(name: .MealImageDownloadFailed, object: nil, userInfo: [NotificationCenterKeys.MealId : self.id])
                } else if let imageData = data, let image = UIImage(data: imageData) {
                    self.image = image
                    NotificationCenter.default.post(name: .MealImageDownloaded, object: nil, userInfo: [NotificationCenterKeys.MealId : self.id])
                }
            }
        }
        photoDownloadTask.resume()
    }
}

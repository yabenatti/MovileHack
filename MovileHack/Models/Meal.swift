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
    var products = [Product]()
    
    // MARK: - Initializers
    init(id: String, name: String, photoUrl: String?) {
        self.id = id
        self.name = name
        self.photoUrl = photoUrl
        self.photo = nil
        self.mealDescription = nil
    }
    
    func getMealImage(completion: @escaping((_ image :UIImage?)->())) {
        guard let urlString = self.photoUrl, let photoUrl = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let request = URLRequest(url: photoUrl)
        let photoDownloadTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    completion(nil)
                } else if let imageData = data, let image = UIImage(data: imageData) {
                    completion(image)
                }
            }
        }
        photoDownloadTask.resume()
    }
}

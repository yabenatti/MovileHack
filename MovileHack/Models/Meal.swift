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
    }
    
    func getMealImage(completion: @escaping((_ image :UIImage?)->())) {
        guard let urlString = self.imageUrl, let photoUrl = URL(string: urlString) else {
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

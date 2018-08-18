//
//  Product.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class Product {
    // MARK: - Properties
    let id: String
    let name: String
    let expirationDate: Date
    let photoUrl: String?
    var photo: UIImage?
    
    // MARK: - Initializers
    init(id: String, name: String, expirationDate: Date, photoUrl: String?) {
        self.id = id
        self.name = name
        self.expirationDate = expirationDate
        self.photoUrl = photoUrl
        self.photo = nil
    }
    
    func getProductImage(completion: @escaping((_ image :UIImage?)->())) {
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

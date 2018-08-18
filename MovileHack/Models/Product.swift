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
    let imageUrl: String?
    var image: UIImage?
    
    // MARK: - Initializers
    init(id: String, name: String, expirationDate: Date, imageUrl: String?) {
        self.id = id
        self.name = name
        self.expirationDate = expirationDate
        self.imageUrl = imageUrl
        self.image = nil
        
        self.getProductImage()
    }
    
    func getProductImage() {
        guard let urlString = self.imageUrl, let imageUrl = URL(string: urlString) else {
            return
        }
        
        let request = URLRequest(url: imageUrl)
        let photoDownloadTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    NotificationCenter.default.post(name: .ProductImageDownloadFailed, object: nil, userInfo: [NotificationCenterKeys.ProductId : self.id])
                } else if let imageData = data, let image = UIImage(data: imageData) {
                    self.image = image
                    NotificationCenter.default.post(name: .ProductImageDownloaded, object: nil, userInfo: [NotificationCenterKeys.ProductId : self.id])
                }
            }
        }
        photoDownloadTask.resume()
    }
}

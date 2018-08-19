//
//  Restaurant.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-19.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit
import CoreLocation

final class Restaurant: Hashable, Equatable {
    // MARK: - Properties
    let id: String
    let name: String
    let email: String
    let latitude: CLLocation?
    let longitude: CLLocation?
    let phoneNumber: String?
    let website: String?
    let imageUrl: String?
    var image: UIImage?
    
    // MARK: - Initializers
    init(id: String, name: String, email: String, phoneNumber: String, website: String?,  imageUrl: String?) {
        self.id = id
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.website = website
        self.imageUrl = imageUrl
        self.image = nil
        self.latitude = nil
        self.longitude = nil
        
        self.getRestaurantImage()
    }
    
    // MARK: - Hashable
    var hashValue: Int {
        return self.id.hashValue
    }
    
    // MARK: - Equatable
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.id == rhs.id
    }
    
    // MARK: - Methods
    func getRestaurantImage() {
        guard let urlString = self.imageUrl, let imageUrl = URL(string: urlString) else {
            return
        }
        
        let request = URLRequest(url: imageUrl)
        let photoDownloadTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let _ = error {
                    NotificationCenter.default.post(name: .RestaurantImageDownloadFailed, object: nil, userInfo: [NotificationCenterKeys.ProductId : self.id])
                } else if let imageData = data, let image = UIImage(data: imageData) {
                    self.image = image
                    NotificationCenter.default.post(name: .RestaurantImageDownloaded, object: nil, userInfo: [NotificationCenterKeys.ProductId : self.id])
                }
            }
        }
        photoDownloadTask.resume()
    }
}

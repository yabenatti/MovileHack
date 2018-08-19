//
//  NotificationName.swift
//  MovileHack
//
//  Created by Movile Hack on 18/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

extension Notification.Name {
    //Meal Image
    static let MealImageDownloaded = Notification.Name(rawValue: "MealImageDownloaded")
    static let MealImageDownloadFailed = Notification.Name(rawValue: "MealImageDownloadFailed")
    
    //Product Image
    static let ProductImageDownloaded = Notification.Name(rawValue: "ProductImageDownloaded")
    static let ProductImageDownloadFailed = Notification.Name(rawValue: "ProductImageDownloadFailed")
    
    //Restaurant Image
    static let RestaurantImageDownloaded = Notification.Name(rawValue: "RestaurantImageDownloaded")
    static let RestaurantImageDownloadFailed = Notification.Name(rawValue: "RestaurantImageDownloadFailed")
    
    //Cart
    static let CartCleared = Notification.Name(rawValue: "CartCleared")
}

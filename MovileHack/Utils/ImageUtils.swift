//
//  ImageUtils.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class ImageUtils {
    class func downloadImage(urlString: String, completion: @escaping(_ image: UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let request = URLRequest(url: url)
        let downloadTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil, let imageData = data, let image = UIImage(data: imageData) else {
                completion(nil)
                return
            }
            completion(image)
        }
        downloadTask.resume()
    }
}

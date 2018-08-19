//
//  CALayerExtension.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-19.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

extension CALayer {
    
    static func setDropShadow(layer : CALayer, radius : CGFloat, opacity : Float) {
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = radius
        layer.shadowColor = UIColor.dropShadow.cgColor
        layer.shadowOpacity = opacity
    }
}

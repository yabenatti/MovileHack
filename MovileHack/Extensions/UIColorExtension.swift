//
//  UIColorExtension.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

extension UIColor {
    public class var movilePink : UIColor {
        return UIColor(hex: "F92D6C", alpha: 1)
    }
    
    public class var movileBlue : UIColor {
        return UIColor(hex: "007AFF", alpha: 1)
    }
    
    public class var dropShadow : UIColor {
        return UIColor(hex: "337b9f", alpha: 1)
    }
    
    public class var darkBlue : UIColor {
        return UIColor(hex: "4C51CD", alpha: 1)
    }
}

extension UIColor {
    //Convert HEX to RGB
    convenience init(hex: String, alpha: CGFloat) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: alpha
        )
    }
}


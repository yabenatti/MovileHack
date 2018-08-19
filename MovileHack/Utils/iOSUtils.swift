//
//  iOSUtils.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-19.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class iOSUtils {
    class func isPhoneX() -> Bool {
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2436:
                //iPhone X
                return true
            default:
                return false
            }
        }
        return false
    }
}

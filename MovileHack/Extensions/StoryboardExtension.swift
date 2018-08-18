//
//  StoryboardExtension.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

extension UIStoryboard {
    convenience init(name: StoryboardName) {
        self.init(name: name.rawValue, bundle: nil)
    }
}

//
//  TabBarUtils.swift
//  MovileHack
//
//  Created by Movile Hack on 18/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

final class TabBarUtils {
    class func setCartTabbarNumber(_ number: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let window = appDelegate.window, let tabBarController = window.rootViewController as? TabBarController, let viewControllers = tabBarController.viewControllers else {
            return
        }
        
        //Find conversation list tab
        if let index = viewControllers.index(where: { (viewController) -> Bool in
            guard let navigationController = viewController as? UINavigationController else {
                return false
            }
            return navigationController.viewControllers.contains(where: { (viewController) -> Bool in
                return viewController is ShoppingCartViewController
            })
        }) {
            if let items = tabBarController.tabBar.items, items.count > index {
                let tabItem = items[index]
                if number > 0 {
                    tabItem.badgeValue = "\(number)"
                } else {
                    tabItem.badgeValue = nil
                }
            }
        }
    }
}

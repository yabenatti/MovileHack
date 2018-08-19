//
//  PriceUtils.swift
//  MovileHack
//
//  Created by Movile Hack on 19/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

final class PriceUtils {
    static func getFormattedPrice(_ price: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "pt_br")
        return currencyFormatter.string(from: NSNumber(floatLiteral: price)) ?? ""
    }
}

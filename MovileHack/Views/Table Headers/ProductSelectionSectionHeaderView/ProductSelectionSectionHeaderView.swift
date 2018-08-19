//
//  ProductSelectionSectionHeaderView.swift
//  MovileHack
//
//  Created by Movile Hack on 18/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class ProductSelectionSectionHeaderView: BaseView {
    // MARK: - IBOutlets
    @IBOutlet weak var productNameLabel: UILabel! {
        didSet {
            self.productNameLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        }
    }
    @IBOutlet weak var productQuantityLabel: UILabel! {
        didSet {
            self.productQuantityLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        }
    }
    
    // MARK: - Methods
    func setup(mealProduct: MealProduct) {
        self.productNameLabel.text = mealProduct.product.name
        self.productQuantityLabel.text = "\(mealProduct.quantity)\(mealProduct.unit.rawValue)"
    }
}

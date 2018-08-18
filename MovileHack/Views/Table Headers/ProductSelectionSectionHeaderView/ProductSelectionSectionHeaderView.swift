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
    @IBOutlet weak var productNameLabel: UILabel!
    
    // MARK: - Methods
    func setup(product: Product) {
        self.productNameLabel.text = product.name
    }
}

//
//  IngredientsTableViewCell.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Methods
    func populateWithMealProduct(_ mealProduct: MealProduct) {
        self.productNameLabel.text = mealProduct.product.name
        self.productQuantityLabel.text = "\(mealProduct.quantity)\(mealProduct.unit.rawValue)"
    }
}

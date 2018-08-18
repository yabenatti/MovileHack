//
//  MyMealsTableViewCell.swift
//  MovileHack
//
//  Created by Movile Hack on 18/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class MyMealsTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var mealImageView: UIImageView! {
        didSet {
            self.mealImageView.contentMode = .scaleAspectFill
            self.mealImageView.layer.cornerRadius = 10.0
            self.mealImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var mealNameLabel: UILabel! {
        didSet {
            self.mealNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        }
    }
    @IBOutlet weak var productsLabel: UILabel! {
        didSet {
            self.productsLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
    }
    
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(meal: Meal) {
        if let mealImage = meal.image {
            self.mealImageView.image = mealImage
        } else {
            self.mealImageView.image = UIImage(named: "meal_default")
        }
        
        self.mealNameLabel.text = meal.name
        
        //Meal Products and Quantity
        var mealProductsAndQuantityLabelString = ""
        for product in meal.products {
            mealProductsAndQuantityLabelString.append(product.name + " ")
        }
        self.productsLabel.text = mealProductsAndQuantityLabelString
    }
}

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
    @IBOutlet weak var lineSeparatorView: UIView! {
        didSet {
            self.lineSeparatorView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        }
    }
    @IBOutlet weak var addedToCartView: UIView! {
        didSet {
            self.addedToCartView.layer.cornerRadius = addedToCartView.frame.height / 2.0 - 4.0
            self.addedToCartView.clipsToBounds = true
            self.addedToCartView.contentMode = .scaleAspectFill
            self.addedToCartView.backgroundColor = UIColor.movilePink
        }
    }
    @IBOutlet weak var addedToCartLabel: UILabel! {
        didSet {
            self.addedToCartLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            self.addedToCartLabel.textColor = UIColor.white
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
    
    func setup(meal: Meal, quantity: UInt? = nil) {
        if let mealImage = meal.image {
            self.mealImageView.image = mealImage
        } else {
            self.mealImageView.image = UIImage(named: "meal_default")
        }
        
        self.mealNameLabel.text = meal.name
        
        //Meal Products and Quantity
        var mealProductsAndQuantityLabelString = ""
        for i in 0..<meal.products.count {
            let product = meal.products[i].product
            if i == 0 {
                if meal.products.count > 1 {
                    mealProductsAndQuantityLabelString.append(product.name + ", ")
                } else {
                    mealProductsAndQuantityLabelString.append(product.name)
                }
            } else if i == meal.products.count - 1 {
                mealProductsAndQuantityLabelString.append(product.name)
            } else {
                mealProductsAndQuantityLabelString.append(product.name + ", ")
            }
        }
        self.productsLabel.text = mealProductsAndQuantityLabelString
        
        if let quantity = quantity {
            self.addedToCartLabel.text = "\(quantity)"
            self.addedToCartView.isHidden = false
        } else {
            self.addedToCartView.isHidden = true
        }
    }
}

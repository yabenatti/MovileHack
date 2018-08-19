//
//  ProductSearchTableViewCell.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class ProductSearchTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var productImageView: UIImageView! {
        didSet {
            self.productImageView.contentMode = .scaleAspectFill
            self.productImageView.layer.cornerRadius = 10.0
            self.productImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var productNameLabel: UILabel! {
        didSet {
            self.productNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateWithProduct(_ product: Product) {
        if let productImage = product.image {
            self.productImageView.image = productImage
        } else {
            self.productImageView.image = UIImage(named: "meal_default")
        }
        
        self.productNameLabel.text = product.name
    }
}

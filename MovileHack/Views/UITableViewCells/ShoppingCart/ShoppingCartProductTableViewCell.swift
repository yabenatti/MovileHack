//
//  ShoppingCartProductTableViewCell.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class ShoppingCartProductTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var totalQuantityLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var separatorLineView: UIView! {
        didSet {
            self.separatorLineView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        }
    }
    
    // MARK:- Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Methods
    func setupCell(purveyorProduct: PurveyorProduct) {
        self.productNameLabel.text = purveyorProduct.product.name
        self.totalQuantityLabel.text = "\(purveyorProduct.quantity)\(purveyorProduct.unit.rawValue)"

        self.totalPriceLabel.text = PriceUtils.getFormattedPrice(purveyorProduct.price)
    }
}

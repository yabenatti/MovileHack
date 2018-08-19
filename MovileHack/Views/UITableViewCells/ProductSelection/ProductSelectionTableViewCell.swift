//
//  ProductSelectionTableViewCell.swift
//  MovileHack
//
//  Created by Movile Hack on 18/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class ProductSelectionTableViewCell: UITableViewCell {
    enum ProductOptionType {
        case Featured
        case Fastest
        case Cheapest
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var optionTypeImageView: UIImageView! {
        didSet {
            self.optionTypeImageView.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var productPurveyorInfoLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel! {
        didSet {
            self.productPriceLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        }
    }
    @IBOutlet weak var selectedImageView: UIImageView! {
        didSet {
            self.selectedImageView.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var separatorLineView: UIView! {
        didSet {
            self.separatorLineView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
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
    
    func setup(type: ProductOptionType, purveyorProduct: PurveyorProduct, isSelected: Bool) {
        switch type {
        case .Featured:
            self.optionTypeImageView.image = UIImage(named: "featured")
        case .Fastest:
            self.optionTypeImageView.image = UIImage(named: "fastest")
        case .Cheapest:
            self.optionTypeImageView.image = UIImage(named: "cheapest")
        }

        self.productPurveyorInfoLabel.text = purveyorProduct.purveyor.name
        let purveyorInfoString = "\(purveyorProduct.purveyor.name) - \(purveyorProduct.deliveryTime)hrs"
        let purveyorInfoAttributedString = NSMutableAttributedString(string: purveyorInfoString)
        purveyorInfoAttributedString.addAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17, weight: .bold)], range: NSRange.init(location: 0, length: purveyorProduct.purveyor.name.count))
        purveyorInfoAttributedString.addAttributes([NSAttributedStringKey.font : UIFont.italicSystemFont(ofSize: 15)], range: NSRange(location: purveyorProduct.purveyor.name.count, length: purveyorInfoString.count - purveyorProduct.purveyor.name.count))
        self.productPurveyorInfoLabel.attributedText = purveyorInfoAttributedString
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "pt_br")
        let price = currencyFormatter.string(from: NSNumber(floatLiteral: purveyorProduct.price)) ?? ""
        self.productPriceLabel.text = price

        if isSelected {
            self.selectedImageView.image = UIImage(named: "checkmark")
        } else {
            self.selectedImageView.image = nil
        }
    }
}

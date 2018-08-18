//
//  ProductSelectionTableViewCell.swift
//  MovileHack
//
//  Created by Movile Hack on 18/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class ProductSelectionTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var productInfoLabel: UILabel!
    
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(text: String, isSelected: Bool) {
        self.productInfoLabel.text = "\(text) \(isSelected)"
    }
}

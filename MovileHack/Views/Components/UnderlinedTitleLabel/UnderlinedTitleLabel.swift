//
//  UnderlinedTitleLabel.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-19.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class UnderlinedTitleLabel : BaseView {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            self.titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        }
    }
    @IBOutlet weak var iconImageView: UIImageView! {
        didSet {
            self.iconImageView.tintColor = UIColor.movileBlue
        }
    }
    @IBOutlet weak var infoLabel: UILabel! {
        didSet {
            self.infoLabel.textColor = UIColor.movileBlue
            self.infoLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        }
    }
    @IBOutlet weak var separatorView: UIView!
    
    // MARK: - Setup
    func populateWith(title: String, info: String, icon: UIImage?) {
        self.titleLabel.text = title
        self.infoLabel.text = info
        self.iconImageView.image = icon
    }
}

//
//  CreateCardView.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-19.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

protocol CreateCardViewDelegate : class {
    func didTapCreateCardButton()
}

class CreateCardView: BaseView {
    
    // MARK: - Variables
    weak var delegate: CreateCardViewDelegate?
    
    // MARK: - IBOutlets
    @IBOutlet weak var createCardImageView: UIImageView! {
        didSet {
            self.createCardImageView.layer.cornerRadius = 10
            self.createCardImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var createCardTitleLabel: UILabel! {
        didSet {
            self.createCardTitleLabel.layer.shadowColor = UIColor.black.cgColor
            self.createCardTitleLabel.layer.shadowRadius = 3.0
            self.createCardTitleLabel.layer.shadowOpacity = 1.0
            self.createCardTitleLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        }
    }
    @IBOutlet weak var createCardInfoLabel: UILabel! {
        didSet {
            self.createCardInfoLabel.layer.shadowColor = UIColor.black.cgColor
            self.createCardInfoLabel.layer.shadowRadius = 3.0
            self.createCardInfoLabel.layer.shadowOpacity = 1.0
            self.createCardInfoLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        }
    }
    @IBOutlet weak var createCardButton: CTAButton! {
        didSet {
            self.createCardButton.setTitle("Criar", for: .normal)
        }
    }
    
    // MARK: - IBActions
    @IBAction func didTapCreateCardButton(_ sender: Any) {
        self.delegate?.didTapCreateCardButton()
    }
    
    // MARK: - Setup
    func populateViewWith(title: String, info: String, buttonTitle: String, image: UIImage?) {
        self.createCardTitleLabel.text = title
        self.createCardInfoLabel.text = info
        self.createCardButton.setTitle(buttonTitle.capitalized, for: .normal)
        self.createCardImageView.image = image
    }
}

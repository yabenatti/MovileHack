//
//  ShoppingCartTableHeaderView.swift
//  MovileHack
//
//  Created by Movile Hack on 19/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class ShoppingCartTableHeaderView: BaseView {
    // MARK: - IBOutlets
    @IBOutlet weak var purveyorNameLabel: UILabel! {
        didSet {
            self.purveyorNameLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        }
    }

    // MARK: - Methods
    func setup(purveyor: Purveyor) {
        self.purveyorNameLabel.text = purveyor.name
    }
}

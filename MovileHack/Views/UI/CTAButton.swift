//
//  CTAButton.swift
//  MovileHack
//
//  Created by Movile Hack on 18/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class CTAButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupButton()
    }
    
    private func setupButton() {
        self.backgroundColor = UIColor.movilePink
        self.layer.cornerRadius = 6.0
        self.tintColor = UIColor.white
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
}

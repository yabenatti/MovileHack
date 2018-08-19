//
//  RegisterMealViewController.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class RegisterMealViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var createMealImageView: UIImageView! {
        didSet {
            self.createMealImageView.layer.cornerRadius = 10
            self.createMealImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var createMealTitleLabel: UILabel! {
        didSet {
            createMealTitleLabel.layer.shadowColor = UIColor.black.cgColor
            createMealTitleLabel.layer.shadowRadius = 3.0
            createMealTitleLabel.layer.shadowOpacity = 1.0
            createMealTitleLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        }
    }
    @IBOutlet weak var createMealDescriptionLabel: UILabel! {
        didSet {
            createMealDescriptionLabel.layer.shadowColor = UIColor.black.cgColor
            createMealDescriptionLabel.layer.shadowRadius = 3.0
            createMealDescriptionLabel.layer.shadowOpacity = 1.0
            createMealDescriptionLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        }
    }
    @IBOutlet weak var createMealButton: CTAButton! {
        didSet {
            self.createMealButton.setTitle("Criar", for: .normal)
        }
    }
    

    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Criar"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

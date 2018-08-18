//
//  MealQuantityViewController.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class MealQuantityViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var mealImageView: UIImageView! {
        didSet {
            self.mealImageView.image = UIImage(named: "meal_default")
            self.mealImageView.layer.cornerRadius = self.mealImageView.frame.size.height/2
            self.mealImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var mealProductsAndQuantityLabel: UILabel!
    @IBOutlet weak var mealQuantityTitleLabel: UILabel! {
        didSet {
            mealQuantityTitleLabel.text = "QTD:"
        }
    }
    @IBOutlet weak var mealQuantityLabel: UILabel! {
        didSet {
            mealQuantityLabel.text = "0"
        }
    }
    @IBOutlet weak var mealQuantityStepper: UIStepper!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            self.nextButton.setTitle("Próximo", for: .normal)
        }
    }
    
    // MARK: - Variables
    var meal: Meal?
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let meal = self.meal {
            self.title = meal.name
            self.populateView(meal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Layout
    func populateView(_ meal: Meal) {
        //Photo
        if let imageUrl = meal.imageUrl {
            ImageUtils.downloadImage(urlString: imageUrl) { (image) in
                if let image = image {
                    self.mealImageView.image = image
                }
            }
        }
        
        //Meal Products and Quantity
        var mealProductsAndQuantityLabelString = ""
        for product in meal.products {
            mealProductsAndQuantityLabelString.append(product.name + "\n")
        }
        self.mealProductsAndQuantityLabel.text = mealProductsAndQuantityLabelString
        self.mealProductsAndQuantityLabel.setNeedsLayout()
        self.mealProductsAndQuantityLabel.layoutIfNeeded()
    }
    
    // MARK: - IBActions
    
    @IBAction func didTapNextButton(_ sender: Any) {
        guard let meal = self.meal else {
            return
        }
        
        let storyboard = UIStoryboard(name: .ProductSelection)
        if let vc = storyboard.instantiateViewController(withIdentifier: ViewControllerName.ProductSelectionViewController) as? ProductSelectionViewController {
            vc.products = meal.products
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func didTapStepperButton(_ sender: Any) {
        if let stepper = sender as? UIStepper {
            self.mealQuantityLabel.text = Int(stepper.value).description
        }
    }
    
}

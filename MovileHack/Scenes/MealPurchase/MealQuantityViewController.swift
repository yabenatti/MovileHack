//
//  MealQuantityViewController.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class MealQuantityViewController: BaseViewController {
    
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
    @IBOutlet weak var mealQuantityStepper: UIStepper! {
        didSet {
            self.mealQuantityStepper.tintColor = UIColor.movilePink
        }
    }
    @IBOutlet weak var nextButton: CTAButton! {
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(mealImageDownloaded(notification:)), name: .MealImageDownloaded, object: nil)
    }
    
    // MARK: - Layout
    func populateView(_ meal: Meal) {
        //Photo
        if let mealImage = meal.image {
            self.mealImageView.image = mealImage
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
    
    // MARK: - Notifications
    @objc func mealImageDownloaded(notification: Notification) {
        guard let meal = self.meal else {
            return
        }
        self.populateView(meal)
    }
}

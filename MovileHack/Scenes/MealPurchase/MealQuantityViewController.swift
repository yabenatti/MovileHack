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
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealProductsAndQuantityLabel: UILabel!
    @IBOutlet weak var mealQuantityLabel: UILabel! {
        didSet {
            mealQuantityLabel.text = "QTD:"
        }
    }
    @IBOutlet weak var mealQuantityStepper: UIStepper!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.setTitle("Próximo", for: .normal)
        }
    }
    
    // MARK: - Variables
    var meal: Meal?
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let meal = self.meal {
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
        if let photoUrl = meal.photoUrl {
            ImageUtils.downloadImage(urlString: photoUrl) { (image) in
                if let image = image {
                    self.mealImageView.image = image
                }
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func didTapNextButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: .ProductSelection)
        if let vc = storyboard.instantiateViewController(withIdentifier: ViewControllerName.ProductSelectionViewController) as? ProductSelectionViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

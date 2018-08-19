//
//  MealQuantityViewController.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

protocol MealQuantityViewControllerDelegate : class {
    func selectedMealQuantity(meal: Meal, quantity: Int)
}

class MealQuantityViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var contentView: UIView! {
        didSet {
            self.contentView.layer.cornerRadius = 10
            self.contentView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var mealImageView: UIImageView! {
        didSet {
            self.mealImageView.image = UIImage(named: "meal_default")
            self.mealImageView.layer.cornerRadius = self.mealImageView.frame.size.height/2
            self.mealImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var compositionLabel: UILabel!
    @IBOutlet weak var productsTableView: UITableView! {
        didSet {
            self.productsTableView.dataSource = self
            self.productsTableView.separatorStyle = .none
            
            self.productsTableView.register(IngredientsTableViewCell.self, forCellReuseIdentifier: String(describing: IngredientsTableViewCell.self))
            self.productsTableView.register(UINib(nibName: String(describing: IngredientsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: IngredientsTableViewCell.self))
        }
    }
    @IBOutlet weak var totalItemsLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var mealQuantityTitleLabel: UILabel! {
        didSet {
            mealQuantityTitleLabel.text = "Quantidade:"
        }
    }
    @IBOutlet weak var mealQuantityLabel: UILabel! {
        didSet {
            mealQuantityLabel.text = "1"
        }
    }
    @IBOutlet weak var mealQuantityStepper: UIStepper! {
        didSet {
            self.mealQuantityStepper.tintColor = UIColor.movilePink
            self.mealQuantityStepper.minimumValue = 1
        }
    }
    @IBOutlet weak var nextButton: CTAButton! {
        didSet {
            self.nextButton.setTitle("Confirmar", for: .normal)
        }
    }
    
    // MARK: - Variables
    weak var delegate: MealQuantityViewControllerDelegate?
    var meal: Meal?
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let meal = self.meal {
            self.title = meal.name
            self.populateView(meal)
            self.productsTableView.reloadData()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(mealImageDownloaded(notification:)), name: .MealImageDownloaded, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Layout
    func populateView(_ meal: Meal) {
        //Photo
        if let mealImage = meal.image {
            self.mealImageView.image = mealImage
        }
        
        self.compositionLabel.text = meal.name
        self.totalItemsLabel.text = "Total: \(meal.products.count) itens"
    }
    
    // MARK: - IBActions
    @IBAction func didTapNextButton(_ sender: Any) {
        guard let meal = self.meal else {
            return
        }
        
        self.dismiss(animated: true) {
            self.delegate?.selectedMealQuantity(meal: meal, quantity: Int(self.mealQuantityStepper.value))
        }
    }
    
    @IBAction func didTapStepperButton(_ sender: Any) {
        if let stepper = sender as? UIStepper {
            self.mealQuantityLabel.text = Int(stepper.value).description
        }
    }
    
    @IBAction func didTapOutsideView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Notifications
    @objc func mealImageDownloaded(notification: Notification) {
        guard let meal = self.meal else {
            return
        }
        self.populateView(meal)
    }
}

extension MealQuantityViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let meal = self.meal {
            return meal.products.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: IngredientsTableViewCell.self), for: indexPath) as? IngredientsTableViewCell,
            let meal = self.meal else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.populateWithProduct(meal.products[indexPath.row])
        
        return cell
    }
}

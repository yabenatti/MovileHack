//
//  MyMealsViewController.swift
//  MovileHack
//
//  Created by Movile Hack on 18/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class MyMealsViewController: BaseViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var myMealsTableView: UITableView! {
        didSet {
            self.myMealsTableView.delegate = self
            self.myMealsTableView.dataSource = self
            self.myMealsTableView.estimatedRowHeight = 50.0
            self.myMealsTableView.rowHeight = UITableViewAutomaticDimension
            
            self.myMealsTableView.separatorStyle = .none
            
            self.myMealsTableView.register(MyMealsTableViewCell.self, forCellReuseIdentifier: String(describing: MyMealsTableViewCell.self))
            self.myMealsTableView.register(UINib(nibName: String(describing: MyMealsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MyMealsTableViewCell.self))
        }
    }
    @IBOutlet weak var selectPricesButton: CTAButton! {
        didSet {
            self.selectPricesButton.setTitle("Escolher Preços", for: .normal)
        }
    }
    
    // MARK: - Constraints
    @IBOutlet weak var selectPricesButtonTopConstraint: NSLayoutConstraint! {
        didSet {
            self.originalSelectPricesButtonTopConstraintConstant = self.selectPricesButtonTopConstraint.constant
        }
    }
    @IBOutlet weak var selectPricesButtonBottomConstraint: NSLayoutConstraint! {
        didSet {
            self.originalSelectPricesButtonBottomConstraintConstant = self.selectPricesButtonBottomConstraint.constant
        }
    }
    @IBOutlet weak var selectPricesButtonHeightConstraint: NSLayoutConstraint! {
        didSet {
            self.originalSelectPricesButtonHeightConstraintConstant = self.selectPricesButtonHeightConstraint.constant
        }
    }

    // MARK: - Variables
    //Used to store initial constraints constants
    private var originalSelectPricesButtonTopConstraintConstant: CGFloat = 0.0
    private var originalSelectPricesButtonBottomConstraintConstant: CGFloat = 0.0
    private var originalSelectPricesButtonHeightConstraintConstant: CGFloat = 0.0
    
    private var meals = [Meal]() {
        didSet {
            self.myMealsTableView.reloadData()
        }
    }
    // Meal ID : Selected quantity
    private var selectedMeals = [Meal : UInt]()
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Meus Pratos"
        
        FacadeService.getAllUserMeals { (meals) in
            if let meals = meals {
                self.meals = meals
            }
        }
     
        self.hideSelectPricesButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(mealImageDownloaded(notification:)), name: .MealImageDownloaded, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.tabBarController?.tabBar.isHidden = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .MealImageDownloaded, object: nil)
    }
    
    // MARK: - Notifications
    @objc func mealImageDownloaded(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String : Any], let mealId = userInfo[NotificationCenterKeys.MealId] as? String, let index = self.meals.index(where: { (meal) -> Bool in return meal.id == mealId }) else {
            return
        }
        
        self.myMealsTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
    }
    
    // MARK: - IBActions
    @IBAction func didTapSelectPricesButton(_ sender: Any) {
        if let productSelectionViewController = UIStoryboard(name: .ProductSelection).instantiateViewController(withIdentifier: ViewControllerName.ProductSelectionViewController) as? ProductSelectionViewController {
            var products = [Product]()
            for (meal, _) in self.selectedMeals {
                for product in meal.products {
//                    if !products.contains(product) {
//                        products.append(product)
//                    }
                }
            }
            productSelectionViewController.products = products
            self.navigationController?.pushViewController(productSelectionViewController, animated: true)
        }
    }
    
    // MARK: - Layout
    private func showSelectPricesButton() {
        self.selectPricesButtonTopConstraint.constant = self.originalSelectPricesButtonTopConstraintConstant
        self.selectPricesButtonBottomConstraint.constant = self.originalSelectPricesButtonBottomConstraintConstant
        self.selectPricesButtonHeightConstraint.constant = self.originalSelectPricesButtonHeightConstraintConstant
    }
    
    private func hideSelectPricesButton() {
        self.selectPricesButtonTopConstraint.constant = 0.0
        self.selectPricesButtonBottomConstraint.constant = 0.0
        self.selectPricesButtonHeightConstraint.constant = 0.0
    }
}

// MARK: - UITableViewDelegate
extension MyMealsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: .MealQuantity).instantiateViewController(withIdentifier: ViewControllerName.MealQuantityViewController) as? MealQuantityViewController {
            vc.meal = self.meals[indexPath.row]
            vc.delegate = self
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDataSource
extension MyMealsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MyMealsTableViewCell.self), for: indexPath) as? MyMealsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setup(meal: self.meals[indexPath.row])
        
        return cell
    }
}

// MARK: - MealQuantityViewControllerDelegate
extension MyMealsViewController : MealQuantityViewControllerDelegate {
    func selectedMealQuantity(meal: Meal, quantity: UInt) {
//        var products = [Product : UInt]()
//        for product in meal.products {
//            products[product] = UInt(quantity)
//        }
//        Cart.getSharedInstance().addProducts(products)

        if let mealQuantity = self.selectedMeals[meal] {
            self.selectedMeals[meal] = quantity + mealQuantity
        } else {
            self.selectedMeals[meal] = quantity
        }
        
        if self.selectedMeals.count > 0 {
            self.showSelectPricesButton()
        }
    }
}


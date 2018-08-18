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
            
            self.myMealsTableView.register(MyMealsTableViewCell.self, forCellReuseIdentifier: String(describing: MyMealsTableViewCell.self))
            self.myMealsTableView.register(UINib(nibName: String(describing: MyMealsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MyMealsTableViewCell.self))
        }
    }

    // MARK: - Variables
    private var meals = [Meal]() {
        didSet {
            self.myMealsTableView.reloadData()
        }
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Meus Pratos"
        
        let meal = Meal(id: "123123123", name: "Salada de Frutas", imageUrl: nil)
        meal.products = [Product(id: "123812", name: "Banana", expirationDate: Date(), photoUrl: nil), Product(id: "19028312", name: "Maça", expirationDate: Date(), photoUrl: nil), Product(id: "124721498217", name: "Goiaba", expirationDate: Date(), photoUrl: nil)]
        self.meals.append(meal)
    }
}

extension MyMealsViewController : UITableViewDelegate {
    
}

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let mealQuantityViewController = UIStoryboard(name: .MealQuantity).instantiateViewController(withIdentifier: ViewControllerName.MealQuantityViewController) as? MealQuantityViewController {
            mealQuantityViewController.meal = self.meals[indexPath.row]
            self.navigationController?.pushViewController(mealQuantityViewController, animated: true)
        }
    }
}

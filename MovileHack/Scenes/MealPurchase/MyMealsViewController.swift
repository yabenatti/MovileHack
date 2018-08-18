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
        
        let meal = Meal(id: "123123123", name: "Salada de Frutas", imageUrl: "https://www.nossopomar.com.br/wp-content/uploads/2017/12/nosso-pomar-salada-frutas-sacolao-virtual-bh-hortifruti.jpg")
        meal.products = [Product(id: "123812", name: "Banana", expirationDate: Date(), imageUrl: "http://static1.conquistesuavida.com.br/ingredients/5/54/26/75/@/24677--ingredient_detail_ingredient-2.png"),
                         Product(id: "19028312", name: "Maça", expirationDate: Date(), imageUrl: "https://superprix.vteximg.com.br/arquivos/ids/175207-600-600/Maca-Argentina--1-unidade-aprox.-200g-.png?v=636294203590200000"),
                         Product(id: "124721498217", name: "Goiaba", expirationDate: Date(), imageUrl: nil)]
        self.meals.append(meal)
        
        NotificationCenter.default.addObserver(self, selector: #selector(mealImageDownloaded(notification:)), name: .MealImageDownloaded, object: nil)
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

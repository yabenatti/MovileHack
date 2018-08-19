//
//  ProductSelectionViewController.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class ProductOption {
    let id: String
    let purveyorName: String
    let deliveryTime: Double
    let price: Double
    
    init(id: String, purveyorName: String, deliveryTime: Double, price: Double) {
        self.id = id
        self.purveyorName = purveyorName
        self.deliveryTime = deliveryTime
        self.price = price
    }
}

class ProductSelectionSection {
    let mealProduct: MealProduct
    var purveyorProducts: [PurveyorProduct]
    
    init(product: MealProduct, purveyorProducts: [PurveyorProduct]) {
        self.mealProduct = product
        self.purveyorProducts = purveyorProducts
    }
}

protocol ProductSelectionViewControllerDelegate: class {
    func didAddProducts()
}

class ProductSelectionViewController: BaseViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var productsTableView: UITableView! {
        didSet {
            self.productsTableView.delegate = self
            self.productsTableView.dataSource = self
            self.productsTableView.estimatedRowHeight = 50
            self.productsTableView.rowHeight = UITableViewAutomaticDimension
            
            self.productsTableView.separatorStyle = .none
            
            self.productsTableView.register(ProductSelectionTableViewCell.self, forCellReuseIdentifier: String(describing: ProductSelectionTableViewCell.self))
            self.productsTableView.register(UINib(nibName: String(describing: ProductSelectionTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ProductSelectionTableViewCell.self))
        }
    }
    @IBOutlet weak var addButton: CTAButton! {
        didSet {
            self.addButton.setTitle("Adicionar ao Carrinho", for: .normal)
            self.addButton.isEnabled = false
        }
    }
    
    // MARK: - Variables
    weak var delegate: ProductSelectionViewControllerDelegate?
    
    var products = [MealProduct]()
    private var productSelectionSections = [ProductSelectionSection]() {
        didSet {
            self.productsTableView.reloadData()
        }
    }
    private var selectedProductOptions = [Product : PurveyorProduct]() {
        didSet {
            if self.selectedProductOptions.count == self.productSelectionSections.count {
                self.addButton.isEnabled = true
            } else {
                self.addButton.isEnabled = false
            }
        }
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Produtos e Fornecedores"

        var productSelectionSections = [ProductSelectionSection]()
        let dispatchGroup = DispatchGroup()
        for mealProduct in self.products {
            dispatchGroup.enter()
            FacadeService.getTopPurveyorProducts(mealProduct: mealProduct) { (purveyorProducts) in
                if let purveyorProducts = purveyorProducts {
                    productSelectionSections.append(ProductSelectionSection(product: mealProduct, purveyorProducts: purveyorProducts))
                }
                dispatchGroup.leave()
            }
        }
        
        self.showLoadingView(isLarge: false)
        dispatchGroup.notify(queue: .main) {
            self.productSelectionSections = productSelectionSections
            self.hideLoadingView()
        }
    }
    
    // MARK: - IBActions
    @IBAction func didTapAddButton(_ sender: Any) {
        Cart.getSharedInstance().addProducts(Array(self.selectedProductOptions.values))
        
        let alertViewController = UIAlertController(title: "Parabéns", message: "Produtos adicionados ao carrinho", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        alertViewController.addAction(okAction)
        
        self.present(alertViewController, animated: true, completion: nil)
        
        self.delegate?.didAddProducts()
    }
    
    // MARK: - Methods
    func getProductsFrom(meals: [Meal : UInt]) {
        var mealProducts = [MealProduct]()
        //Get all products with quantities to group duplicates
        for (meal, quantity) in meals {
            for mealProduct in meal.products {
                if let index = mealProducts.index(where: { (mProduct) -> Bool in return mProduct.product == mealProduct.product }) {
                    let mProduct = mealProducts[index]
                    mealProducts[index] = MealProduct(product: mProduct.product, quantity: mProduct.quantity + mealProduct.quantity * Double(quantity), unit: mealProduct.unit)
                } else {
                    mealProducts.append(MealProduct(product: mealProduct.product, quantity: mealProduct.quantity * Double(quantity), unit: mealProduct.unit))
                }
            }
        }
        self.products = mealProducts
    }
}

// MARK: - UITableViewDelegate
extension ProductSelectionViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ProductSelectionSectionHeaderView()
        header.setup(mealProduct: self.productSelectionSections[section].mealProduct)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = self.productSelectionSections[indexPath.section].mealProduct.product
        let purveyorProduct = self.productSelectionSections[indexPath.section].purveyorProducts[indexPath.row]
        
        var previousSelectedRow: Int? = nil
        
        //Find previously selected option for this product and reload it if needed
        if let auxPurveyorProduct = self.selectedProductOptions[product] {
            if purveyorProduct == auxPurveyorProduct {
                self.selectedProductOptions.removeValue(forKey: product)
            } else {
                self.selectedProductOptions[product] = purveyorProduct
                if let index = self.productSelectionSections[indexPath.section].purveyorProducts.index(of: auxPurveyorProduct) {
                    previousSelectedRow = index
                }
            }
        } else {
            self.selectedProductOptions[product] = purveyorProduct
        }
        var indexPaths = [indexPath]
        if let previousSelectedRow = previousSelectedRow {
            indexPaths.append(IndexPath(row: previousSelectedRow, section: indexPath.section))
        }
        self.productsTableView.reloadRows(at: indexPaths, with: .none)
    }
}

// MARK: - UITableViewDataSource
extension ProductSelectionViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.productSelectionSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productSelectionSections[section].purveyorProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductSelectionTableViewCell.self), for: indexPath) as? ProductSelectionTableViewCell else {
            return UITableViewCell()
        }
        let product = self.productSelectionSections[indexPath.section].mealProduct.product
        let purveyorProduct = self.productSelectionSections[indexPath.section].purveyorProducts[indexPath.row]

        let isSelected: Bool
        //Check if Product option is selected
        if let selectedPurveyorProduct = self.selectedProductOptions[product], selectedPurveyorProduct == purveyorProduct {
            isSelected = true
        } else {
            isSelected = false
        }
        let optionType: ProductSelectionTableViewCell.ProductOptionType
        if indexPath.row == 0 {
            optionType = .Featured
        } else if indexPath.row == 1 {
            optionType = .Fastest
        } else {
            optionType = .Cheapest
        }
        cell.setup(type: optionType, purveyorProduct: purveyorProduct, isSelected: isSelected)
        
        return cell
    }
}

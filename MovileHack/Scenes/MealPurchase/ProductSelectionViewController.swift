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
    let product: Product
    var productOptions: [ProductOption]
    
    init(product: Product, productOptions: [ProductOption]) {
        self.product = product
        self.productOptions = productOptions
    }
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
    var products = [Product]()
    private var productSelectionSections = [ProductSelectionSection]() {
        didSet {
            self.productsTableView.reloadData()
        }
    }
    private var selectedProductOptions = [Product : String]() {
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

        for product in products {
            let productOptions = [ProductOption(id: "\(arc4random())", purveyorName: "ACME", deliveryTime: 5.0, price: 10.0),
                                  ProductOption(id: "\(arc4random())", purveyorName: "Rocket", deliveryTime: 2.5, price: 15.0),
                                  ProductOption(id: "\(arc4random())", purveyorName: "Caffeine", deliveryTime: 7.0, price: 7.50)]
            self.productSelectionSections.append(ProductSelectionSection(product: product, productOptions: productOptions))
        }
    }
    
    // MARK: - IBActions
    @IBAction func didTapAddButton(_ sender: Any) {
        
        
        let alertViewController = UIAlertController(title: "Parabéns", message: "Produtos adicionados ao carrinho", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        alertViewController.addAction(okAction)
        
        self.present(alertViewController, animated: true, completion: nil)
    }
}

extension ProductSelectionViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ProductSelectionSectionHeaderView()
        header.setup(product: self.productSelectionSections[section].product)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = self.productSelectionSections[indexPath.section].product
        let option = self.productSelectionSections[indexPath.section].productOptions[indexPath.row]
        
        var previousSelectedRow: Int? = nil
        
        //Find previously selected option for this product and reload it if needed
        if let optionId = self.selectedProductOptions[product] {
            if optionId == option.id {
                self.selectedProductOptions.removeValue(forKey: product)
            } else {
                self.selectedProductOptions[product] = option.id
                if let index = self.productSelectionSections[indexPath.section].productOptions.index(where: { (productOption) -> Bool in return productOption.id == optionId }) {
                    previousSelectedRow = index
                }
            }
        } else {
            self.selectedProductOptions[product] = option.id
        }
        var indexPaths = [indexPath]
        if let previousSelectedRow = previousSelectedRow {
            indexPaths.append(IndexPath(row: previousSelectedRow, section: indexPath.section))
        }
        self.productsTableView.reloadRows(at: indexPaths, with: .none)
    }
}

extension ProductSelectionViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.productSelectionSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productSelectionSections[section].productOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductSelectionTableViewCell.self), for: indexPath) as? ProductSelectionTableViewCell else {
            return UITableViewCell()
        }
        let product = self.productSelectionSections[indexPath.section].product
        let option = self.productSelectionSections[indexPath.section].productOptions[indexPath.row]

        let isSelected: Bool
        //Check if Product option is selected
        if let selectedProductOption = self.selectedProductOptions[product], selectedProductOption == option.id {
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
        cell.setup(type: optionType, productOption: option, isSelected: isSelected)
        
        return cell
    }
}

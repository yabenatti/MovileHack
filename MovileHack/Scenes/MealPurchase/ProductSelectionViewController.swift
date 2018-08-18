//
//  ProductSelectionViewController.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class ProductSelectionViewController: BaseViewController {
    //FIXME: Implement proper productOptions
    private class ProductOption {
        let id: String
        let price: Double
        
        init(id: String, price: Double) {
            self.id = id
            self.price = price
        }
    }
    
    private class ProductSelectionSection {
        let product: Product
        var productOptions: [ProductOption]
        
        init(product: Product, productOptions: [ProductOption]) {
            self.product = product
            self.productOptions = productOptions
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var productsTableView: UITableView! {
        didSet {
            self.productsTableView.delegate = self
            self.productsTableView.dataSource = self
            
            self.productsTableView.register(ProductSelectionTableViewCell.self, forCellReuseIdentifier: String(describing: ProductSelectionTableViewCell.self))
            self.productsTableView.register(UINib(nibName: String(describing: ProductSelectionTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ProductSelectionTableViewCell.self))
        }
    }
    @IBOutlet weak var addButton: CTAButton! {
        didSet {
            self.addButton.setTitle("Adicionar", for: .normal)
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
    private var selectedProductOptions = [String : String]() {
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

        for product in products {
            self.productSelectionSections.append(ProductSelectionSection(product: product, productOptions: [ProductOption(id: "12893712", price: 10.0), ProductOption(id: "1237813712124", price: 15.0), ProductOption(id: "17826387126", price: 7.50)]))
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
        
        //Find previously selected option for this product
        if let _ = self.selectedProductOptions[product.id] {
            self.selectedProductOptions[product.id] = option.id
        } else {
            self.selectedProductOptions[product.id] = option.id
        }
        self.productsTableView.reloadSections([indexPath.section], with: .none)
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
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let price = currencyFormatter.string(from: NSNumber(floatLiteral: option.price)) ?? ""
        let isSelected: Bool
        //Check if Product option is selected
        if let selectedProductOption = self.selectedProductOptions[product.id], selectedProductOption == option.id {
            isSelected = true
        } else {
            isSelected = false
        }
        cell.setup(text: price, isSelected: isSelected)
        
        return cell
    }
}

//
//  ProductSelectionViewController.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class ProductSelectionViewController: UIViewController {
    class ProductSelectionSection {
        let product: Product
        //FIXME: Implement proper productOptions
        var productOptions: [String]
        
        init(product: Product, productOptions: [String]) {
            self.product = product
            self.productOptions = productOptions
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var productsTableView: UITableView! {
        didSet {
            self.productsTableView.delegate = self
            self.productsTableView.dataSource = self
        }
    }
    @IBOutlet weak var addButton: CTAButton!
    
    // MARK: - Variables
    var productSelectionSections = [ProductSelectionSection]() {
        didSet {
            self.productsTableView.reloadData()
        }
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}

extension ProductSelectionViewController : UITableViewDelegate {

}

extension ProductSelectionViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.productSelectionSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productSelectionSections[section].productOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

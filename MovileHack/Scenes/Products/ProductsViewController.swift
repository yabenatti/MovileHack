//
//  ProductsViewController.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class ProductsViewController: BaseViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            self.tableView.register(ProductSearchTableViewCell.self, forCellReuseIdentifier: String(describing: ProductSearchTableViewCell.self))
            self.tableView.register(UINib(nibName: String(describing: ProductSearchTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ProductSearchTableViewCell.self))
        }
    }
    
    // MARK: - Variables
    var products = [Product]()
    var filteredProducts = [Product]()
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - VC Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Insumos"
        
        // Setup the Search Controller
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Buscar"
        self.searchController.searchBar.searchBarStyle = .minimal
        self.searchController.searchBar.barTintColor = UIColor.white
        self.searchController.searchBar.delegate = self
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        NotificationCenter.default.addObserver(self, selector: #selector(productImageDownloaded(notification:)), name: .ProductImageDownloaded, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.showLoadingView(isLarge: false)
        FacadeService.getAllProducts { (products) in
            if let products = products {
                self.products = products
                self.filteredProducts = self.products
            }
            self.tableView.reloadData()
            self.hideLoadingView()
        }
    }
    
    // MARK: - Notifications
    @objc func productImageDownloaded(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String : Any], let productId = userInfo[NotificationCenterKeys.ProductId] as? String, let index = self.filteredProducts.index(where: { (product) -> Bool in return product.id == productId }) else {
            return
        }
        
        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
    }
}

extension ProductsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 79
    }
}

extension ProductsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductSearchTableViewCell.self), for: indexPath) as? ProductSearchTableViewCell else {
            return UITableViewCell()
        }
        
        cell.populateWithProduct(self.filteredProducts[indexPath.row])
        
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension ProductsViewController : UISearchBarDelegate {
    func clearSearch() {
        self.searchController.searchBar.text = ""
        self.searchController.searchBar.endEditing(true)
        self.searchController.isActive = false
    }
    
    func restartSearch() {
        self.clearSearch()
        self.filteredProducts.removeAll()
        self.filteredProducts = self.products
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {
            return
        }
        self.filterWithSearchTerm(searchTerm: searchTerm)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.restartSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchTerm = searchBar.text else {
            self.restartSearch()
            return
        }
        self.filterWithSearchTerm(searchTerm: searchTerm)
    }
    
    func filterWithSearchTerm(searchTerm: String) {
        self.filterProductsCompleteArrayWithTerm(searchTerm: searchTerm)
        self.tableView.reloadData()
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension ProductsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

// MARK: - Filter Methods
extension ProductsViewController {
    fileprivate func filterProductsCompleteArrayWithTerm(searchTerm :String) {
        self.filteredProducts = self.products.filter { product in
            let isMatchingSearchText = product.name.lowercased().folding(options: .diacriticInsensitive, locale: .current).contains(searchTerm.lowercased().folding(options: .diacriticInsensitive, locale: .current)) || searchTerm.lowercased().folding(options: .diacriticInsensitive, locale: .current).count == 0
            return isMatchingSearchText
        }
    }
}

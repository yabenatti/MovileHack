//
//  ShoppingCartViewController.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class ShoppingCartViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            
            self.tableView.register(ShoppingCartProductTableViewCell.self, forCellReuseIdentifier: String(describing: ShoppingCartProductTableViewCell.self))
            self.tableView.register(UINib(nibName: String(describing: ShoppingCartProductTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ShoppingCartProductTableViewCell.self))
        }
    }
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!

    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Carrinho"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - IBActions
    
    @IBAction func didTapPayButton(_ sender: Any) {
    }
    
}

extension ShoppingCartViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ShoppingCartProductTableViewCell.self), for: indexPath) as? ShoppingCartProductTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}

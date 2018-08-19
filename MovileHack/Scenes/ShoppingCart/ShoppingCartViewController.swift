//
//  ShoppingCartViewController.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

private class PurveyorProductSection {
    let purveyor: Purveyor
    let purveyorProducts: [PurveyorProduct]
    
    init(purveyor: Purveyor, purveyorProducts: [PurveyorProduct]) {
        self.purveyor = purveyor
        self.purveyorProducts = purveyorProducts
    }
}

class ShoppingCartViewController: BaseViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            self.tableView.estimatedRowHeight = 50.0
            self.tableView.rowHeight = UITableViewAutomaticDimension
            
            self.tableView.separatorStyle = .none
            
            self.tableView.register(ShoppingCartProductTableViewCell.self, forCellReuseIdentifier: String(describing: ShoppingCartProductTableViewCell.self))
            self.tableView.register(UINib(nibName: String(describing: ShoppingCartProductTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ShoppingCartProductTableViewCell.self))
        }
    }
    @IBOutlet weak var totalLabel: UILabel! {
        didSet {
            self.totalLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
            self.totalLabel.textColor = UIColor.white
            self.totalLabel.backgroundColor = UIColor.darkBlue
            self.totalLabel.layer.cornerRadius = 10.0
            self.totalLabel.clipsToBounds = true
        }
    }
    @IBOutlet weak var payButton: CTAButton! {
        didSet {
            self.payButton.setTitle("Finalizar a Compra", for: .normal)
        }
    }

    // MARK: - Variables
    private var purveyorProductSections = [PurveyorProductSection]() {
        didSet {
            var totalPrice = 0.0
            for purveyorProductSection in self.purveyorProductSections {
                for purveyorProduct in purveyorProductSection.purveyorProducts {
                    totalPrice += purveyorProduct.price
                }
            }
            self.totalLabel.text = "Total \n\(PriceUtils.getFormattedPrice(totalPrice))"
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Carrinho"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let productsByPurvoyer = Cart.getSharedInstance().getProductsByPurvoyer()
        var purveyorProductSections = [PurveyorProductSection]()
        for (purvoyer, purvoyerProducts) in productsByPurvoyer {
            purveyorProductSections.append(PurveyorProductSection(purveyor: purvoyer, purveyorProducts: purvoyerProducts))
        }
        self.purveyorProductSections = purveyorProductSections
    }

    // MARK: - IBActions
    @IBAction func didTapPayButton(_ sender: Any) {
        self.showLoadingView(isLarge: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            Cart.getSharedInstance().clear()
            self.purveyorProductSections.removeAll()
            self.hideLoadingView()
            
            self.tabBarController?.selectedIndex = 2
            
            let alertVc = UIAlertController(title: "Parabéns", message: "Sua compra foi finalizada com sucesso!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVc.addAction(okAction)
            
            self.present(alertVc, animated: true, completion: nil)
        }
    }
}

extension ShoppingCartViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ShoppingCartTableHeaderView()
        header.setup(purveyor: self.purveyorProductSections[section].purveyor)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48.0
    }
}

extension ShoppingCartViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.purveyorProductSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.purveyorProductSections[section].purveyorProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ShoppingCartProductTableViewCell.self), for: indexPath) as? ShoppingCartProductTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupCell(purveyorProduct: self.purveyorProductSections[indexPath.section].purveyorProducts[indexPath.row])
        
        return cell
    }
}

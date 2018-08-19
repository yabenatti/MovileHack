//
//  Cart.swift
//  MovileHack
//
//  Created by Movile Hack on 18/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

final class Cart {
    // MARK: - Singleton
    static private var sharedInstance: Cart?
    
    // MARK: - Variables
    private var purveyorProducts = [PurveyorProduct]()
    
    // MARK: - Singleton Methods
    static func getSharedInstance() -> Cart {
        guard let sharedInstance = self.sharedInstance else {
            let sharedInstance = Cart()
            self.sharedInstance = sharedInstance
            return sharedInstance
        }

        return sharedInstance
    }
    
    private init() {}
    
    // MARK: - Methods
    private func getNumberOfProducts() -> Int {
        var productDict = [Product : Bool]()
        for purveyorProduct in self.purveyorProducts {
            if productDict[purveyorProduct.product] == nil {
                productDict[purveyorProduct.product] = true
            }
        }
        return productDict.count
    }
    
    func clear() {
        self.purveyorProducts = []

        TabBarUtils.setCartTabbarNumber(self.getNumberOfProducts())
        
        NotificationCenter.default.post(name: .CartCleared, object: nil)
    }
    
    func addProducts(_ products: [PurveyorProduct]) {
        //Checks if product is from the same purvoyer
        //Add quantity and price if it is
        for purveyorProduct in products {
            let product = purveyorProduct.product
            if let index = self.purveyorProducts.index(where: { (purveyorProduct) -> Bool in return purveyorProduct.product == product }) {
                let pProuct = self.purveyorProducts[index]
                self.purveyorProducts[index] = PurveyorProduct(id: pProuct.id, product: pProuct.product, purveyor: pProuct.purveyor, quantity: pProuct.quantity + purveyorProduct.quantity, unit: pProuct.unit, price: pProuct.price + purveyorProduct.price, deliveryTime: pProuct.deliveryTime)
            } else {
                self.purveyorProducts.append(purveyorProduct)
            }
        }
        
        TabBarUtils.setCartTabbarNumber(self.getNumberOfProducts())
    }
    
    func getProductsByPurvoyer() -> [Purveyor : [PurveyorProduct]] {
        var purvoyerDict = [Purveyor : [PurveyorProduct]]()
        
        for purveyorProduct in self.purveyorProducts {
            let purveyor = purveyorProduct.purveyor
            if purvoyerDict[purveyor] != nil {
                purvoyerDict[purveyor]?.append(purveyorProduct)
            } else {
                purvoyerDict[purveyor] = [purveyorProduct]
            }
        }
        
        return purvoyerDict
    }
}

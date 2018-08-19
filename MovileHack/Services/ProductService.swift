//
//  ProductService.swift
//  MovileHack
//
//  Created by Movile Hack on 19/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import Foundation

final class ProductService {
    class func getProductsFor(mealId: String, completion: @escaping ([Product]?) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(arc4random_uniform(1000)) / 1000.0) {
            var products = [Product]()
            if mealId == "1" {
                products.append(Product(id: "100", name: "Banana", expirationDate: Date(), imageUrl: "http://static1.conquistesuavida.com.br/ingredients/5/54/26/75/@/24677--ingredient_detail_ingredient-2.png"))
                products.append(Product(id: "101", name: "Maça", expirationDate: Date(), imageUrl: "https://superprix.vteximg.com.br/arquivos/ids/175207-600-600/Maca-Argentina--1-unidade-aprox.-200g-.png?v=636294203590200000"))
                products.append(Product(id: "102", name: "Laranja", expirationDate: Date(), imageUrl: nil))
            } else if mealId == "2" {
                products.append(Product(id: "103", name: "Frango", expirationDate: Date(), imageUrl: nil))
                products.append(Product(id: "104", name: "Massa", expirationDate: Date(), imageUrl: nil))
            }
            completion(products)
        }
    }
}

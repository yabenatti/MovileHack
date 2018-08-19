//
//  ProductService.swift
//  MovileHack
//
//  Created by Movile Hack on 19/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import Foundation

final class ProductService {
    class func getAllProducts(completion: @escaping ([Product]?) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(arc4random_uniform(1000)) / 1000.0) {
            var products = [Product]()
            
            products.append(Product(id: "100", name: "Banana", expirationDate: Date(), imageUrl: "https://www.naturalcura.com.br/wp-content/uploads/2018/02/beneficios-da-banana-1.jpg"))
            products.append(Product(id: "101", name: "Maçã", expirationDate: Date(), imageUrl: "https://superprix.vteximg.com.br/arquivos/ids/175207-600-600/Maca-Argentina--1-unidade-aprox.-200g-.png?v=636294203590200000"))
            products.append(Product(id: "102", name: "Laranja", expirationDate: Date(), imageUrl: "https://www.maisquitanda.com.br/image/cache/2-frutas/laranja-suco-800x800.jpg"))
            products.append(Product(id: "103", name: "Frango", expirationDate: Date(), imageUrl: "https://p2.trrsf.com/image/fget/cf/460/0/images.terra.com/2018/04/03/filc3a9-de-frango-perfeito.jpg"))
            products.append(Product(id: "104", name: "Massa", expirationDate: Date(), imageUrl: "https://img.stpu.com.br/?img=https://s3.amazonaws.com/pu-mgr/default/a0RG000000mr2pqMAA/56ddc132e4b08696b5ee5f3f.jpg&w=620&h=400"))
            
            completion(products)
        }
    }
    
    class func getProductsFor(mealId: String, completion: @escaping ([Product]?) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(arc4random_uniform(1000)) / 1000.0) {
            var products = [Product]()
            if mealId == "1" {
                products.append(Product(id: "100", name: "Banana", expirationDate: Date(), imageUrl: "https://www.naturalcura.com.br/wp-content/uploads/2018/02/beneficios-da-banana-1.jpg"))
                products.append(Product(id: "101", name: "Maçã", expirationDate: Date(), imageUrl: "https://superprix.vteximg.com.br/arquivos/ids/175207-600-600/Maca-Argentina--1-unidade-aprox.-200g-.png?v=636294203590200000"))
                products.append(Product(id: "102", name: "Laranja", expirationDate: Date(), imageUrl: "https://www.maisquitanda.com.br/image/cache/2-frutas/laranja-suco-800x800.jpg"))
            } else if mealId == "2" {
                products.append(Product(id: "103", name: "Frango", expirationDate: Date(), imageUrl: "https://p2.trrsf.com/image/fget/cf/460/0/images.terra.com/2018/04/03/filc3a9-de-frango-perfeito.jpg"))
                products.append(Product(id: "104", name: "Massa", expirationDate: Date(), imageUrl: "https://img.stpu.com.br/?img=https://s3.amazonaws.com/pu-mgr/default/a0RG000000mr2pqMAA/56ddc132e4b08696b5ee5f3f.jpg&w=620&h=400"))
            }
            completion(products)
        }
    }
}

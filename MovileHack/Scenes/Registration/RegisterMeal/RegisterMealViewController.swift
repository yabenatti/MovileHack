//
//  RegisterMealViewController.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class RegisterMealViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var createMealView: CreateCardView!
    @IBOutlet weak var createResaleView: CreateCardView!

    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Criar"
        
        self.createMealView.populateViewWith(title: "Criar Prato", info: "Sua única preocupação é colocar quais ingredientes que tem no seu prato, que da parte chata a gente cuida", buttonTitle: "Criar", image: UIImage(named: "create_meal"))
        self.createResaleView.populateViewWith(title: "Revender Material", info: "Sobrou material fechado? Que tal revender para algum parceiro da região?", buttonTitle: "Revender", image: UIImage(named: "resale_meal"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

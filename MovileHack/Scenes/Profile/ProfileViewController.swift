//
//  ProfileViewController.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-18.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit
import CoreLocation

class ProfileViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2
            self.profileImageView.layer.masksToBounds = true
            self.profileImageView.image = UIImage(named: "jessie_profile")
        }
    }
    @IBOutlet weak var userNameLabel: UILabel! {
        didSet {
            self.userNameLabel.font = UIFont.systemFont(ofSize: 26, weight: .regular)
        }
    }
    @IBOutlet weak var phoneNumberView: UnderlinedTitleLabel!
    @IBOutlet weak var addressView: UnderlinedTitleLabel!
    @IBOutlet weak var emailView: UnderlinedTitleLabel!
    
    // MARK: - Variables
    var restaurant: Restaurant?
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Profile"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showLoadingView(isLarge: true)
        FacadeService.getCurrentRestaurant { (restaurant) in
            self.hideLoadingView()
            self.restaurant = restaurant
            if let restaurant = self.restaurant {
                self.populateViewWithRestaurant(restaurant)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup
    func populateViewWithRestaurant(_ restaurant: Restaurant) {
        //Phone
        if let phone = restaurant.phoneNumber {
            self.phoneNumberView.populateWith(title: "Celular", info: phone, icon: UIImage(named: "phone_icon"))
        }

        //Address
        self.addressView.populateWith(title: "Endereço", info: "Avenida do Rato Molhado - 210 - Campinas, SP", icon:  UIImage(named: "location_icon"))
        
        //Email
        self.emailView.populateWith(title: "Email", info: "jessie@magalhaes.com", icon:  UIImage(named: "email_icon"))
    }
}

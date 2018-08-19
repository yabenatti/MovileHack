//
//  BaseViewController.swift
//  MovileHack
//
//  Created by Movile Hack on 18/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Variable
    private var loadingView = LoadingView()

    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initLoadingView()

        //Navigation Bar Back Button
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //Navigation Bar Shadow
        if let navigation = self.navigationController {
            navigation.navigationBar.shadowImage = UIImage()
            CALayer.setDropShadow(layer: navigation.navigationBar.layer, radius: 6, opacity: 0.45)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Loading View
    private func initLoadingView() {
        self.loadingView.constrainToView(view: self.view)
        self.hideLoadingView()
    }
    
    func showLoadingView(isLarge: Bool) {
        self.loadingView.showOnView(self.view, isLarge: isLarge)
    }
    
    func hideLoadingView() {
        self.loadingView.hide()
    }
}

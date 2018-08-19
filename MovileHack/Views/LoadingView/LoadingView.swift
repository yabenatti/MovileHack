//
//  LoadingView.swift
//  MovileHack
//
//  Created by Yasmin Benatti on 2018-08-19.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import UIKit

class LoadingView : BaseView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
        }
    }
    
    // MARK: - Initialization Methods
    func constrainToView(view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        view.layoutIfNeeded()
    }
    
    // MARK: - Activity Indicator
    private func startLoading() {
        self.activityIndicator.startAnimating()
    }
    
    private func stopLoading() {
        self.activityIndicator.stopAnimating()
    }
    
    // MARK: - Public Functions
    func showOnView(_ view :UIView, isLarge: Bool) {
        self.resizeLoadingView(view: view, isLarge: isLarge)
        view.bringSubview(toFront: self)
        self.isHidden = false
        self.startLoading()
    }
    
    func hide() {
        self.isHidden = true
        self.stopLoading()
    }
    
    func resizeLoadingView(view: UIView ,isLarge: Bool) {
        if isLarge {
            NSLayoutConstraint.activate([
                self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                self.topAnchor.constraint(equalTo: view.topAnchor, constant: -UIApplication.shared.statusBarFrame.size.height),
                self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: iOSUtils.isPhoneX() ? 34 : 0.0)
                ])
        } else {
            NSLayoutConstraint.activate([
                self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                self.topAnchor.constraint(equalTo: view.topAnchor),
                self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        }
    }
    
}



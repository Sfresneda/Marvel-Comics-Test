//
//  LoadingView.swift
//  Marvel
//
//  Created by Sergio Fresneda on 2/1/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

protocol LoadingViewProtocol {
    var loadingView: UIView { get set }
    func showLoadingView()
    func hideLoadingView()
}

struct LoadingView {
    static func instantiate(on superView: UIView) -> UIView {
        let baseView: UIView = UIView.init(frame: superView.frame)
        baseView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .large)
        activityIndicator.color = UIColor.white
        activityIndicator.startAnimating()
        baseView.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: baseView.centerYAnchor).isActive = true
        baseView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        return baseView
    }
}

extension LoadingViewProtocol where Self: UIViewController {
    func showLoadingView() {
        self.loadingView.alpha = 0
        var view: UIView = self.view
        if let navigationView = self.navigationController?.view {
            view = navigationView
        }
        view.addSubview(self.loadingView)
        
        self.loadingView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.loadingView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        self.loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView.alpha = 1
        })
    }
    func hideLoadingView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView.alpha = 0
        }, completion: { _ in
            self.loadingView.removeFromSuperview()
        })
    }
}

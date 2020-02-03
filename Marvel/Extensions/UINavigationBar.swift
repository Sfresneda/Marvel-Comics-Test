//
//  UINavigationBar.swift
//  Marvel
//
//  Created by Sergio Fresneda on 1/30/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

extension UINavigationController {
    func setHulkStyle(isDetail: Bool = false) {
        let dominantColor = isDetail ? UIColor.white : UIColor.greenHulk

        self.navigationBar.barStyle = .black
        self.navigationBar.shadowImage = UIImage.init()
        self.navigationBar.setBackgroundImage(UIImage.init(), for: .default)
        self.navigationBar.titleTextAttributes = [.foregroundColor: dominantColor,
                                                  .font: UIFont.boldSystemFont(ofSize: 30)
        ]
        self.navigationBar.tintColor = dominantColor
    }
}

//
//  Constants.swift
//  Marvel
//
//  Created by Sergio Fresneda on 1/30/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

let itemsPerRow: Int = 1

enum UseCases {
    case falseLaunchScreen
    case masterView
    case detailView
    
    var viewController: UIViewController {
        switch self {
        case .falseLaunchScreen:
            return FalseLaunchScreen.init()
        case .masterView:
            return MasterBuilder.build()
        case .detailView:
            return DetailViewController.init()
        }
    }
}


// MARK: - Network
let kBaseAPIPath: String = "gateway.marvel.com:443/v1/public/"
let kPublicKey: String = "249c52c1973c26e82064e4b750c35804"
let kPrivateKey: String = "28c07c22fec86842ebbd75d0bf18a3382fbddef6"

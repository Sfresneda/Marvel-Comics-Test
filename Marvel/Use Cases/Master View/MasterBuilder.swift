//
//  MasterBuilder.swift
//  Marvel
//
//  Created by Sergio Fresneda on 1/30/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

class MasterBuilder {
    static func build() -> UIViewController {
        let view = MasterView.init(nibName: "MasterView", bundle: nil)
        let interactor = MasterInteractor.init(network: ComicsNetworkService.init(networkManager: NetworkManager.shared),
                                               caching: NetworkCachingService.shared)
        let presenter = MasterPresenter.init()
        let wireframe = MasterWireframe.init()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        
        wireframe.presenter = presenter
        wireframe.view = view
        
        return view
    }
}

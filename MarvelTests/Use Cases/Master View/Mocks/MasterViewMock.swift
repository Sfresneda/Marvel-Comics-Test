//
//  MasterViewMock.swift
//  MarvelTests
//
//  Created by Sergio Fresneda on 2/3/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit
@testable import Hulk_Comics

class MasterViewMock: MasterViewContract {
    var presenter: MasterPresenterContract?
    
    var vc: UIViewController {
        return UIViewController()
    }
    
    var isCalledConfigureView: Bool = false
    
    func configureView(with viewModel: MasterViewModelProtocol) {
        self.isCalledConfigureView = true
    }
}

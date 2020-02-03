//
//  MasterContract.swift
//  Marvel
//
//  Created by Sergio Fresneda on 1/30/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

protocol MasterViewContract {
    var presenter: MasterPresenterContract? { get set }
    var vc: UIViewController { get }
    
    func configureView(with viewModel: MasterViewModelProtocol)
}

protocol MasterInteractorContract {
    var presenter: MasterPresenterContract? { get set }
    
    func getComicsNextPage(completion: @escaping ((MasterInteractorResponse) -> Void))
}

protocol MasterPresenterContract {
    var view: MasterViewContract? { get set }
    var interactor: MasterInteractorContract? { get set }
    var wireframe: MasterWireframeContract? { get set }
    
    func viewDidLoad()
    func reconfigureView()
    func cellIsPressed(with model: Comic)
    func loadNextPage(index: Int)
    func getComics()
}

protocol MasterWireframeContract {
    var view: MasterViewContract? { get set }
    var presenter: MasterPresenterContract? { get set }
    
    func navigateToDetailView(with model: Comic)
    func showError(contentError: String)
    func showLoading()
    func hideLoading()
}

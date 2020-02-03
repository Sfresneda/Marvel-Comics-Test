//
//  MasterPresenter.swift
//  Marvel
//
//  Created by Sergio Fresneda on 1/30/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

class MasterPresenter: MasterPresenterContract {
    
    // MARK: - Vars
    var view: MasterViewContract?
    var interactor: MasterInteractorContract?
    var wireframe: MasterWireframeContract?
    
    private lazy var isLoading: Bool = false
    private var comics: [Comic] = []
    
    // MARK: - Contract
    func viewDidLoad() {
        self.getComics()
    }
    
    func reconfigureView() {
        self.view?.configureView(with: MasterViewModel.init(comics: self.comics))
    }
    
    func cellIsPressed(with model: Comic) {
        self.wireframe?.navigateToDetailView(with: model)
    }
    
    func loadNextPage(index: Int) {
        if !self.isLoading,
            index >= self.comics.count - 2 {
            self.getComics()
        }
    }
    
    func getComics() {
        self.isLoading = true
        self.wireframe?.showLoading()
        self.interactor?.getComicsNextPage(completion: { result in
            switch result {
            case .failure(let error):
                if let wrappedError = error {
                    self.wireframe?.showError(contentError: wrappedError)
                }
            case .succeed(let models):
                self.comics.append(contentsOf: models)
                self.reconfigureView()
            }
            self.isLoading = false
            self.wireframe?.hideLoading()
        })
    }
}

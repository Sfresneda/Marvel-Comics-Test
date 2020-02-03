//
//  MasterWireframe.swift
//  Marvel
//
//  Created by Sergio Fresneda on 1/30/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

class MasterWireframe: MasterWireframeContract {
    // MARK: - Vars
    var view: MasterViewContract?
    var presenter: MasterPresenterContract?
    
    // MARK: - Contract
    func navigateToDetailView(with model: Comic) {
        guard let detailVC = UseCases.detailView.viewController as? DetailViewController,
        let originView = self.view?.vc else { return }
        let vm: DetailViewModel = DetailViewModel.init(comic: model)
        detailVC.configureView(with: vm)
                
        originView.present(detailVC, animated: true, completion: nil)
    }
    
    func showError(contentError: String) {
        let alert: UIAlertController = UIAlertController.init(title: "Error", message: contentError, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Accept", style: .default, handler: nil))
        
        self.view?.vc.present(alert, animated: true, completion: nil)
    }
    
    func showLoading() {
        guard let originView = self.view?.vc as? MasterView else { return }
        originView.showLoadingView()
    }
    
    func hideLoading() {
        guard let originView = self.view?.vc as? MasterView else { return }
        originView.hideLoadingView()
    }
}

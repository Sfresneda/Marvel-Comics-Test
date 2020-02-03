//
//  MasterWireframeMock.swift
//  MarvelTests
//
//  Created by Sergio Fresneda on 2/3/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation
@testable import Hulk_Comics

class MasterWireframeMock: MasterWireframeContract {
    var view: MasterViewContract?
    
    var presenter: MasterPresenterContract?
    
    var isCalledNavigateToDetail: Bool = false
    var isCalledShowError: Bool = false
    var isCalledShowLoading: Bool = false
    var isCalledHideLoading: Bool = false
    
    
    func navigateToDetailView(with model: Comic) {
        self.isCalledNavigateToDetail = true
    }
    func showError(contentError: String) {
        self.isCalledShowError = true
    }
    func showLoading() {
        self.isCalledShowLoading = true
    }
    func hideLoading() {
        self.isCalledHideLoading = true
    }
}

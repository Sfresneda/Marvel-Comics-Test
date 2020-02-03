//
//  ReusableView.swift
//  Marvel
//
//  Created by Sergio Fresneda on 1/30/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

protocol ReusableView {
    static var reuseViewIdentifier: String { get }
}

protocol ConfigurableView {
    associatedtype VM
    var viewModel: VM? { get set }
    func configure(with viewModel: VM)
}

typealias CellView = ReusableView & ConfigurableView

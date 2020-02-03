//
//  MasterView.swift
//  Marvel
//
//  Created by Sergio Fresneda on 1/30/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

class MasterView: UIViewController, LoadingViewProtocol, MasterViewContract {
    
    // MARK: - Outlets
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    
    // MARK: - Vars
    lazy var loadingView: UIView = LoadingView.instantiate(on: self.view)
    private var viewModel: MasterViewModelProtocol?
    var vc: UIViewController {
        return self
    }
    var presenter: MasterPresenterContract?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
    }
    
    // MARK: - Setup
    private func setupView() {
        self.view.backgroundColor = UIColor.black
        self.setupCollectionView()
    }
    
    private func setupNavigationBar() {
        self.title = "HULK Comics"
        self.navigationController?.setHulkStyle()
    }
    
    private func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 20, right: 10)
        self.comicsCollectionView.collectionViewLayout = flowLayout
        self.comicsCollectionView.register(MasterCollectionViewCell.self, forCellWithReuseIdentifier: MasterCollectionViewCell.reuseViewIdentifier)
        self.comicsCollectionView.backgroundColor = UIColor.black
        self.comicsCollectionView.accessibilityIdentifier = "comics_collectionView"
    }
    
    // MARK: - Contract
    func configureView(with viewModel: MasterViewModelProtocol) {
        self.viewModel = viewModel
        self.reloadCollectionView()
    }
    
    // MARK: - Helpers
    private func reloadCollectionView() {
        self.viewModel?.delegate = self
        self.comicsCollectionView.delegate = self.viewModel
        self.comicsCollectionView.dataSource = self.viewModel
        self.comicsCollectionView.prefetchDataSource = self
        self.comicsCollectionView.reloadData()
    }
}

extension MasterView: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if let rowMax = indexPaths.map({ $0.row }).sorted().last{
            self.presenter?.loadNextPage(index: rowMax)
        }
    }
}
extension MasterView: MasterViewModelDelegate {
    func cellIsPresed(with model: Comic) {
        self.presenter?.cellIsPressed(with: model)
    }
}

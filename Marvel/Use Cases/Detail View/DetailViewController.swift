//
//  DetailViewController.swift
//  Marvel
//
//  Created by Sergio Fresneda on 1/30/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

protocol DetailViewControllerContract {
    func configureView(with viewModel: DetailViewModel)
}

class DetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var containerPagerView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    // MARK: - Vars
    private var viewModel: DetailViewModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
    }

    // MARK: - Setup
    private func setupView() {
        self.titleLabel.text = self.viewModel?.title
        self.descriptionTitleLabel.text = "Description"
        self.descriptionLabel.text = self.viewModel?.description
        
        self.containerPagerView.backgroundColor = UIColor.red
        self.view.backgroundColor = UIColor.black
        self.scrollView.backgroundColor = UIColor.black
        self.innerView.backgroundColor = UIColor.clear
        self.bottomView.backgroundColor = UIColor.clear
        
        self.setupPager()
    }
    
    private func setupNavigationBar() {
        self.title = viewModel?.title
        self.navigationController?.setHulkStyle(isDetail: true)
    }
    
    private func setupPager() {
        guard let wrappedImages = self.viewModel?.images else {
            return
        }
        let sliderVM = ImageSliderModel.init(models: wrappedImages)
        let slider = Bundle.main.loadNibNamed("ImageSlider", owner: nil, options: nil)?.first as! ImageSlider
        slider.frame = CGRect.init(x: 0, y: 0,
                                   width: self.containerPagerView.bounds.width,
                                   height: self.containerPagerView.bounds.height)
        
        self.containerPagerView.addSubview(slider)
        
        slider.widthAnchor.constraint(equalTo: self.containerPagerView.widthAnchor).isActive = true
        slider.heightAnchor.constraint(equalTo: self.containerPagerView.heightAnchor).isActive = true
        slider.centerXAnchor.constraint(equalTo: self.containerPagerView.centerXAnchor).isActive = true
        slider.centerYAnchor.constraint(equalTo: self.containerPagerView.centerYAnchor).isActive = true

        slider.configure(with: sliderVM)
    }
}
extension DetailViewController: DetailViewControllerContract {
    
    // MARK: - Contract
    func configureView(with viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
}

//
//  ImageSlider.swift
//  Marvel
//
//  Created by Sergio Fresneda on 2/2/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

class ImageSlider: UIView, ReusableView, ConfigurableView {
    
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - Vars
    var viewModel: ImageSliderModel?
    
    static var reuseViewIdentifier: String {
        return ImageSlider.description()
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    // MARK: - Setup
    private func setupView() {
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
    }
    
    // MARK: - Protocol
    func configure(with viewModel: ImageSliderModel) {
        self.viewModel = viewModel
        
        self.viewModel?.models.forEach({ image in
            let imageView: UIImageView = UIImageView.init(frame: CGRect.init(x: CGFloat(self.scrollView.subviews.count) * self.scrollView.frame.width,
                                                                             y: 0,
                                                                             width: self.scrollView.frame.width,
                                                                             height: self.scrollView.frame.height))
            
            imageView.contentMode = .scaleAspectFit
            imageView.backgroundColor = UIColor.init(red: CGFloat.random(in: ClosedRange<CGFloat>.init(uncheckedBounds: (lower: 0, upper: 255)))/255,
                                                     green: CGFloat.random(in: ClosedRange<CGFloat>.init(uncheckedBounds: (lower: 0, upper: 255)))/255,
                                                     blue: CGFloat.random(in: ClosedRange<CGFloat>.init(uncheckedBounds: (lower: 0, upper: 255)))/255,
                                                     alpha: CGFloat.random(in: ClosedRange<CGFloat>.init(uncheckedBounds: (lower: 0, upper: 255)))/255)
            
            imageView.startDownload(image: image, format: .landscape, contentMode: .scaleToFill)
            self.scrollView.addSubview(imageView)
        })
        
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.width * CGFloat(self.viewModel?.models.count ?? 0),
                                             height:self.scrollView.frame.height)
        
        self.pageControl.numberOfPages = self.viewModel?.models.count ?? 0
        self.layoutSubviews()
    }
}

// MARK: - UIScrollDelegate
extension ImageSlider: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth: CGFloat = self.scrollView.frame.width
        let currentPage: CGFloat = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        
        self.pageControl.currentPage = Int(currentPage)
    }
}

//
//  MasterCollectionViewCell.swift
//  Marvel
//
//  Created by Sergio Fresneda on 1/30/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

class MasterCollectionViewCell: UICollectionViewCell, ReusableView, ConfigurableView {

    // MARK: - Vars
    var viewModel: MasterCollectionViewCellModel?
    static var reuseViewIdentifier: String {
        return MasterCollectionViewCell.description()
    }
    
    var comicImageView: UIImageView!
    var comicTitleLabel: UILabel!
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        let stackView: UIStackView = UIStackView.init(frame: self.contentView.frame)
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        
        self.comicImageView = UIImageView.init(frame: CGRect.init(x: 0,
                                                                  y: 0,
                                                                  width: self.contentView.bounds.width,
                                                                  height: self.contentView.bounds.width))
        self.comicImageView.backgroundColor = UIColor.darkGray
        stackView.addArrangedSubview(self.comicImageView)
        
        self.comicTitleLabel = UILabel.init(frame: self.contentView.frame)
        self.comicTitleLabel.numberOfLines = 0
        stackView.addArrangedSubview(self.comicTitleLabel)
        
        self.contentView.backgroundColor = UIColor.black
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.borderWidth = 1
        
        self.contentView.clipsToBounds = true
        self.contentView.addSubview(stackView)
        
        let topConstraint = NSLayoutConstraint.init(item: self.contentView,
                                                    attribute: .top,
                                                    relatedBy: .equal,
                                                    toItem: stackView,
                                                    attribute: .top,
                                                    multiplier: 1,
                                                    constant: 0)
        let trailingConstraint = NSLayoutConstraint.init(item: self.contentView,
                                                         attribute: .trailing,
                                                         relatedBy: .equal,
                                                         toItem: stackView,
                                                         attribute: .trailing,
                                                         multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint.init(item: self.contentView,
                                                       attribute: .bottom,
                                                       relatedBy: .equal,
                                                       toItem: stackView,
                                                       attribute: .bottom,
                                                       multiplier: 1,
                                                       constant: 8)
        let leadingConstraint = NSLayoutConstraint.init(item: self.contentView,
                                                        attribute: .trailing,
                                                        relatedBy: .equal,
                                                        toItem: stackView,
                                                        attribute: .trailing,
                                                        multiplier: 1,
                                                        constant: 0)
        
        self.contentView.addConstraints([topConstraint,trailingConstraint, bottomConstraint, leadingConstraint])
    }
        
    // MARK: - Protocol
    func configure(with viewModel: MasterCollectionViewCellModel) {
        self.viewModel = viewModel
        
        self.comicImageView.image = nil
        self.comicTitleLabel.attributedText = nil
        
        self.comicImageView.contentMode = .scaleToFill
        self.comicTitleLabel.text = self.viewModel?.title
        self.comicTitleLabel.textColor = UIColor.white
        self.comicTitleLabel.font = self.viewModel?.titleFont
        self.comicTitleLabel.textAlignment = .center
    }
}

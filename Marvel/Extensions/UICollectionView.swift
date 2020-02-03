//
//  UICollectionView.swift
//  Marvel
//
//  Created by Sergio Fresneda on 1/30/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerCell<F>(_ clazz: F.Type) where F: ReusableView, F: UICollectionViewCell {
        self.register(clazz, forCellWithReuseIdentifier: clazz.reuseViewIdentifier)
    }
    
    func dequeueCell<F>(at indexPath: IndexPath) -> F where F: ReusableView, F: UICollectionViewCell  {
        return self.dequeueReusableCell(withReuseIdentifier: F.reuseViewIdentifier, for: indexPath) as! F
    }
}

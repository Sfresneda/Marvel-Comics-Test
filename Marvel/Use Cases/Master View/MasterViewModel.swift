//
//  MasterViewModel.swift
//  Marvel
//
//  Created by Sergio Fresneda on 1/30/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

protocol MasterViewModelDelegate {
    func cellIsPresed(with model: Comic)
}

protocol MasterViewModelProtocol: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var delegate: MasterViewModelDelegate? { get set }
}

class MasterViewModel: NSObject {
    
    // MARK: - Vars
    private let comics: [MasterCollectionViewCellModel]
    var delegate: MasterViewModelDelegate?
    
    // MARK: - LifeCycle
    init(comics: [Comic]) {
        self.comics = comics.map({ MasterCollectionViewCellModel.init(model: $0) })
    }
}

extension MasterViewModel: MasterViewModelProtocol {
    
    // MARK: - UICollection Delegate & Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MasterCollectionViewCell = collectionView.dequeueCell(at: indexPath)
        cell.configure(with: self.comics[indexPath.row])
        cell.accessibilityIdentifier = "cell_\(indexPath.row)"
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        
        let blankSpacesBetweenColumns: CGFloat = CGFloat(itemsPerRow - 1)
        let insets: CGFloat = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * blankSpacesBetweenColumns)
        let widthScreen: CGFloat = collectionView.bounds.width
        let overScreen: CGFloat = widthScreen - insets
        let cellWidth: CGFloat = overScreen / CGFloat(itemsPerRow)
        let cellSize: CGSize = self.comics[indexPath.row].sizeForCell(width: cellWidth)
        
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.cellIsPresed(with: self.comics[indexPath.row].model)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? MasterCollectionViewCell,
            let wrappedViewModel = cell.viewModel,
            wrappedViewModel.hasThumbnail() else { return }
        
        cell.comicImageView.startDownload(image: wrappedViewModel.thumbnail!,
                                          format: .square,
                                          contentMode: .scaleAspectFill)
    }
}

//
//  MasterCollectionViewCellModel.swift
//  Marvel
//
//  Created by Sergio Fresneda on 1/30/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

protocol MasterCollectionViewCellModelProtocol {
    func hasThumbnail() -> Bool
}

class MasterCollectionViewCellModel {
    
    let titleFont: UIFont = UIFont.systemFont(ofSize: 22)
    
    let title: String
    let thumbnail: Image?
    
    let model: Comic
    
    init(model: Comic) {
        self.title = model.title ?? "-"
        self.thumbnail = model.thumbnail
        
        self.model = model
    }
    
    func sizeForCell(width: CGFloat) -> CGSize {
        let textHeight = title.height(withWidth: width, font: titleFont)
        return CGSize(width: width, height: width + textHeight)
    }
}

extension MasterCollectionViewCellModel: MasterCollectionViewCellModelProtocol {
    func hasThumbnail() -> Bool {
        return nil != self.thumbnail
    }
}

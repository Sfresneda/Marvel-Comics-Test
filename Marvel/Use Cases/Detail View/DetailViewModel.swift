//
//  DetailViewModel.swift
//  Marvel
//
//  Created by Sergio Fresneda on 1/30/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit


struct DetailViewModel {
    
    let title: String
    let description: String
    let images: [Image]
    
    init(comic: Comic) {
        self.title = comic.title ?? "-no title-"
        self.description = comic.description ?? "-no description-"
        self.images = comic.images ?? []
    }
}

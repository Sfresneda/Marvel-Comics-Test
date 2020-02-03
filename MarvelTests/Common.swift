//
//  Common.swift
//  MarvelTests
//
//  Created by Sergio Fresneda on 2/3/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation
@testable import Hulk_Comics

let badMockComic = Comic.init(id: nil,
                       title: nil,
                       description: nil,
                       thumbnail: nil,
                       images: nil)

let goodMockComic = Comic.init(id: 123,
                               title: "incredible hulk knows who is fresneda",
                               description: "some long description about this awesomic' comic",
                               thumbnail: Image.init(path: "https://sergiofresneda.com/someImage",
                                                     imageExtension: "bmp"),
                               images: [])

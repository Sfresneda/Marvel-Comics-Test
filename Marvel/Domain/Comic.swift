//
//  Comic.swift
//  Marvel
//
//  Created by Sergio Fresneda on 1/30/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

struct Comic: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let thumbnail: Image?
    let images: [Image]?
    
    init(id: Int?,
         title: String?,
         description: String?,
         thumbnail: Image?,
         images: [Image]?) {
        
        self.id = id
        self.title = title
        self.description = description
        self.thumbnail = thumbnail
        self.images = images
    }
}

extension Comic: Validable {
    func isValid() -> Bool {
        return nil != self.id
    }
}

extension Comic: Hashable {
    static func == (lhs: Comic, rhs: Comic) -> Bool {
        guard let wlhsId = lhs.id, let wrhsId = rhs.id else { return false }
        return wlhsId == wrhsId
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

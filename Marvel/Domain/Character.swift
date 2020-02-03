//
//  Character.swift
//  Marvel
//
//  Created by Sergio Fresneda on 1/30/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

struct Character: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail: Image?
    
    init(id: Int?,
         name: String?,
         description: String?,
         thumbnail: Image?) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
    }
}

extension Character: Validable {
    func isValid() -> Bool {
        return nil != id
    }
}

extension Character: Hashable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        guard let wlhsId = lhs.id, let wrhsId = rhs.id else { return false }
        return wlhsId == wrhsId
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

//
//  RequestModel.swift
//  Marvel
//
//  Created by Sergio Fresneda on 1/31/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

struct RequestModel<T:Codable>: Codable {
    struct Content<T:Codable>: Codable {
        let offset: Int
        let limit: Int
        let total: Int
        let count: Int
        let results: [T]
        
        func getNextOffset() -> Int? {
            return self.offset + self.limit < self.total ?
                self.offset + self.limit : nil
        }
    }
    
    let data: Content<T>
}

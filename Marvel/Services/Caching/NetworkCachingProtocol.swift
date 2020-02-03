//
//  CachingWrapper.swift
//  Marvel
//
//  Created by Sergio Fresneda on 2/1/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

struct NetworkCachingStruct<T> {
    let data: T
}

protocol NetworkCachingProcotol {
    func cache <T:Encodable>(url: URL, data: NetworkCachingStruct<T>)
    
    func getObject <T:Decodable>(for url: URL,
                                 completion: ((NetworkCachingStruct<T>?) -> ()))
    
    func clearCache()
}

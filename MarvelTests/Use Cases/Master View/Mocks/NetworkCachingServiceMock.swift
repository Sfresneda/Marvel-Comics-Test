//
//  NetworkCachingServiceMock.swift
//  MarvelTests
//
//  Created by Sergio Fresneda on 2/3/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation
@testable import Hulk_Comics

class NetworkCachingServiceMock: NetworkCachingProcotol {
    var isCalledSetCache: Bool = false
    var isCalledGetFromCache: Bool = false
    var isCalledClearCache: Bool = false
    
    var result: ((NetworkCachingStruct<RequestModel<Comic>>?) -> Void)?
    
    func cache<T>(url: URL, data: NetworkCachingStruct<T>) where T : Encodable {
        self.isCalledSetCache = true
    }
    func getObject<T>(for url: URL, completion: ((NetworkCachingStruct<T>?) -> ())) where T : Decodable {
        self.isCalledGetFromCache = true
        self.result = completion as? ((NetworkCachingStruct<RequestModel<Comic>>?) -> Void)
    }
    func clearCache() {
        self.isCalledClearCache = true
    }
}

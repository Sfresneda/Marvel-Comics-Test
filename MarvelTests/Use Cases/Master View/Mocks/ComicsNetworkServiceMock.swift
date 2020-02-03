//
//  ComicsNetworkServiceMock.swift
//  MarvelTests
//
//  Created by Sergio Fresneda on 2/3/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation
@testable import Hulk_Comics

class ComicsNetworkServiceMock: ComicNetworkServiceProtocol {
    var isCalledGetComicsPaginated: Bool = false
    var result: ((ComicsNetworkResponse) -> ())?

    func getComicsPaginated(request: URLRequest, completion: @escaping ((ComicsNetworkResponse) -> ())) {
        self.isCalledGetComicsPaginated = true
        self.result = completion
    }
}

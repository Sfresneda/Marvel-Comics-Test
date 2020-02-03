//
//  ComicsNetworkProtocol.swift
//  Marvel
//
//  Created by Sergio Fresneda on 2/1/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

enum ComicsNetworkResponse {
    case succeed(models: RequestModel<Comic>, nextOffset: Int?)
    case failure(NetworkWrapperError)
}

protocol ComicNetworkServiceProtocol {
    func getComicsPaginated(request: URLRequest,
                                       completion: @escaping ((ComicsNetworkResponse) -> ()))
}

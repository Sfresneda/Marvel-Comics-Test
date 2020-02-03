//
//  ComicsNetworkService.swift
//  Marvel
//
//  Created by Sergio Fresneda on 2/1/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

final class ComicsNetworkService {
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension ComicsNetworkService: ComicNetworkServiceProtocol {
    func getComicsPaginated(request: URLRequest, completion: @escaping ((ComicsNetworkResponse) -> ())) {
        
        self.networkManager.get(request: request) { (response: NetworkWrapperResponse<RequestModel<Comic>>) in
            switch response {
            case .failure(let wrapperError):
                completion(.failure(wrapperError))
            case .succeed(let requestModel):
                completion(.succeed(models: requestModel,
                                    nextOffset: requestModel.data.getNextOffset()))
            }
        }
    }
}

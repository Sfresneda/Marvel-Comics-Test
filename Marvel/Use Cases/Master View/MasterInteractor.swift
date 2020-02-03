//
//  MasterInteractor.swift
//  Marvel
//
//  Created by Sergio Fresneda on 1/30/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

private struct ComicsPaginatedRequest {
    let cacheKey: URL
    var nextRequest: URLRequest
    var isExausted: Bool = false
    
    init(offset: Int = 0,
         limit: Int = 10,
         character: Int = 1009351) {
        
        var url = "https://\(kBaseAPIPath)characters/"
        var params: [String: String] = [:]
        let timeStamp: String = Date.currentStringTimeStamp()
        
        url += "\(character)/comics"
        
        params["limit"] = String(limit)
        params["offset"] = String(offset)
        params["apikey"] = kPublicKey
        params["ts"] = timeStamp
        params["hash"] = (timeStamp + kPrivateKey + kPublicKey).toMD5().toHex
        
        var components = URLComponents.init(url: URL.init(string: url)!,
                                            resolvingAgainstBaseURL: true)!
        components.queryItems = params.map({ (key, value) in
            URLQueryItem.init(name: key, value: value)
        })
        
        self.cacheKey = URLRequest.init(url: components.removeKeys(name: "ts", "hash").url!).url!
        self.nextRequest = URLRequest.init(url: components.url!)
    }
}

enum MasterInteractorResponse {
    case succeed(models: [Comic])
    case failure(error: String?)
}

class MasterInteractor: MasterInteractorContract {    
    // MARK: - Vars
    var presenter: MasterPresenterContract?
    private let networkProvider: ComicNetworkServiceProtocol!
    private let cachingProvider: NetworkCachingProcotol!
    
    private lazy var request: ComicsPaginatedRequest = ComicsPaginatedRequest.init()
    
    init(network: ComicNetworkServiceProtocol,
         caching: NetworkCachingProcotol) {
        self.networkProvider = network
        self.cachingProvider = caching
    }
    
    // MARK: - Contract
    func getComicsNextPage(completion: @escaping ((MasterInteractorResponse) -> Void)) {
        guard !self.request.isExausted else {
            completion(.failure(error: nil))
            return
        }
        
        self.cachingProvider.getObject(for: self.request.cacheKey) { (cachedResponse: NetworkCachingStruct<RequestModel<Comic>>?) in
            guard nil == cachedResponse else {
                let cached = cachedResponse!
                self.updateNextRequest(nextOffset: cached.data.data.getNextOffset())
                completion(.succeed(models: cached.data.data.results))
                return
            }
            
            self.networkProvider.getComicsPaginated(request: self.request.nextRequest) { (result) in
                switch result {
                case .failure(let error):
                    completion(.failure(error: error.getStringError()))
                case .succeed(let request, let nextOffset):
                    self.cachingProvider.cache(url: self.request.cacheKey,
                                               data: NetworkCachingStruct(data: request))
                    self.updateNextRequest(nextOffset: nextOffset)
                    completion(.succeed(models: request.data.results))
                }
            }
        }
    }
    
    // MARK: - Helper
    private func updateNextRequest(nextOffset: Int?) {
        if let wrappedNextOffset = nextOffset {
            self.request = ComicsPaginatedRequest.init(offset: wrappedNextOffset)
        }else {
            self.request.isExausted = true
        }
    }
}

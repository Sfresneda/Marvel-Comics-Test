//
//  NetworkCachingService.swift
//  Marvel
//
//  Created by Sergio Fresneda on 2/1/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

final class NetworkCachingService  {
    static let shared: NetworkCachingService = NetworkCachingService()
    
    private let userDefaults: UserDefaults
    
    private let suite: String = "com.fda.Marvel.cache"
    
    private init() {
        self.userDefaults = UserDefaults.init(suiteName: self.suite)!
    }
}

extension NetworkCachingService {
    private func get<T:Decodable>(with key: String) -> T? {
        guard let data = self.userDefaults.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    private func set<T:Encodable>(with key: String, value: T?) {
        guard let newValue = value,
            let encodedValue = try? JSONEncoder().encode(newValue) else {
                userDefaults.removeObject(forKey: key)
                return
        }
        self.userDefaults.set(encodedValue, forKey: key)
    }
}

extension NetworkCachingService: NetworkCachingProcotol {
    func cache<T>(url: URL, data: NetworkCachingStruct<T>) where T : Encodable {
        self.set(with: url.absoluteString, value: data.data)
    }
    
    func getObject<T>(for url: URL, completion: ((NetworkCachingStruct<T>?) -> ())) where T : Decodable {
        guard let data: T = self.get(with: url.absoluteString) else {
            completion(nil)
            return
        }
        completion(NetworkCachingStruct(data: data))
        
    }
    
    func clearCache() {
        self.userDefaults.dictionaryRepresentation().forEach({ (key, value) in
            self.userDefaults.removeObject(forKey: key)
        })
    }
}

//
//  UIImageView.swift
//  Marvel
//
//  Created by Sergio Fresneda on 2/2/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import UIKit

enum MarvelImageformat: String {
    case portrait = "portrait_medium"
    case square = "standard_medium"
    case landscape = "landscape_medium"
}

extension UIImageView {
    
    private var downloadSession: URLSession {
        return URLSession.shared
    }
    private var cache: URLCache {
        return URLCache.shared
    }
    
    func startDownload(image: Image, format: MarvelImageformat, contentMode: UIView.ContentMode = .scaleAspectFit) {
        guard let wrappedPath = image.path,
            let wrappedExtension = image.imageExtension,
            let wrappedURL = URL.init(string: "\(wrappedPath)/\(format.rawValue).\(wrappedExtension)") else {
            return
        }
        self.contentMode = contentMode

        let response = self.cache.cachedResponse(for: URLRequest.init(url: wrappedURL))
        guard nil == response else {
            self.image = UIImage.init(data: response!.data)
            self.layoutSubviews()
            return
        }
        
        self.downloadSession.dataTask(with: wrappedURL) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse,
                200 == httpURLResponse.statusCode,
                let mimeType = response?.mimeType,
                mimeType.hasPrefix("image"),
                nil == error,
                let wrappedData = data else {
                    return
            }
            
            self.cache.storeCachedResponse(CachedURLResponse.init(response: httpURLResponse,
                                                                  data: wrappedData),
                                           for: URLRequest.init(url: wrappedURL)
            )
            DispatchQueue.main.async {
                self.image = UIImage.init(data: wrappedData)
                self.layoutSubviews()
            }
        }.resume()
    }
}

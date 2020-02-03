//
//  URLComponents.swift
//  Marvel
//
//  Created by Sergio Fresneda on 2/1/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

extension URLComponents {
    func removeKeys(name: String ...) -> URLComponents {
        var components = URLComponents.init(url: self.url!, resolvingAgainstBaseURL: true)!
        
        let newQueryItems = self.queryItems?.filter({ !name.contains($0.name) })
        components.queryItems = newQueryItems?.sorted(by: { (lhd, rhd) -> Bool in
            lhd.name < rhd.name
        })
        return components
    }
}

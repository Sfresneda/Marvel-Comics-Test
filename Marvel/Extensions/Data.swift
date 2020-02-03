//
//  Data.swift
//  Marvel
//
//  Created by Sergio Fresneda on 1/31/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation
extension Data {
    var toHex: String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}

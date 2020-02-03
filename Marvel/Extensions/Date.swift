//
//  Date.swift
//  Marvel
//
//  Created by Sergio Fresneda on 2/1/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation

extension Date {
    static func currentStringTimeStamp() -> String {
        return String(Int(Date().timeIntervalSince1970))
    }
}

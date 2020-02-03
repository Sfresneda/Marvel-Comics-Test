//
//  MasterInteractorMock.swift
//  MarvelTests
//
//  Created by Sergio Fresneda on 2/3/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import Foundation
@testable import Hulk_Comics

class MasterInteractorMock: MasterInteractorContract {
    var presenter: MasterPresenterContract?
    
    var isCalledGetComicsNextPage: Bool = false
    
    var completion: MasterInteractorResponse = MasterInteractorResponse.failure(error: "such error")
    
    let succeedResult: [Comic] = Array.init(repeating: goodMockComic, count: 10)
    
    func getComicsNextPage(completion: @escaping ((MasterInteractorResponse) -> Void)) {
        self.isCalledGetComicsNextPage = true
        completion(self.completion)
    }
}

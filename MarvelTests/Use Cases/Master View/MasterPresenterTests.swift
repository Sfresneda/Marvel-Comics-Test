//
//  MasterPresenterTests.swift
//  MarvelTests
//
//  Created by Sergio Fresneda on 2/3/20.
//  Copyright © 2020 Sergio Fresneda. All rights reserved.
//

import XCTest
@testable import Hulk_Comics

class MasterPresenterTests: XCTestCase {
    var presenter: MasterPresenterContract!
    var view: MasterViewMock!
    var wireframe: MasterWireframeMock!
    var interactor: MasterInteractorMock!
    
    override func setUp() {
        self.presenter = MasterPresenter.init()
        self.view = MasterViewMock()
        self.wireframe = MasterWireframeMock()
        self.interactor = MasterInteractorMock()
        
        self.presenter.view = self.view
        self.presenter.wireframe = self.wireframe
        self.presenter.interactor = self.interactor
    }
    override func tearDown() {
        self.presenter = nil
        self.view = nil
        self.wireframe = nil
        self.interactor = nil
    }
    
    func test_viewDidLoad() {
        self.presenter.viewDidLoad()
        XCTAssertNotNil(self.interactor.completion)
    }
    
    func test_reconfigureView() {
        self.presenter.reconfigureView()
        
        XCTAssertTrue(self.view.isCalledConfigureView)
    }
    
    func test_cellIsPressed() {
        self.presenter.cellIsPressed(with: badMockComic)
        XCTAssertTrue(self.wireframe.isCalledNavigateToDetail)
        XCTAssertFalse(badMockComic.isValid())
    }
    
    func test_cellIsPressedWithGoodComic() {
        self.presenter.cellIsPressed(with: goodMockComic)
        XCTAssertTrue(self.wireframe.isCalledNavigateToDetail)
        XCTAssertTrue(goodMockComic.isValid())
    }
    
    func test_loadNext() {
        self.presenter.loadNextPage(index: 0)
        XCTAssertTrue(self.wireframe.isCalledShowLoading)
        XCTAssertTrue(self.interactor.isCalledGetComicsNextPage)
    }
    
    func test_getComics() {
        self.interactor.completion = MasterInteractorResponse.succeed(models: self.interactor.succeedResult)
        self.presenter.getComics()
        
        XCTAssertTrue(self.wireframe.isCalledShowLoading)
        XCTAssertTrue(self.interactor.isCalledGetComicsNextPage)
        XCTAssertTrue(self.wireframe.isCalledHideLoading)
    }
    
    func test_getComicsWithError() {
        self.presenter.getComics()
        
        XCTAssertTrue(self.wireframe.isCalledShowLoading)
        XCTAssertTrue(self.interactor.isCalledGetComicsNextPage)
        XCTAssertTrue(self.wireframe.isCalledHideLoading)
        XCTAssertTrue(self.wireframe.isCalledShowError)
    }
}

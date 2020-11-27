//
//  MovieDetailsViewControllerTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 19/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import FBSnapshotTestCase
@testable import Movs

//final class MovieDetailsViewControllerTests: FBSnapshotTestCase {
//    private lazy var sut = MovieDetailsViewController(movie: moviesDetails, interactor: interactorSpy)
//
//    // MARK: - Private constants
//
//    private let moviesDetails = MocksHelper.getMockedMovie()
//
//    private let interactorSpy = MovieDetailsInteractorSpy()
//
//    // MARK: - Override functions
//
//    override func setUp() {
//        super.setUp()
//
//        recordMode = false
//
//        setRootViewController(sut)
//    }
//
//    override func tearDown() {
//        super.tearDown()
//
//        popRootViewController()
//        clearRootViewController()
//    }
//
//    // MARK: - Test functions
//
//    func testInitialization() {
//        _ = sut
//
//        XCTAssertFalse(interactorSpy.invokedSaveMovie)
//        XCTAssertFalse(interactorSpy.invokedDeleteMovie)
//    }
//
//    func testShouldDisplayFavoriteIcon() {
//        sut.displayFavoriteIcon()
//
//        wait()
//
//        verify(sut)
//    }
//
//    func testShouldDisplayUnfavoriteIcon() {
//        sut.displayUnfavoriteIcon()
//
//        wait()
//
//        verify(sut)
//    }
//}

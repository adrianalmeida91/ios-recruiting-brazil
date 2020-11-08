//
//  MoviesScreenFactoryTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 08/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

final class MoviesScreenFactoryTests: XCTestCase {
    private lazy var sut = MoviesScreenFactory.make(delegate: delegateSpy)

    private let delegateSpy = MoviesViewControllerDelegateSpy()

    // MARK: - Test functions

    func testShouldCreateMoviesViewControllerByFactory() {
        _ = sut

        XCTAssertNotNil(sut)
        XCTAssertFalse(delegateSpy.invokedGalleryItemTapped)
    }
}

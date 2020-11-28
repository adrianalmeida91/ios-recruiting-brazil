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
    private let delegateSpy = MoviesViewControllerDelegateSpy()

    // MARK: - Test functions

    func testMoviesScreenFactoryShouldMakeMoviesViewController() {
        let sut = MoviesScreenFactory.make(delegate: delegateSpy)

        XCTAssertNotNil(sut)
        XCTAssertFalse(delegateSpy.invokedGalleryItemTapped)
        XCTAssertTrue(sut is MoviesViewController)
        XCTAssertNil(sut.tabBarItem.image)
        XCTAssertNil(sut.tabBarItem.title)
    }

    func testMoviesScreenFactoryShouldMakeMoviesViewControllertesForTabBar() {
        let sut = MoviesScreenFactory.makeForTabBar(delegate: delegateSpy)

        XCTAssertNotNil(sut)
        XCTAssertFalse(delegateSpy.invokedGalleryItemTapped)
        XCTAssertTrue(sut is MoviesViewController)
        XCTAssertNotNil(sut.tabBarItem.image)
        XCTAssertEqual(sut.tabBarItem.title, "Movies")
    }
}

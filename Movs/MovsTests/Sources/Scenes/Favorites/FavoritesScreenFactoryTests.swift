//
//  FavoritesScreenFactoryTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

final class FavoritesScreenFactoryTests: XCTestCase {
    func testFavoritesScreenFactoryShouldMakeFavoritesViewController() {
        let sut = FavoritesScreenFactory.make()

        XCTAssertNotNil(sut)
        XCTAssertTrue(sut is FavoritesViewController)
        XCTAssertNil(sut.tabBarItem.image)
        XCTAssertNil(sut.tabBarItem.title)
    }

    func testFavoritesScreenFactoryShouldMakeFavoritesViewControllerForTabBar() {
        let sut = FavoritesScreenFactory.makeForTabBar()

        XCTAssertNotNil(sut)
        XCTAssertTrue(sut is FavoritesViewController)
        XCTAssertNotNil(sut.tabBarItem.image)
        XCTAssertEqual(sut.tabBarItem.title, "Favorites")
    }
}

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

        verifySutType(sut: sut)

        XCTAssertNil(sut.tabBarItem.image)
        XCTAssertNil(sut.tabBarItem.title)
    }

    func testFavoritesScreenFactoryShouldMakeFavoritesViewControllerForTabBar() {
        let sut = FavoritesScreenFactory.makeForTabBar()

        verifySutType(sut: sut)

        XCTAssertNotNil(sut.tabBarItem.image)
        XCTAssertEqual(sut.tabBarItem.title, "Favorites")
    }

    // MARK: - Private functions

    private func verifySutType(sut: UIViewController) {
        XCTAssertNotNil(sut)
        XCTAssertTrue(sut is FavoritesViewController)
        XCTAssertTrue(sut is FilterProtocol)
        XCTAssertTrue(sut is FavoritesDisplayLogic)
    }
}

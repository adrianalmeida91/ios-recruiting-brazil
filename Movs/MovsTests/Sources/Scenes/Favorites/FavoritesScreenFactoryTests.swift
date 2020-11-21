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
    private lazy var sut = FavoritesScreenFactory.make()

    // MARK: - Test Functions

    func testShouldCreateFavoritesViewControllerByFactory() {
        _ = sut

        XCTAssertNotNil(sut)
        XCTAssertTrue(sut is FavoritesViewController)
    }
}

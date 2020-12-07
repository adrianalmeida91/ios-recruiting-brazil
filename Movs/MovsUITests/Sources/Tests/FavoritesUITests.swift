//
//  FavoritesUITests.swift
//  MovsUITests
//
//  Created by Adrian Almeida on 07/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest

final class FavoritesUITests: XCTestCase {
    lazy var favoritesScreen = FavoritesScreen()

    // MARK: - Override functions

    override func setUp() {
        super.setUp()

        let moviesScreen = MoviesScreen()
        favoritesScreen = moviesScreen.favoriteIconTap()
    }

    // MARK: - Test functions

    func testFilterIconTapShouldOpenFilterScreen() {
        favoritesScreen.filterIconTap()
    }
}

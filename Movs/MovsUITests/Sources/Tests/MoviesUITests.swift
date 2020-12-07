//
//  MoviesUITests.swift
//  MovsUITests
//
//  Created by Adrian Almeida on 06/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest

final class MoviesUITests: XCTestCase {
    lazy var moviesScreen = MoviesScreen()

    // MARK: - Test functions

    func testInitialization() {
        _ = moviesScreen

        XCTAssertNotNil(moviesScreen.moviesTabBarItem)
        XCTAssertNotNil(moviesScreen.favoritesTabBarItem)
        XCTAssertTrue(moviesScreen.moviesTabBarItem.isSelected)
        XCTAssertFalse(moviesScreen.favoritesTabBarItem.isSelected)
    }

    func testGalleryItemTapShouldOpenMovieDetailsScreen() {
        moviesScreen.galleryItemIndexTap(at: 0)
    }
}

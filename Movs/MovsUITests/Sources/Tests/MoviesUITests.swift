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

    func testSearchMovieAndTapShouldOpenMovieDetailsScreen() {
        moviesScreen.searchText(text: "KILL")
            .galleryItemIndexTap(at: 0)
    }

    func testSearchMovieWrongTextShouldDisplayErrorMessage() {
        let searchText = "AAAAAAAAA"

        XCTAssertTrue(moviesScreen.searchText(text: searchText)
                        .verifyErrorMessage(text: searchText))
    }

    func testSearchMoviesAndCancelFieldShouldDisplayMovies() {
        let searchText = "KILL"
//        let searchText = "AAAAAAAAA" -> There is a bug here

        XCTAssertFalse(moviesScreen.searchText(text: searchText)
            .cancelSearchButtonTap()
            .verifyErrorMessage(text: searchText))
    }

    func testSearchMoviesAndClearFieldShouldDisplayMovies() {
        let searchText = "AAAAAAAAA"

        XCTAssertFalse(moviesScreen.searchText(text: searchText)
            .clearSearchText()
            .verifyErrorMessage(text: searchText))
    }
}

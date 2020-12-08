//
//  MovieDetailsUITests.swift
//  MovsUITests
//
//  Created by Adrian Almeida on 07/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest

final class MovieDetailsUITests: XCTestCase {
    lazy var movieDetailsScreen = MovieDetailsScreen()

    // MARK: - Override functions

    override func setUp() {
        super.setUp()

        let moviesScreen = MoviesScreen()
        movieDetailsScreen = moviesScreen.searchText(text: "KILL")
                                .galleryItemIndexTap(at: 0)
    }

    // MARK: - Test functions

    func testIconButtonTapShouldFavoriteAndUnfavorite() {
        movieDetailsScreen.favoriteIconTap()
            .favoriteIconTap()
            .favoriteIconTap()
            .favoriteIconTap()

        XCTAssertTrue(movieDetailsScreen.iconButton.exists)
    }
}

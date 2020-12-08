//
//  FilterUITests.swift
//  MovsUITests
//
//  Created by Adrian Almeida on 07/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest

final class FilterUITests: XCTestCase {
    lazy var filterScreen = FilterScreen()

    // MARK: - Override functions

    override func setUp() {
        super.setUp()

        let moviesScreen = MoviesScreen()
        filterScreen = moviesScreen.favoriteIconTap().filterIconTap()
    }

    // MARK: - Test functions

    func testFilterByDateAndGenre() {
        filterScreen.dateTap()
            .selectDate(dates: ["2020"])
            .backTypeListButtonTap()
            .genresTap()
            .selectGenres(genres: ["Action"])
            .backTypeListButtonTap()
            .applyButtonTap()
    }
}

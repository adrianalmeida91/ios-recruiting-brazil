//
//  FilterScreen.swift
//  MovsUITests
//
//  Created by Adrian Almeida on 07/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest

final class FilterScreen: ScreenTest {
    private lazy var staticTextElements = findAll(.staticText)
    private lazy var buttonElements = findAll(.button)

    // MARK: - Lazy variables

    lazy var date = staticTextElements["Date"]
    lazy var genres = staticTextElements["Genres"]
    lazy var backButton = buttonElements[FilterIdentifiers.backButton.identifier]
    lazy var applyButton = buttonElements[FilterIdentifiers.applyButton.identifier]

    // MARK: - Private variables

    private var isShowingDataList = false

    // MARK: - Initializer

    init() {
        waitForExpectation(element: date, timeout: timeout)
        waitForExpectation(element: genres, timeout: timeout)
    }

    // MARK: - Functions

    @discardableResult
    func dateTap() -> FilterScreen {
        date.tap()
        isShowingDataList = true

        return self
    }

    @discardableResult
    func genresTap() -> FilterScreen {
        genres.tap()
        isShowingDataList = true

        return self
    }

    @discardableResult
    func selectDate(dates: [String]) -> FilterScreen {
        dates.forEach { date in
            staticTextElements[date].tap()
        }

        return self
    }

    @discardableResult
    func selectGenres(genres: [String]) -> FilterScreen {
        genres.forEach { genre in
            staticTextElements[genre].tap()
        }

        return self
    }

    @discardableResult
    func backTypeListButtonTap() -> FilterScreen {
        guard isShowingDataList else {
            XCTFail()
            return self
        }

        backButton.tap()

        return self
    }

    @discardableResult
    func backToFavoriteScreen() -> FavoritesScreen {
        guard !isShowingDataList else {
            XCTFail()
            return FavoritesScreen()
        }

        backButton.tap()

        return FavoritesScreen()
    }

    @discardableResult
    func applyButtonTap() -> FavoritesScreen {
        applyButton.tap()

        return FavoritesScreen()
    }
}

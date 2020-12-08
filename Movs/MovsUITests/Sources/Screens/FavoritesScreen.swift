//
//  FavoritesScreen.swift
//  MovsUITests
//
//  Created by Adrian Almeida on 07/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

final class FavoritesScreen: ScreenTest {
    private lazy var searchFieldElements = findAll(.searchField)
    private lazy var buttonElements = findAll(.button)
    private lazy var cellElements = findAll(.cell)

    // MARK: - Lazy variables

    lazy var searchField = searchFieldElements["Search"]
    lazy var filterIcon = buttonElements[TabBarIdentifiers.filterIcon.identifier]
    lazy var unfavoriteButton = buttonElements["Unfavorite"]

    // MARK: - Initializer

    init() {
        waitForExpectation(element: filterIcon, timeout: timeout)
    }

    // MARK: - Functions

    @discardableResult
    func filterIconTap() -> FilterScreen {
        filterIcon.tap()

        return FilterScreen()
    }

    @discardableResult
    func unfavoriteMovie(at index: Int) -> FavoritesScreen {
        let cell = cellElements.element(boundBy: index)
        cell.swipeLeft()
        unfavoriteButton.tap()

        return self
    }

    @discardableResult
    func searchText(text: String) -> FavoritesScreen {
        sendText(element: searchField, text: text)

        return self
    }
}

//
//  FavoritesScreen.swift
//  MovsUITests
//
//  Created by Adrian Almeida on 07/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

final class FavoritesScreen: ScreenTest {
    private lazy var buttonElements = findAll(.button)

    // MARK: - Lazy variables

    lazy var filterIcon = buttonElements[TabBarIdentifiers.filterIcon.identifier]

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
}

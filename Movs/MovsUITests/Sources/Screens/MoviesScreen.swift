//
//  MoviesScreen.swift
//  MovsUITests
//
//  Created by Adrian Almeida on 06/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class MoviesScreen: ScreenTest {
    private lazy var buttonsElements = findAll(.button)

    // MARK: - Lazy variables

    lazy var moviesTabBarItem = buttonsElements[MovsIdentifiers.moviesTabBarItem.identifier]

    lazy var favoritesTabBarItem = buttonsElements[MovsIdentifiers.favoritesTabBarItem.identifier]

    // MARK: - Initializer

    init() {
        waitForExpectation(element: moviesTabBarItem, timeout: timeout)
    }
}

//
//  FilterScreen.swift
//  MovsUITests
//
//  Created by Adrian Almeida on 07/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

final class FilterScreen: ScreenTest {
    private lazy var staticTextElements = findAll(.staticText)

    // MARK: - Lazy variables

    lazy var date = staticTextElements["Date"]
    lazy var genres = staticTextElements["Genres"]

    // MARK: - Initializer

    init() {
        waitForExpectation(element: date, timeout: timeout)
        waitForExpectation(element: genres, timeout: timeout)
    }
}

//
//  MovieDetailsScreen.swift
//  MovsUITests
//
//  Created by Adrian Almeida on 06/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

final class MovieDetailsScreen: ScreenTest {
    private lazy var imagesViewElements = findAll(.image)
    private lazy var buttonElements = findAll(.button)

    // MARK: - Lazy variables

    lazy var movieImage = imagesViewElements[MovieDetailsIdentifiers.movieDetailsImageView.identifier]
    lazy var iconButton = buttonElements[ComponentsIdentifiers.infoListIconButton.identifier]

    // MARK: - Initializer

    init() {
        waitForExpectation(element: movieImage, timeout: timeout)
    }

    // MARK: - Functions

    @discardableResult
    func favoriteIconTap() -> MovieDetailsScreen {
        iconButton.tap()

        return self
    }
}

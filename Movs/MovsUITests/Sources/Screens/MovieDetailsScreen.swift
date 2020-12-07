//
//  MovieDetailsScreen.swift
//  MovsUITests
//
//  Created by Adrian Almeida on 06/12/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

final class MovieDetails: ScreenTest {
    private lazy var imagesViews = findAll(.image)

    // MARK: - Lazy variables

    lazy var movieImage = imagesViews[MovieDetailsIdentifiers.movieDetailsImageView.identifier]

    // MARK: - Initializer

    init() {
        waitForExpectation(element: movieImage, timeout: timeout)
    }
}

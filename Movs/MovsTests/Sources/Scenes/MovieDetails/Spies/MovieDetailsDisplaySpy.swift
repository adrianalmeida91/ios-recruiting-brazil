//
//  MovieDetailsDisplaySpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 19/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class MovieDetailsDisplaySpy: MovieDetailsDisplayLogic {
    private(set) var invokedDisplayMovie = false
    private(set) var invokedDisplayMovieCount = 0
    private(set) var invokedDisplayMovieParameters: (viewModel: MovieDetails.FetchMovie.ViewModel, Void)?
    private(set) var invokedDisplayMovieParametersList = [(viewModel: MovieDetails.FetchMovie.ViewModel, Void)]()

    private(set) var invokedDisplayFavoriteIcon = false
    private(set) var invokedDisplayFavoriteIconCount = 0

    private(set) var invokedDisplayUnfavoriteIcon = false
    private(set) var invokedDisplayUnfavoriteIconCount = 0

    // MARK: - MovieDetailsDisplayLogic conforms

    func displayMovie(viewModel: MovieDetails.FetchMovie.ViewModel) {
        invokedDisplayMovie = true
        invokedDisplayMovieCount += 1
        invokedDisplayMovieParameters = (viewModel, ())
        invokedDisplayMovieParametersList.append((viewModel, ()))
    }

    func displayFavoriteIcon() {
        invokedDisplayFavoriteIcon = true
        invokedDisplayFavoriteIconCount += 1
    }

    func displayUnfavoriteIcon() {
        invokedDisplayUnfavoriteIcon = true
        invokedDisplayUnfavoriteIconCount += 1
    }
}

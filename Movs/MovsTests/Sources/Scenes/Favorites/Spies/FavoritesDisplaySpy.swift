//
//  FavoritesDisplaySpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class FavoritesDisplaySpy: FavoritesDisplayLogic {
    private(set) var invokedDisplayMovies = false
    private(set) var invokedDisplayMoviesCount = 0
    private(set) var invokedDisplayMoviesParameters: (viewModel: Favorites.FetchMovies.ViewModel, Void)?
    private(set) var invokedDisplayMoviesParametersList = [(viewModel: Favorites.FetchMovies.ViewModel, Void)]()

    private(set) var invokedDisplayEmptyView = false
    private(set) var invokedDisplayEmptyViewCount = 0

    private(set) var invokedDisplayMovieUnfavorite = false
    private(set) var invokedDisplayMovieUnfavoriteCount = 0

    private(set) var invokedDisplayFailureError = false
    private(set) var invokedDisplayFailureErrorCount = 0

    private(set) var invokedDisplaySearchedMovies = false
    private(set) var invokedDisplaySearchedMoviesCount = 0
    private(set) var invokedDisplaySearchedMoviesParameters: (viewModel: Favorites.FetchMoviesBySearch.ViewModel, Void)?
    private(set) var invokedDisplaySearchedMoviesParametersList = [(viewModel: Favorites.FetchMoviesBySearch.ViewModel, Void)]()

    private(set) var invokedDisplaySearchError = false
    private(set) var invokedDisplaySearchErrorCount = 0
    private(set) var invokedDisplaySearchErrorParameters: (searchedText: String, Void)?
    private(set) var invokedDisplaySearchErrorParametersList = [(searchedText: String, Void)]()

    // MARK: - FavoritesDisplayLogic conforms

    func displayMovies(viewModel: Favorites.FetchMovies.ViewModel) {
        invokedDisplayMovies = true
        invokedDisplayMoviesCount += 1
        invokedDisplayMoviesParameters = (viewModel, ())
        invokedDisplayMoviesParametersList.append((viewModel, ()))
    }

    func displayEmptyView() {
        invokedDisplayEmptyView = true
        invokedDisplayEmptyViewCount += 1
    }

    func displayMovieUnfavorite() {
        invokedDisplayMovieUnfavorite = true
        invokedDisplayMovieUnfavoriteCount += 1
    }

    func displayFailureError() {
        invokedDisplayFailureError = true
        invokedDisplayFailureErrorCount += 1
    }

    func displaySearchedMovies(viewModel: Favorites.FetchMoviesBySearch.ViewModel) {
        invokedDisplaySearchedMovies = true
        invokedDisplaySearchedMoviesCount += 1
        invokedDisplaySearchedMoviesParameters = (viewModel, ())
        invokedDisplaySearchedMoviesParametersList.append((viewModel, ()))
    }

    func displaySearchError(searchedText: String) {
        invokedDisplaySearchError = true
        invokedDisplaySearchErrorCount += 1
        invokedDisplaySearchErrorParameters = (searchedText, ())
        invokedDisplaySearchErrorParametersList.append((searchedText, ()))
    }
}

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

    private(set) var invokedDisplayError = false
    private(set) var invokedDisplayErrorCount = 0

    private(set) var invokedDisplaySearchedMovies = false
    private(set) var invokedDisplaySearchedMoviesCount = 0
    private(set) var invokedDisplaySearchedMoviesParameters: (viewModel: Favorites.FetchMoviesBySearch.ViewModel, Void)?
    private(set) var invokedDisplaySearchedMoviesParametersList = [(viewModel: Favorites.FetchMoviesBySearch.ViewModel, Void)]()

    private(set) var invokedDisplaySearchedError = false
    private(set) var invokedDisplaySearchedErrorCount = 0
    private(set) var invokedDisplaySearchedErrorParameters: (searchedText: String, Void)?
    private(set) var invokedDisplaySearchedErrorParametersList = [(searchedText: String, Void)]()

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

    func displayError() {
        invokedDisplayError = true
        invokedDisplayErrorCount += 1
    }

    func displaySearchedMovies(viewModel: Favorites.FetchMoviesBySearch.ViewModel) {
        invokedDisplaySearchedMovies = true
        invokedDisplaySearchedMoviesCount += 1
        invokedDisplaySearchedMoviesParameters = (viewModel, ())
        invokedDisplaySearchedMoviesParametersList.append((viewModel, ()))
    }

    func displaySearchedError(searchedText: String) {
        invokedDisplaySearchedError = true
        invokedDisplaySearchedErrorCount += 1
        invokedDisplaySearchedErrorParameters = (searchedText, ())
        invokedDisplaySearchedErrorParametersList.append((searchedText, ()))
    }
}

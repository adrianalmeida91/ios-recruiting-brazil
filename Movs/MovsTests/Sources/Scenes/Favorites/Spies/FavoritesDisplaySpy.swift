//
//  FavoritesDisplaySpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class FavoritesDisplaySpy: FavoritesDisplayLogic {
    private(set) var invokedDisplayLocalMovies = false
    private(set) var invokedDisplayLocalMoviesCount = 0
    private(set) var invokedDisplayLocalMoviesParameters: (viewModel: Favorites.FetchLocalMovies.ViewModel, Void)?
    private(set) var invokedDisplayLocalMoviesParametersList = [(viewModel: Favorites.FetchLocalMovies.ViewModel, Void)]()

    private(set) var invokedDisplayFetchedLocalMoviesEmpty = false
    private(set) var invokedDisplayFetchedLocalMoviesEmptyCount = 0

    private(set) var invokedDisplayMovieUnfavorite = false
    private(set) var invokedDisplayMovieUnfavoriteCount = 0

    private(set) var invokedDisplayGenericError = false
    private(set) var invokedDisplayGenericErrorCount = 0

    private(set) var invokedDisplayMoviesBySearch = false
    private(set) var invokedDisplayMoviesBySearchCount = 0
    private(set) var invokedDisplayMoviesBySearchParameters: (viewModel: Favorites.FetchLocalMoviesBySearch.ViewModel, Void)?
    private(set) var invokedDisplayMoviesBySearchParametersList = [(viewModel: Favorites.FetchLocalMoviesBySearch.ViewModel, Void)]()

    private(set) var invokedDisplaySearchError = false
    private(set) var invokedDisplaySearchErrorCount = 0
    private(set) var invokedDisplaySearchErrorParameters: (searchedText: String, Void)?
    private(set) var invokedDisplaySearchErrorParametersList = [(searchedText: String, Void)]()

    // MARK: - FavoritesDisplayLogic conforms

    func displayLocalMovies(viewModel: Favorites.FetchLocalMovies.ViewModel) {
        invokedDisplayLocalMovies = true
        invokedDisplayLocalMoviesCount += 1
        invokedDisplayLocalMoviesParameters = (viewModel, ())
        invokedDisplayLocalMoviesParametersList.append((viewModel, ()))
    }

    func displayFetchedLocalMoviesEmpty() {
        invokedDisplayFetchedLocalMoviesEmpty = true
        invokedDisplayFetchedLocalMoviesEmptyCount += 1
    }

    func displayMovieUnfavorite() {
        invokedDisplayMovieUnfavorite = true
        invokedDisplayMovieUnfavoriteCount += 1
    }

    func displayGenericError() {
        invokedDisplayGenericError = true
        invokedDisplayGenericErrorCount += 1
    }

    func displayMoviesBySearch(viewModel: Favorites.FetchLocalMoviesBySearch.ViewModel) {
        invokedDisplayMoviesBySearch = true
        invokedDisplayMoviesBySearchCount += 1
        invokedDisplayMoviesBySearchParameters = (viewModel, ())
        invokedDisplayMoviesBySearchParametersList.append((viewModel, ()))
    }

    func displaySearchError(searchedText: String) {
        invokedDisplaySearchError = true
        invokedDisplaySearchErrorCount += 1
        invokedDisplaySearchErrorParameters = (searchedText, ())
        invokedDisplaySearchErrorParametersList.append((searchedText, ()))
    }
}

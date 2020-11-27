//
//  FavoritesPresenterSpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class FavoritesPresenterSpy: FavoritesPresentationLogic {
    private(set) var invokedPresentFetchedMovies = false
    private(set) var invokedPresentFetchedMoviesCount = 0
    private(set) var invokedPresentFetchedMoviesParameters: (response: Favorites.FetchMovies.Response, Void)?
    private(set) var invokedPresentFetchedMoviesParametersList = [(response: Favorites.FetchMovies.Response, Void)]()

    private(set) var invokedPresentEmptyView = false
    private(set) var invokedPresentEmptyViewCount = 0

    private(set) var invokedPresentMovieUnfavorite = false
    private(set) var invokedPresentMovieUnfavoriteCount = 0

    private(set) var invokedPresentFailure = false
    private(set) var invokedPresentFailureCount = 0

    private(set) var invokedPresentSearchedMovies = false
    private(set) var invokedPresentSearchedMoviesCount = 0
    private(set) var invokedPresentSearchedMoviesParameters: (response: Favorites.FetchMoviesBySearch.Response, Void)?
    private(set) var invokedPresentSearchedMoviesParametersList = [(response: Favorites.FetchMoviesBySearch.Response, Void)]()

    private(set) var invokedPresentSearchedMoviesFailure = false
    private(set) var invokedPresentSearchedMoviesFailureCount = 0
    private(set) var invokedPresentSearchedMoviesFailureParameters: (filter: FilterSearch, Void)?
    private(set) var invokedPresentSearchedMoviesFailureParametersList = [(filter: FilterSearch, Void)]()

    // MARK: - FavoritesPresentationLogic conforms

    func presentFetchedMovies(response: Favorites.FetchMovies.Response) {
        invokedPresentFetchedMovies = true
        invokedPresentFetchedMoviesCount += 1
        invokedPresentFetchedMoviesParameters = (response, ())
        invokedPresentFetchedMoviesParametersList.append((response, ()))
    }

    func presentEmptyView() {
        invokedPresentEmptyView = true
        invokedPresentEmptyViewCount += 1
    }

    func presentMovieUnfavorite() {
        invokedPresentMovieUnfavorite = true
        invokedPresentMovieUnfavoriteCount += 1
    }

    func presentFailure() {
        invokedPresentFailure = true
        invokedPresentFailureCount += 1
    }

    func presentSearchedMovies(response: Favorites.FetchMoviesBySearch.Response) {
        invokedPresentSearchedMovies = true
        invokedPresentSearchedMoviesCount += 1
        invokedPresentSearchedMoviesParameters = (response, ())
        invokedPresentSearchedMoviesParametersList.append((response, ()))
    }

    func presentSearchedMoviesFailure(filter: FilterSearch) {
        invokedPresentSearchedMoviesFailure = true
        invokedPresentSearchedMoviesFailureCount += 1
        invokedPresentSearchedMoviesFailureParameters = (filter, ())
        invokedPresentSearchedMoviesFailureParametersList.append((filter, ()))
    }
}

//
//  FavoritesPresenterSpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class FavoritesPresenterSpy: FavoritesPresentationLogic {
    private(set) var invokedPresentFetchedLocalMovies = false
    private(set) var invokedPresentFetchedLocalMoviesCount = 0
    private(set) var invokedPresentFetchedLocalMoviesParameters: (response: Favorites.FetchLocalMovies.Response, Void)?
    private(set) var invokedPresentFetchedLocalMoviesParametersList = [(response: Favorites.FetchLocalMovies.Response, Void)]()

    private(set) var invokedPresentFetchedLocalMoviesEmpty = false
    private(set) var invokedPresentFetchedLocalMoviesEmptyCount = 0

    private(set) var invokedPresenterMovieUnfavorite = false
    private(set) var invokedPresenterMovieUnfavoriteCount = 0

    private(set) var invokedPresentGenericFailure = false
    private(set) var invokedPresentGenericFailureCount = 0

    private(set) var invokedPresentFetchedMoviesBySearch = false
    private(set) var invokedPresentFetchedMoviesBySearchCount = 0
    private(set) var invokedPresentFetchedMoviesBySearchParameters: (response: Favorites.FetchLocalMoviesBySearch.Response, Void)?
    private(set) var invokedPresentFetchedMoviesBySearchParametersList = [(response: Favorites.FetchLocalMoviesBySearch.Response, Void)]()

    private(set) var invokedPresentSearchedMoviesFailure = false
    private(set) var invokedPresentSearchedMoviesFailureCount = 0
    private(set) var invokedPresentSearchedMoviesFailureParameters: (filter: FilterSearch, Void)?
    private(set) var invokedPresentSearchedMoviesFailureParametersList = [(filter: FilterSearch, Void)]()

    // MARK: - FavoritesPresentationLogic conforms

    func presentFetchedLocalMovies(response: Favorites.FetchLocalMovies.Response) {
        invokedPresentFetchedLocalMovies = true
        invokedPresentFetchedLocalMoviesCount += 1
        invokedPresentFetchedLocalMoviesParameters = (response, ())
        invokedPresentFetchedLocalMoviesParametersList.append((response, ()))
    }

    func presentFetchedLocalMoviesEmpty() {
        invokedPresentFetchedLocalMoviesEmpty = true
        invokedPresentFetchedLocalMoviesEmptyCount += 1
    }

    func presentMovieUnfavorite() {
        invokedPresenterMovieUnfavorite = true
        invokedPresenterMovieUnfavoriteCount += 1
    }

    func presentGenericFailure() {
        invokedPresentGenericFailure = true
        invokedPresentGenericFailureCount += 1
    }

    func presentFetchedMoviesBySearch(response: Favorites.FetchLocalMoviesBySearch.Response) {
        invokedPresentFetchedMoviesBySearch = true
        invokedPresentFetchedMoviesBySearchCount += 1
        invokedPresentFetchedMoviesBySearchParameters = (response, ())
        invokedPresentFetchedMoviesBySearchParametersList.append((response, ()))
    }

    func presentSearchedMoviesFailure(filter: FilterSearch) {
        invokedPresentSearchedMoviesFailure = true
        invokedPresentSearchedMoviesFailureCount += 1
        invokedPresentSearchedMoviesFailureParameters = (filter, ())
        invokedPresentSearchedMoviesFailureParametersList.append((filter, ()))
    }
}

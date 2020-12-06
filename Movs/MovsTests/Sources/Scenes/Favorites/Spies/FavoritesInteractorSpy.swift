//
//  FavoritesInteractorSpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class FavoritesInteractorSpy: FavoritesBusinessLogic {
    private(set) var invokedFetchMovies = false
    private(set) var invokedFetchMoviesCount = 0

    private(set) var invokedFetchMoviesBySearch = false
    private(set) var invokedFetchMoviesBySearchCount = 0
    private(set) var invokedFetchMoviesBySearchParameters: (request: Favorites.FetchMoviesBySearch.Request, Void)?
    private(set) var invokedFetchMoviesBySearchParametersList = [(request: Favorites.FetchMoviesBySearch.Request, Void)]()

    private(set) var invokedDeleteMovie = false
    private(set) var invokedDeleteMovieCount = 0
    private(set) var invokedDeleteMovieParameters: (request: Favorites.DeleteMovie.Request, Void)?
    private(set) var invokedDeleteMovieParametersList = [(request: Favorites.DeleteMovie.Request, Void)]()

    // MARK: - FavoritesBusinessLogic conforms

    func fetchMovies() {
        invokedFetchMovies = true
        invokedFetchMoviesCount += 1
    }

    func fetchMoviesBySearch(request: Favorites.FetchMoviesBySearch.Request) {
        invokedFetchMoviesBySearch = true
        invokedFetchMoviesBySearchCount += 1
        invokedFetchMoviesBySearchParameters = (request, ())
        invokedFetchMoviesBySearchParametersList.append((request, ()))
    }

    func deleteMovie(request: Favorites.DeleteMovie.Request) {
        invokedDeleteMovie = true
        invokedDeleteMovieCount += 1
        invokedDeleteMovieParameters = (request, ())
        invokedDeleteMovieParametersList.append((request, ()))
    }
}

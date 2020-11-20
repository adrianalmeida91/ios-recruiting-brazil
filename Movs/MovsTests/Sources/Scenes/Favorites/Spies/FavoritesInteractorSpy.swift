//
//  FavoritesInteractorSpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class FavoritesInteractorSpy: FavoritesBusinessLogic {
    private(set) var invokedFetchLocalMovies = false
    private(set) var invokedFetchLocalMoviesCount = 0

    private(set) var invokedFetchLocalMoviesBySearch = false
    private(set) var invokedFetchLocalMoviesBySearchCount = 0
    private(set) var invokedFetchLocalMoviesBySearchParameters: (request: Favorites.FetchLocalMoviesBySearch.Request, Void)?
    private(set) var invokedFetchLocalMoviesBySearchParametersList = [(request: Favorites.FetchLocalMoviesBySearch.Request, Void)]()

    private(set) var invokedDeleteMovie = false
    private(set) var invokedDeleteMovieCount = 0
    private(set) var invokedDeleteMovieParameters: (request: Favorites.DeleteMovie.Request, Void)?
    private(set) var invokedDeleteMovieParametersList = [(request: Favorites.DeleteMovie.Request, Void)]()

    // MARK: - FavoritesBusinessLogic conforms

    func fetchLocalMovies() {
        invokedFetchLocalMovies = true
        invokedFetchLocalMoviesCount += 1
    }

    func fetchLocalMoviesBySearch(request: Favorites.FetchLocalMoviesBySearch.Request) {
        invokedFetchLocalMoviesBySearch = true
        invokedFetchLocalMoviesBySearchCount += 1
        invokedFetchLocalMoviesBySearchParameters = (request, ())
        invokedFetchLocalMoviesBySearchParametersList.append((request, ()))
    }

    func deleteMovie(request: Favorites.DeleteMovie.Request) {
        invokedDeleteMovie = true
        invokedDeleteMovieCount += 1
        invokedDeleteMovieParameters = (request, ())
        invokedDeleteMovieParametersList.append((request, ()))
    }
}

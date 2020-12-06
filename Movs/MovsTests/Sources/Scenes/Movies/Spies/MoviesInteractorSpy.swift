//
//  MoviesInteractorSpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 03/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class MoviesInteractorSpy: MoviesBusinessLogic {
    private(set) var invokedFetchMovies = false
    private(set) var invokedFetchMoviesCount = 0
    private(set) var invokedFetchMoviesParameters: (request: Movies.FetchMovies.Request, Void)?
    private(set) var invokedFetchMoviesParametersList = [(request: Movies.FetchMovies.Request, Void)]()

    private(set) var invokedFetchMoviesBySearch = false
    private(set) var invokedFetchMoviesBySearchCount = 0
    private(set) var invokedFetchMoviesBySearchParameters: (request: Movies.FetchMoviesBySearch.Request, Void)?
    private(set) var invokedFetchMoviesBySearchParametersList = [(request: Movies.FetchMoviesBySearch.Request, Void)]()

    // MARK: - MoviesBusinessLogic conforms

    func fetchMovies(request: Movies.FetchMovies.Request) {
        invokedFetchMovies = true
        invokedFetchMoviesCount += 1
        invokedFetchMoviesParameters = (request, ())
        invokedFetchMoviesParametersList.append((request, ()))
    }

    func fetchMoviesBySearch(request: Movies.FetchMoviesBySearch.Request) {
        invokedFetchMoviesBySearch = true
        invokedFetchMoviesBySearchCount += 1
        invokedFetchMoviesBySearchParameters = (request, ())
        invokedFetchMoviesBySearchParametersList.append((request, ()))
    }
}

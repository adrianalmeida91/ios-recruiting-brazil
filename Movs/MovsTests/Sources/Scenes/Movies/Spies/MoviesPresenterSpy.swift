//
//  MoviesPresenterSpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 08/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class MoviesPresenterSpy: MoviesPresentationLogic {
    private(set) var invokedPresentFetchedMovies = false
    private(set) var invokedPresentFetchedMoviesCount = 0
    private(set) var invokedPresentFetchedMoviesParameters: (response: Movies.FetchMovies.Response, Void)?
    private(set) var invokedPresentFetchedMoviesParametersList = [(response: Movies.FetchMovies.Response, Void)]()

    private(set) var invokedPresentFailure = false
    private(set) var invokedPresentFailureCount = 0

    private(set) var invokedPresentSearchedMovies = false
    private(set) var invokedPresentSearchedMoviesCount = 0
    private(set) var invokedPresentSearchedMoviesParameters: (response: Movies.FetchMoviesBySearch.Response, Void)?
    private(set) var invokedPresentSearchedMoviesParametersList = [(response: Movies.FetchMoviesBySearch.Response, Void)]()

    private(set) var invokedPresentSearchedFailure = false
    private(set) var invokedPresentSearchedFailureCount = 0
    private(set) var invokedPresentSearchedFailureParameters: (textSearched: String, Void)?
    private(set) var invokedPresentSearchedFailureParametersList = [(textSearched: String, Void)]()

    // MARK: - MoviesPresentationLogic conforms

    func presentFetchedMovies(response: Movies.FetchMovies.Response) {
        invokedPresentFetchedMovies = true
        invokedPresentFetchedMoviesCount += 1
        invokedPresentFetchedMoviesParameters = (response, ())
        invokedPresentFetchedMoviesParametersList.append((response, ()))
    }

    func presentFailure() {
        invokedPresentFailure = true
        invokedPresentFailureCount += 1
    }

    func presentSearchedMovies(response: Movies.FetchMoviesBySearch.Response) {
        invokedPresentSearchedMovies = true
        invokedPresentSearchedMoviesCount += 1
        invokedPresentSearchedMoviesParameters = (response, ())
        invokedPresentSearchedMoviesParametersList.append((response, ()))
    }

    func presentSearchedFailure(textSearched: String) {
        invokedPresentSearchedFailure = true
        invokedPresentSearchedFailureCount += 1
        invokedPresentSearchedFailureParameters = (textSearched, ())
        invokedPresentSearchedFailureParametersList.append((textSearched, ()))
    }
}

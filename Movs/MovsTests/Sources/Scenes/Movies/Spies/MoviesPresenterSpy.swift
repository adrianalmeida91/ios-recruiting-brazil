//
//  MoviesPresenterSpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 08/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class MoviesPresenterSpy: MoviesPresentationLogic {
    private(set) var invokedPresentFetchedLocalMovies = false
    private(set) var invokedPresentFetchedLocalMoviesCount = 0
    private(set) var invokedPresentFetchedLocalMoviesParameters: (response: Movies.FetchLocalMovies.Response, Void)?
    private(set) var invokedPresentFetchedLocalMoviesParametersList = [(response: Movies.FetchLocalMovies.Response, Void)]()

    private(set) var invokedPresentFetchedGenres = false
    private(set) var invokedPresentFetchedGenresCount = 0
    private(set) var invokedPresentFetchedGenresParameters: (response: Movies.FetchGenres.Response, Void)?
    private(set) var invokedPresentFetchedGenresParametersList = [(response: Movies.FetchGenres.Response, Void)]()

    private(set) var invokedPresentFetchedMovies = false
    private(set) var invokedPresentFetchedMoviesCount = 0
    private(set) var invokedPresentFetchedMoviesParameters: (response: Movies.FetchMovies.Response, Void)?
    private(set) var invokedPresentFetchedMoviesParametersList = [(response: Movies.FetchMovies.Response, Void)]()

    private(set) var invokedPresentFetchedFailure = false
    private(set) var invokedPresentFetchedFailureCount = 0

    private(set) var invokedPresentFetchedMoviesBySearch = false
    private(set) var invokedPresentFetchedMoviesBySearchCount = 0
    private(set) var invokedPresentFetchedMoviesBySearchParameters: (response: Movies.FetchLocalMoviesBySearch.Response, Void)?
    private(set) var invokedPresentFetchedMoviesBySearchParametersList = [(response: Movies.FetchLocalMoviesBySearch.Response, Void)]()

    private(set) var invokedPresentSearchedMoviesFailure = false
    private(set) var invokedPresentSearchedMoviesFailureCount = 0
    private(set) var invokedPresentSearchedMoviesFailureParameters: (textSearched: String, Void)?
    private(set) var invokedPresentSearchedMoviesFailureParametersList = [(textSearched: String, Void)]()

    // MARK: - MoviesPresentationLogic conforms

    func presentFetchedLocalMovies(response: Movies.FetchLocalMovies.Response) {
        invokedPresentFetchedLocalMovies = true
        invokedPresentFetchedLocalMoviesCount += 1
        invokedPresentFetchedLocalMoviesParameters = (response, ())
        invokedPresentFetchedLocalMoviesParametersList.append((response, ()))
    }

    func presentFetchedGenres(response: Movies.FetchGenres.Response) {
        invokedPresentFetchedGenres = true
        invokedPresentFetchedGenresCount += 1
        invokedPresentFetchedGenresParameters = (response, ())
        invokedPresentFetchedGenresParametersList.append((response, ()))
    }

    func presentFetchedMovies(response: Movies.FetchMovies.Response) {
        invokedPresentFetchedMovies = true
        invokedPresentFetchedMoviesCount += 1
        invokedPresentFetchedMoviesParameters = (response, ())
        invokedPresentFetchedMoviesParametersList.append((response, ()))
    }

    func presentFetchedFailure() {
        invokedPresentFetchedFailure = true
        invokedPresentFetchedFailureCount += 1
    }

    func presentFetchedMoviesBySearch(response: Movies.FetchLocalMoviesBySearch.Response) {
        invokedPresentFetchedMoviesBySearch = true
        invokedPresentFetchedMoviesBySearchCount += 1
        invokedPresentFetchedMoviesBySearchParameters = (response, ())
        invokedPresentFetchedMoviesBySearchParametersList.append((response, ()))
    }

    func presentSearchedMoviesFailure(textSearched: String) {
        invokedPresentSearchedMoviesFailure = true
        invokedPresentSearchedMoviesFailureCount += 1
        invokedPresentSearchedMoviesFailureParameters = (textSearched, ())
        invokedPresentSearchedMoviesFailureParametersList.append((textSearched, ()))
    }
}

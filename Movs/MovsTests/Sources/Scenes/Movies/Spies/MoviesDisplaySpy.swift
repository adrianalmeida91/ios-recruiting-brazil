//
//  MoviesViewSpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 09/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class MoviesDisplaySpy: MoviesDisplayLogic {
    private(set) var invokedOnFetchedLocalMovies = false
    private(set) var invokedOnFetchedLocalMoviesCount = 0
    private(set) var invokedOnFetchedLocalMoviesParameters: (viewModel: Movies.FetchLocalMovies.ViewModel, Void)?
    private(set) var invokedOnFetchedLocalMoviesParametersList = [(viewModel: Movies.FetchLocalMovies.ViewModel, Void)]()

    private(set) var invokedOnFetchedGenres = false
    private(set) var invokedOnFetchedGenresCount = 0
    private(set) var invokedOnFetchedGenresParameters: (viewModel: Movies.FetchGenres.ViewModel, Void)?
    private(set) var invokedOnFetchedGenresParametersList = [(viewModel: Movies.FetchGenres.ViewModel, Void)]()

    private(set) var invokedDisplayMovies = false
    private(set) var invokedDisplayMoviesCount = 0
    private(set) var invokedDisplayMoviesParameters: (viewModel: Movies.FetchMovies.ViewModel, Void)?
    private(set) var invokedDisplayMoviesParametersList = [(viewModel: Movies.FetchMovies.ViewModel, Void)]()

    private(set) var invokedDisplayGenericError = false
    private(set) var invokedDisplayGenericErrorCount = 0

    private(set) var invokedDisplayMoviesBySearch = false
    private(set) var invokedDisplayMoviesBySearchCount = 0
    private(set) var invokedDisplayMoviesBySearchParameters: (viewModel: Movies.FetchMoviesBySearch.ViewModel, Void)?
    private(set) var invokedDisplayMoviesBySearchParametersList = [(viewModel: Movies.FetchMoviesBySearch.ViewModel, Void)]()

    private(set) var invokedDisplaySearchError = false
    private(set) var invokedDisplaySearchErrorCount = 0
    private(set) var invokedDisplaySearchErrorParameters: (searchedText: String, Void)?
    private(set) var invokedDisplaySearchErrorParametersList = [(searchedText: String, Void)]()

    // MARK: - MoviesDisplayLogic conforms

    func onFetchedLocalMovies(viewModel: Movies.FetchLocalMovies.ViewModel) {
        invokedOnFetchedLocalMovies = true
        invokedOnFetchedLocalMoviesCount += 1
        invokedOnFetchedLocalMoviesParameters = (viewModel, ())
        invokedOnFetchedLocalMoviesParametersList.append((viewModel, ()))
    }

    func onFetchedGenres(viewModel: Movies.FetchGenres.ViewModel) {
        invokedOnFetchedGenres = true
        invokedOnFetchedGenresCount += 1
        invokedOnFetchedGenresParameters = (viewModel, ())
        invokedOnFetchedGenresParametersList.append((viewModel, ()))
    }

    func displayMovies(viewModel: Movies.FetchMovies.ViewModel) {
        invokedDisplayMovies = true
        invokedDisplayMoviesCount += 1
        invokedDisplayMoviesParameters = (viewModel, ())
        invokedDisplayMoviesParametersList.append((viewModel, ()))
    }

    func displayGenericError() {
        invokedDisplayGenericError = true
        invokedDisplayGenericErrorCount += 1
    }

    func displayMoviesBySearch(viewModel: Movies.FetchMoviesBySearch.ViewModel) {
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

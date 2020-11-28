//
//  MoviesViewSpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 09/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class MoviesDisplaySpy: MoviesDisplayLogic {
    private(set) var invokedDisplayMovies = false
    private(set) var invokedDisplayMoviesCount = 0
    private(set) var invokedDisplayMoviesParameters: (viewModel: Movies.FetchMovies.ViewModel, Void)?
    private(set) var invokedDisplayMoviesParametersList = [(viewModel: Movies.FetchMovies.ViewModel, Void)]()

    private(set) var invokedDisplayError = false
    private(set) var invokedDisplayErrorCount = 0

    private(set) var invokedDisplaySearchedMovies = false
    private(set) var invokedDisplaySearchedMoviesCount = 0
    private(set) var invokedDisplaySearchedMoviesParameters: (viewModel: Movies.FetchMoviesBySearch.ViewModel, Void)?
    private(set) var invokedDisplaySearchedMoviesParametersList = [(viewModel: Movies.FetchMoviesBySearch.ViewModel, Void)]()

    private(set) var invokedDisplaySearchError = false
    private(set) var invokedDisplaySearchErrorCount = 0
    private(set) var invokedDisplaySearchErrorParameters: (searchedText: String, Void)?
    private(set) var invokedDisplaySearchErrorParametersList = [(searchedText: String, Void)]()

    // MARK: - MoviesDisplayLogic conforms

    func displayMovies(viewModel: Movies.FetchMovies.ViewModel) {
        invokedDisplayMovies = true
        invokedDisplayMoviesCount += 1
        invokedDisplayMoviesParameters = (viewModel, ())
        invokedDisplayMoviesParametersList.append((viewModel, ()))
    }

    func displayError() {
        invokedDisplayError = true
        invokedDisplayErrorCount += 1
    }

    func displaySearchedMovies(viewModel: Movies.FetchMoviesBySearch.ViewModel) {
        invokedDisplaySearchedMovies = true
        invokedDisplaySearchedMoviesCount += 1
        invokedDisplaySearchedMoviesParameters = (viewModel, ())
        invokedDisplaySearchedMoviesParametersList.append((viewModel, ()))
    }

    func displaySearchError(searchedText: String) {
        invokedDisplaySearchError = true
        invokedDisplaySearchErrorCount += 1
        invokedDisplaySearchErrorParameters = (searchedText, ())
        invokedDisplaySearchErrorParametersList.append((searchedText, ()))
    }
}

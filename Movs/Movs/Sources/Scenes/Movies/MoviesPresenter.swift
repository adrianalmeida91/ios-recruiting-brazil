//
//  MoviesPresenter.swift
//  Movs
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol MoviesPresentationLogic: AnyObject {
    func presentFetchedMovies(response: Movies.FetchMovies.Response)
    func presentFailure()
    func presentSearchedMovies(response: Movies.FetchMoviesBySearch.Response)
    func presentSearchedFailure(textSearched: String)
}

final class MoviesPresenter: MoviesPresentationLogic {
    weak var viewController: MoviesDisplayLogic?

    // MARK: - MoviesPresentationLogic conforms

    func presentFetchedMovies(response: Movies.FetchMovies.Response) {
        let viewModel = Movies.FetchMovies.ViewModel(page: response.page, totalPages: response.totalPages, movies: response.movies)
        viewController?.displayMovies(viewModel: viewModel)
    }

    func presentFailure() {
        viewController?.displayGenericError()
    }

    func presentSearchedMovies(response: Movies.FetchMoviesBySearch.Response) {
        let viewModel = Movies.FetchMoviesBySearch.ViewModel(movies: response.movies)
        viewController?.displaySearchedMovies(viewModel: viewModel)
    }

    func presentSearchedFailure(textSearched: String) {
        viewController?.displaySearchError(searchedText: textSearched)
    }
}

//
//  FavoritesPresenter.swift
//  Movs
//
//  Created by Adrian Almeida on 31/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol FavoritesPresentationLogic: AnyObject {
    func presentFetchedMovies(response: Favorites.FetchMovies.Response)
    func presentEmptyView()
    func presentMovieUnfavorite()
    func presentFailure()
    func presentSearchedMovies(response: Favorites.FetchMoviesBySearch.Response)
    func presentSearchedMoviesFailure(filter: FilterSearch)
}

final class FavoritesPresenter: FavoritesPresentationLogic {
    weak var viewController: FavoritesDisplayLogic?

    // MARK: - FavoritesPresentationLogic conforms

    func presentFetchedMovies(response: Favorites.FetchMovies.Response) {
        let viewModel = Favorites.FetchMovies.ViewModel(movies: response.movies)
        viewController?.displayMovies(viewModel: viewModel)
    }

    func presentEmptyView() {
        viewController?.displayEmptyView()
    }

    func presentMovieUnfavorite() {
        viewController?.displayMovieUnfavorite()
    }

    func presentFailure() {
        viewController?.displayError()
    }

    func presentSearchedMovies(response: Favorites.FetchMoviesBySearch.Response) {
        let viewModel = Favorites.FetchMoviesBySearch.ViewModel(movies: response.movies)
        viewController?.displaySearchedMovies(viewModel: viewModel)
    }

    func presentSearchedMoviesFailure(filter: FilterSearch) {
        let search = filter.search ?? .empty
        let date = filter.date?.joined(separator: Constants.Utils.genresSeparator) ?? .empty
        let genres = filter.genres?.joined(separator: Constants.Utils.genresSeparator) ?? .empty
        let searchText = search + .space + date + .space + genres
        viewController?.displaySearchedError(searchedText: searchText.trimmingCharacters(in: .whitespaces))
    }
}

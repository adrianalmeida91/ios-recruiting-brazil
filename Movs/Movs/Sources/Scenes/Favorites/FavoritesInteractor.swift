//
//  FavoritesInteractor.swift
//  Movs
//
//  Created by Adrian Almeida on 31/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol FavoritesBusinessLogic: AnyObject {
    func fetchMovies()
    func fetchMoviesBySearch(request: Favorites.FetchMoviesBySearch.Request)
    func deleteMovie(request: Favorites.DeleteMovie.Request)
}

final class FavoritesInteractor: FavoritesBusinessLogic {
    private let worker: RealmWorkerProtocol
    private let presenter: FavoritesPresentationLogic

    // MARK: - Initializers

    init(worker: RealmWorkerProtocol, presenter: FavoritesPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }

    // MARK: - Private variables

    private var movies: [Movie] = []

    // MARK: - FavoritesBusinessLogic conforms

    func fetchMovies() {
        worker.fetchMovies() { result in
            switch result {
            case let .success(response):
                let movies = response.map { movie -> Movie in
                    movie.isFavorite = true
                    return movie
                }

                self.movies = movies

                if movies.count > 0 {
                    let responseModel = Favorites.FetchMovies.Response(movies: movies)
                    self.presenter.presentFetchedMovies(response: responseModel)
                } else {
                    self.presenter.presentEmptyView()
                }
            case let .failure(error):
                self.presentFailure(error: error)
            }
        }
    }

    func fetchMoviesBySearch(request: Favorites.FetchMoviesBySearch.Request) {
        let filter = request.filter
        let allDates = filter.date?.joined(separator: Constants.Utils.genresSeparator)

        var moviesFiltered: [Movie] = []

        moviesFiltered.append(contentsOf:
            movies.filter({ movie -> Bool in
                if let allDates = allDates {
                    if !allDates.localizedCaseInsensitiveContains(movie.releaseDate) {
                        return false
                    }
                }

                var moviesHasAllgenres = true
                if let genres = filter.genres {
                    genres.forEach({ genre in
                        if movie.genres == nil {
                            moviesHasAllgenres = false
                            return
                        } else if let movieGenres = movie.genres, !movieGenres.localizedCaseInsensitiveContains(genre) {
                            moviesHasAllgenres = false
                            return
                        }
                    })
                }

                if !moviesHasAllgenres {
                    return false
                }

                if let search = filter.search, !search.isEmpty {
                    return movie.title.localizedCaseInsensitiveContains(search)
                }

                return true
            })
        )

        if moviesFiltered.count > 0 {
            presenter.presentSearchedMovies(response: Favorites.FetchMoviesBySearch.Response(movies: moviesFiltered))
        } else {
            presenter.presentSearchedMoviesFailure(filter: filter)
        }
    }

    func deleteMovie(request: Favorites.DeleteMovie.Request) {
        worker.deleteMovie(movie: request.movie) { result in
            switch result {
            case .success():
                if let index = self.movies.firstIndex(of: request.movie) {
                    self.movies.remove(at: index)
                    self.presenter.presentMovieUnfavorite()
                }
            case let .failure(error):
                self.presentFailure(error: error)
            }
        }
    }

    // MARK: - Private functions

    private func presentFailure(error: Error) {
        print(error.localizedDescription)
        self.presenter.presentFailure()
    }
}

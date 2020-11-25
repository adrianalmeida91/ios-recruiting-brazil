//
//  MoviesInteractor.swift
//  Movs
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Combine

protocol MoviesBusinessLogic: AnyObject {
    func fetchMovies(request: Movies.FetchMovies.Request)
    func fetchMoviesBySearch(request: Movies.FetchMoviesBySearch.Request)
}

final class MoviesInteractor: MoviesBusinessLogic {
    private let realmWorker: RealmWorkerProtocol
    private let moyaWorker: MoyaWorkerProtocol
    private let presenter: MoviesPresentationLogic

    // MARK: - Private variables

    private var movies: [Movie] = []

    // MARK: - Initializers

    init(realmWorker: RealmWorkerProtocol, moyaWorker: MoyaWorkerProtocol, presenter: MoviesPresentationLogic) {
        self.moyaWorker = moyaWorker
        self.realmWorker = realmWorker
        self.presenter = presenter
    }

    // MARK: - MoviesBusinessLogic conforms

    func fetchMovies(request: Movies.FetchMovies.Request) {
        let fetchLocalMoviesResult = PassthroughSubject<[Movie], Never>()
        let fetchGenresResult = PassthroughSubject<[GenreResponse], Never>()
        let fetchMoviesResult = PassthroughSubject<MoviesPopulariesResponse, Never>()

        if request.page == Constants.MovieDefaultParameters.page {
            movies = []
        }

        let requestPublishersValues = Publishers.Zip3(fetchLocalMoviesResult, fetchGenresResult, fetchMoviesResult)
            .map { return $0 }
            .eraseToAnyPublisher()
            .sink { fetchedLocalMovies, fetchedGenres, fetchedMovies in
                let movies = fetchedMovies.moviesResponse.map { movieResponse -> Movie in
                    let genreLabels = movieResponse.genreIds.map { id -> String in
                        let genre = fetchedGenres.first { genre -> Bool in
                            genre.id == id
                        }

                        return genre?.name ?? .empty
                    }

                    let genres = genreLabels.count > 0 ? genreLabels.joined(separator: Constants.Utils.genresSeparator) : nil

                    let isFavorite = fetchedLocalMovies.first { $0.id == movieResponse.id } != nil

                    return Movie(id: movieResponse.id, title: movieResponse.title, imageURL: Constants.MovieNetwork.baseImageURL.appending(movieResponse.imageURL), genres: genres, releaseDate: movieResponse.releaseDate.year, overview: movieResponse.overview, isFavorite: isFavorite)
                }

                self.movies.append(contentsOf: movies)

                let response = Movies.FetchMovies.Response(page: fetchedMovies.page, totalPages: fetchedMovies.totalPages, movies: movies)
                self.presenter.presentFetchedMovies(response: response)
            }

        realmWorker.fetchMovies() { result in
            switch result {
            case let .success(response):
                fetchLocalMoviesResult.send(response)
                _ = requestPublishersValues
            case let .failure(error):
                self.presentFailure(error: error)
            }
        }

        moyaWorker.fetchGenres(language: request.language) { result in
            switch result {
            case let .success(response):
                fetchGenresResult.send(response.genres)
                _ = requestPublishersValues
            case let .failure(error):
                self.presentFailure(error: error)
            }
        }

        moyaWorker.fetchMovies(language: request.language, page: request.page) { result in
            switch result {
            case let .success(response):
                fetchMoviesResult.send(response)
                _ = requestPublishersValues
            case let .failure(error):
                self.presentFailure(error: error)
            }
        }
    }

    func fetchMoviesBySearch(request: Movies.FetchMoviesBySearch.Request) {
        guard !request.filter.isEmpty, movies.count > 0 else {
            return
        }

        let movies = self.movies.filter { $0.title.localizedCaseInsensitiveContains(request.filter) }

        if movies.count > 0 {
            let response = Movies.FetchMoviesBySearch.Response(movies: movies)
            presenter.presentSearchedMovies(response: response)
        } else {
            presenter.presentSearchedFailure(textSearched: request.filter)
        }
    }

    // MARK: - Private functions

    private func presentFailure(error: Error) {
        print(error.localizedDescription)
        self.presenter.presentFailure()
    }
}

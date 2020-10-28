//
//  MoviesInteractor.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

final class MoviesInteractor: MoviesBusinessLogic {
    private let worker: MoviesWorkerProtocol
    private let presenter: MoviesPresentationLogic

    // MARK: - Initializers

    init(worker: MoviesWorkerProtocol, presenter: MoviesPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }

    // MARK: - MoviesInteractor conforms

    func fetchMovies(request: MoviesModels.MoviesItems.Request) {
        worker.fetchMovies(language: request.language, page: request.page) { result in
            switch result {
            case let .success(response):
                let movies = response.movies.map { movie -> Movie in
                    Movie(id: movie.id, title: movie.title, imageURL: Constants.MovieNetwork.baseImageURL.appending(movie.imageURL))
                }

                let responseModel = MoviesModels.MoviesItems.Response(moviesResponse: MoviesPopulariesResponse(page: response.page, totalPages: response.totalPages, movies: movies))

                self.presenter.presentMoviesItems(response: responseModel)
            case let .failure(error):
                print(error.errorDescription)
                self.presenter.presentLoadMoviesFailure()
            }
        }
    }
}

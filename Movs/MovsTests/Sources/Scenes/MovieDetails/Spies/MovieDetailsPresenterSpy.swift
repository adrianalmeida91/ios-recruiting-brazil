//
//  MovieDetailsPresenterSpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 19/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class MovieDetailsPresenterSpy: MovieDetailsPresentationLogic {
    private(set) var invokedPresentFetchedMovie = false
    private(set) var invokedPresentFetchedMovieCount = 0
    private(set) var invokedPresentFetchedMovieParameters: (response: MovieDetails.FetchMovie.Response, Void)?
    private(set) var invokedPresentFetchedMovieParametersList = [(response: MovieDetails.FetchMovie.Response, Void)]()

    private(set) var invokedOnSaveMovieSuccessful = false
    private(set) var invokedOnSaveMovieSuccessfulCount = 0

    private(set) var invokedOnSaveMovieFailure = false
    private(set) var invokedOnSaveMovieFailureCount = 0

    private(set) var invokedOnDeleteMovieSuccessful = false
    private(set) var invokedOnDeleteMovieSuccessfulCount = 0

    private(set) var invokedOnDeleteMovieFailure = false
    private(set) var invokedOnDeleteMovieFailureCount = 0 

    // MARK: - MovieDetailsPresentationLogic conforms

    func presentFetchedMovie(response: MovieDetails.FetchMovie.Response) {
        invokedPresentFetchedMovie = true
        invokedPresentFetchedMovieCount += 1
        invokedPresentFetchedMovieParameters = (response, ())
        invokedPresentFetchedMovieParametersList.append((response, ()))
    }

    func onSaveMovieSuccessful() {
        invokedOnSaveMovieSuccessful = true
        invokedOnSaveMovieSuccessfulCount += 1
    }

    func onSaveMovieFailure() {
        invokedOnSaveMovieFailure = true
        invokedOnSaveMovieFailureCount += 1
    }

    func onDeleteMovieSuccessful() {
        invokedOnDeleteMovieSuccessful = true
        invokedOnDeleteMovieSuccessfulCount += 1
    }

    func onDeleteMovieFailure() {
        invokedOnDeleteMovieFailure = true
        invokedOnDeleteMovieFailureCount += 1
    }
}

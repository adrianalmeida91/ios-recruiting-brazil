//
//  MovieDetailsInteractorTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 19/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

final class MovieDetailsInteractorTests: XCTestCase {
    private lazy var sut = MovieDetailsInteractor(worker: workerSpy, presenter: presenterSpy)

    // MARK: - Private constants

    private let workerSpy = RealmWorkerSpy()

    private let presenterSpy = MovieDetailsPresenterSpy()

    private let movie = MocksHelper.getMovie()

    // MARK: - Test functions

    func testInitialization() {
        _ = sut

        XCTAssertFalse(workerSpy.invokedFetchMovies)
        XCTAssertFalse(workerSpy.invokedSaveMovie)
        XCTAssertFalse(workerSpy.invokedDeleteMovie)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMovie)
        XCTAssertFalse(presenterSpy.invokedOnSaveMovieSuccessful)
        XCTAssertFalse(presenterSpy.invokedOnSaveMovieFailure)
        XCTAssertFalse(presenterSpy.invokedOnDeleteMovieSuccessful)
        XCTAssertFalse(presenterSpy.invokedOnDeleteMovieFailure)
    }

    func testFetchMovieShouldPresentFetchedMovie() throws {
        try fetchMovieAndValidate()
    }

    func testFetchMovieShouldPresentError() throws {
        try fetchMovieAndValidate(isSuccess: false)
    }

    func testSaveMovieShouldPresentSaveMovieSuccessful() throws {
        try saveMovieAndValidate()
    }

    func testSaveMovieShouldPresentSaveMovieFailure() throws {
        try saveMovieAndValidate(isSuccess: false)
    }

    func testDeleteMovieShouldPresentDeleteMovieSuccessful() throws {
        try deleteMovieAndValidate()
    }

    func testDeleteMovieShouldPresentDeleteMovieFailure() throws {
        try deleteMovieAndValidate(isSuccess: false)
    }

    // MARK: - Private functions

    private func fetchMovieAndValidate(isSuccess: Bool = true) throws {
        workerSpy.stubbedFetchMoviesCompletionResult = isSuccess ? (.success([movie]), ()) : (.failure(MocksHelper.Error.test), ())

        let request = MovieDetails.FetchMovie.Request(id: movie.id)
        sut.fetchMovie(request: request)

        XCTAssertTrue(workerSpy.invokedFetchMovies)
        XCTAssertEqual(workerSpy.invokedFetchMoviesCount, 1)

        XCTAssertFalse(workerSpy.invokedSaveMovie)
        XCTAssertFalse(workerSpy.invokedDeleteMovie)
        XCTAssertFalse(presenterSpy.invokedOnSaveMovieSuccessful)
        XCTAssertFalse(presenterSpy.invokedOnSaveMovieFailure)
        XCTAssertFalse(presenterSpy.invokedOnDeleteMovieSuccessful)
        XCTAssertFalse(presenterSpy.invokedOnDeleteMovieFailure)

        if !isSuccess {
            return XCTAssertFalse(presenterSpy.invokedPresentFetchedMovie)
        }

        let parameters = try XCTUnwrap(presenterSpy.invokedPresentFetchedMovieParameters)

        XCTAssertTrue(presenterSpy.invokedPresentFetchedMovie)
        XCTAssertEqual(presenterSpy.invokedPresentFetchedMovieCount, 1)
        XCTAssertEqual(parameters.response.movie, movie)
        XCTAssertEqual(presenterSpy.invokedPresentFetchedMovieParametersList.count, 1)
    }

    private func saveMovieAndValidate(isSuccess: Bool = true) throws {
        workerSpy.stubbedSaveMovieCompletionResult = isSuccess ? (.success(()), ()) : (.failure(MocksHelper.Error.test), ())

        let request = MovieDetails.SaveMovie.Request(movie: movie)
        sut.saveMovie(request: request)

        let parameters = try XCTUnwrap(workerSpy.invokedSaveMovieParameters)

        XCTAssertTrue(workerSpy.invokedSaveMovie)
        XCTAssertEqual(workerSpy.invokedSaveMovieCount, 1)
        XCTAssertEqual(parameters.movie, movie)
        XCTAssertEqual(workerSpy.invokedSaveMovieParametersList.count, 1)

        if isSuccess {
            XCTAssertTrue(presenterSpy.invokedOnSaveMovieSuccessful)
            XCTAssertEqual(presenterSpy.invokedOnSaveMovieSuccessfulCount, 1)
            XCTAssertFalse(presenterSpy.invokedOnSaveMovieFailure)
        } else {
            XCTAssertTrue(presenterSpy.invokedOnSaveMovieFailure)
            XCTAssertEqual(presenterSpy.invokedOnSaveMovieFailureCount, 1)
            XCTAssertFalse(presenterSpy.invokedOnSaveMovieSuccessful)
        }

        XCTAssertFalse(workerSpy.invokedFetchMovies)
        XCTAssertFalse(workerSpy.invokedDeleteMovie)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMovie)
        XCTAssertFalse(presenterSpy.invokedOnDeleteMovieSuccessful)
        XCTAssertFalse(presenterSpy.invokedOnDeleteMovieFailure)
    }

    private func deleteMovieAndValidate(isSuccess: Bool = true) throws {
        workerSpy.stubbedDeleteMovieCompletionResult = isSuccess ? (.success(()), ()) : (.failure(MocksHelper.Error.test), ())

        let request = MovieDetails.DeleteMovie.Request(movie: movie)
        sut.deleteMovie(request: request)

        let parameters = try XCTUnwrap(workerSpy.invokedDeleteMovieParameters)

        XCTAssertTrue(workerSpy.invokedDeleteMovie)
        XCTAssertEqual(workerSpy.invokedDeleteMovieCount, 1)
        XCTAssertEqual(parameters.movie, movie)
        XCTAssertEqual(workerSpy.invokedDeleteMovieParametersList.count, 1)

        if isSuccess {
            XCTAssertTrue(presenterSpy.invokedOnDeleteMovieSuccessful)
            XCTAssertEqual(presenterSpy.invokedOnDeleteMovieSuccessfulCount, 1)
            XCTAssertFalse(presenterSpy.invokedOnDeleteMovieFailure)
        } else {
            XCTAssertTrue(presenterSpy.invokedOnDeleteMovieFailure)
            XCTAssertEqual(presenterSpy.invokedOnDeleteMovieFailureCount, 1)
            XCTAssertFalse(presenterSpy.invokedOnDeleteMovieSuccessful)
        }

        XCTAssertFalse(workerSpy.invokedFetchMovies)
        XCTAssertFalse(workerSpy.invokedSaveMovie)
        XCTAssertFalse(presenterSpy.invokedPresentFetchedMovie)
        XCTAssertFalse(presenterSpy.invokedOnSaveMovieSuccessful)
        XCTAssertFalse(presenterSpy.invokedOnSaveMovieFailure)
    }
}

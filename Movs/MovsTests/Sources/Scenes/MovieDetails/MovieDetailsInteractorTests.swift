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

    private let movie = MocksHelper.getMockedMovie()

    // MARK: - Test functions

    func testInitialization() {
        _ = sut

        XCTAssertFalse(workerSpy.invokedFetchMovies)
        XCTAssertFalse(workerSpy.invokedSaveMovie)
        XCTAssertFalse(workerSpy.invokedDeleteMovie)
        XCTAssertFalse(presenterSpy.invokedOnSaveMovieSuccessful)
        XCTAssertFalse(presenterSpy.invokedOnSaveMovieFailure)
        XCTAssertFalse(presenterSpy.invokedOnDeleteMovieSuccessful)
        XCTAssertFalse(presenterSpy.invokedOnDeleteMovieFailure)
    }

    func testSaveMovieSuccessful() throws {
        workerSpy.stubbedSaveMovieCompletionResult = (.success(()), ())

        let viewModel = MovieDetails.SaveMovie.Request(movie: movie)
        sut.saveMovie(request: viewModel)

        let parameters = try XCTUnwrap(workerSpy.invokedSaveMovieParameters)

        XCTAssertTrue(workerSpy.invokedSaveMovie)
        XCTAssertEqual(workerSpy.invokedSaveMovieCount, 1)
        XCTAssertEqual(parameters.movie, movie)
        XCTAssertEqual(workerSpy.invokedSaveMovieParametersList.count, 1)
        XCTAssertTrue(presenterSpy.invokedOnSaveMovieSuccessful)
        XCTAssertEqual(presenterSpy.invokedOnSaveMovieSuccessfulCount, 1)

        XCTAssertFalse(workerSpy.invokedFetchMovies)
        XCTAssertFalse(workerSpy.invokedDeleteMovie)
        XCTAssertFalse(presenterSpy.invokedOnSaveMovieFailure)
        XCTAssertFalse(presenterSpy.invokedOnDeleteMovieSuccessful)
        XCTAssertFalse(presenterSpy.invokedOnDeleteMovieFailure)
    }

    func testSaveMovieWithFailure() throws {
        workerSpy.stubbedSaveMovieCompletionResult = (.failure(.unknown), ())

        let viewModel = MovieDetails.SaveMovie.Request(movie: movie)
        sut.saveMovie(request: viewModel)

        let parameters = try XCTUnwrap(workerSpy.invokedSaveMovieParameters)

        XCTAssertTrue(workerSpy.invokedSaveMovie)
        XCTAssertEqual(workerSpy.invokedSaveMovieCount, 1)
        XCTAssertEqual(parameters.movie, movie)
        XCTAssertTrue(presenterSpy.invokedOnSaveMovieFailure)
        XCTAssertEqual(presenterSpy.invokedOnSaveMovieFailureCount, 1)

        XCTAssertFalse(workerSpy.invokedFetchMovies)
        XCTAssertFalse(workerSpy.invokedDeleteMovie)
        XCTAssertFalse(presenterSpy.invokedOnSaveMovieSuccessful)
        XCTAssertFalse(presenterSpy.invokedOnDeleteMovieSuccessful)
        XCTAssertFalse(presenterSpy.invokedOnDeleteMovieFailure)
    }

    func testDeleteMovieSuccessful() throws {
        workerSpy.stubbedDeleteMovieCompletionResult = (.success(()), ())

        let viewModel = MovieDetails.DeleteMovie.Request(movie: movie)
        sut.deleteMovie(request: viewModel)

        let parameters = try XCTUnwrap(workerSpy.invokedDeleteMovieParameters)

        XCTAssertTrue(workerSpy.invokedDeleteMovie)
        XCTAssertEqual(workerSpy.invokedDeleteMovieCount, 1)
        XCTAssertEqual(parameters.movie, movie)
        XCTAssertEqual(workerSpy.invokedDeleteMovieParametersList.count, 1)
        XCTAssertTrue(presenterSpy.invokedOnDeleteMovieSuccessful)
        XCTAssertEqual(presenterSpy.invokedOnDeleteMovieSuccessfulCount, 1)

        XCTAssertFalse(workerSpy.invokedFetchMovies)
        XCTAssertFalse(workerSpy.invokedSaveMovie)
        XCTAssertFalse(presenterSpy.invokedOnSaveMovieSuccessful)
        XCTAssertFalse(presenterSpy.invokedOnSaveMovieFailure)
        XCTAssertFalse(presenterSpy.invokedOnDeleteMovieFailure)
    }

    func testDeleteMoviesWithFailure() throws {
        workerSpy.stubbedDeleteMovieCompletionResult = (.failure(.unknown), ())

        let viewModel = MovieDetails.DeleteMovie.Request(movie: movie)
        sut.deleteMovie(request: viewModel)

        let parameters = try XCTUnwrap(workerSpy.invokedDeleteMovieParameters)

        XCTAssertTrue(workerSpy.invokedDeleteMovie)
        XCTAssertEqual(workerSpy.invokedDeleteMovieCount, 1)
        XCTAssertEqual(parameters.movie, movie)
        XCTAssertEqual(workerSpy.invokedDeleteMovieParametersList.count, 1)
        XCTAssertTrue(presenterSpy.invokedOnDeleteMovieFailure)
        XCTAssertEqual(presenterSpy.invokedOnDeleteMovieFailureCount, 1)

        XCTAssertFalse(workerSpy.invokedFetchMovies)
        XCTAssertFalse(workerSpy.invokedSaveMovie)
        XCTAssertFalse(presenterSpy.invokedOnSaveMovieSuccessful)
        XCTAssertFalse(presenterSpy.invokedOnSaveMovieFailure)
        XCTAssertFalse(presenterSpy.invokedOnDeleteMovieSuccessful)
    }
}

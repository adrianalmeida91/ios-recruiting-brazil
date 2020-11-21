//
//  FilterInteractorTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

final class FilterInteractorTests: XCTestCase {
    private lazy var sut = FilterInteractor(worker: workerSpy, presenter: presenterSpy)

    // MARK: - Private constants

    private let workerSpy = MoyaWorkerSpy()

    private let presenterSpy = FilterPresenterSpy()

    // MARK: - Test functions

    func testInitialization() {
        _ = sut

        XCTAssertFalse(workerSpy.invokedFetchGenres)
        XCTAssertFalse(workerSpy.invokedFetchMovies)
        XCTAssertFalse(presenterSpy.invokedOnFetchedDates)
        XCTAssertFalse(presenterSpy.invokedOnFetchedGenres)
        XCTAssertFalse(presenterSpy.invokedOnFetchedGenresFailure)
    }

    func testFetchDatesShouldCreateDatesAndPresent() throws {
        sut.fetchDates()

        let parameters = try XCTUnwrap(presenterSpy.invokedOnFetchedDatesParameters)

        XCTAssertTrue(presenterSpy.invokedOnFetchedDates)
        XCTAssertEqual(presenterSpy.invokedOnFetchedDatesCount, 1)
        XCTAssertEqual(parameters.response.dates.count, 201)
        XCTAssertEqual(presenterSpy.invokedOnFetchedDatesParametersList.count, 1)

        XCTAssertFalse(workerSpy.invokedFetchGenres)
        XCTAssertFalse(workerSpy.invokedFetchMovies)
        XCTAssertFalse(presenterSpy.invokedOnFetchedGenres)
        XCTAssertFalse(presenterSpy.invokedOnFetchedGenresFailure)
    }

    func testFetchGenresShouldLoadGenresAndPresent() throws {
        let genresResponse = GenresResponse(path: JSONMocks.genresResponse.rawValue)
        workerSpy.stubbedFetchGenresCompletionResult = (.success(genresResponse), ())

        let request = Filter.FetchGenres.Request(language: Constants.MovieDefaultParameters.language)
        sut.fetchGenres(request: request)

        let workerParameters = try XCTUnwrap(workerSpy.invokedFetchGenresParameters)

        let presenterParameters = try XCTUnwrap(presenterSpy.invokedOnFetchedGenresParameters)

        XCTAssertTrue(workerSpy.invokedFetchGenres)
        XCTAssertEqual(workerSpy.invokedFetchGenresCount, 1)
        XCTAssertEqual(workerParameters.language, Constants.MovieDefaultParameters.language)
        XCTAssertEqual(workerSpy.invokedFetchGenresParametersList.count, 1)
        XCTAssertTrue(presenterSpy.invokedOnFetchedGenres)
        XCTAssertEqual(presenterSpy.invokedOnFetchedGenresCount, 1)
        XCTAssertTrue(presenterParameters.response.genres.count > 0)
        XCTAssertEqual(presenterSpy.invokedOnFetchedGenresParametersList.count, 1)

        XCTAssertFalse(workerSpy.invokedFetchMovies)
        XCTAssertFalse(presenterSpy.invokedOnFetchedDates)
        XCTAssertFalse(presenterSpy.invokedOnFetchedGenresFailure)
    }

    func testFetchGenresWithFailureShouldDisplayGenericFailure() throws {
        workerSpy.stubbedFetchGenresCompletionResult = (.failure(.unknown), ())

        let request = Filter.FetchGenres.Request(language: Constants.MovieDefaultParameters.language)
        sut.fetchGenres(request: request)

        let parameters = try XCTUnwrap(workerSpy.invokedFetchGenresParameters)

        XCTAssertTrue(workerSpy.invokedFetchGenres)
        XCTAssertEqual(workerSpy.invokedFetchGenresCount, 1)
        XCTAssertEqual(parameters.language, Constants.MovieDefaultParameters.language)
        XCTAssertEqual(workerSpy.invokedFetchGenresParametersList.count, 1)
        XCTAssertTrue(presenterSpy.invokedOnFetchedGenresFailure)
        XCTAssertEqual(presenterSpy.invokedOnFetchedGenresFailureCount, 1)

        XCTAssertFalse(workerSpy.invokedFetchMovies)
        XCTAssertFalse(presenterSpy.invokedOnFetchedDates)
        XCTAssertFalse(presenterSpy.invokedOnFetchedGenres)
    }
}

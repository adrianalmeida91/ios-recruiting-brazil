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
        XCTAssertFalse(presenterSpy.invokedPresentDates)
        XCTAssertFalse(presenterSpy.invokedPresentGenres)
        XCTAssertFalse(presenterSpy.invokedPresentFailure)
    }

    func testFetchDatesShouldPresentDates() throws {
        sut.fetchDates()

        let parameters = try XCTUnwrap(presenterSpy.invokedPresentDatesParameters)

        XCTAssertTrue(presenterSpy.invokedPresentDates)
        XCTAssertEqual(presenterSpy.invokedPresentDatesCount, 1)
        XCTAssertGreaterThan(parameters.response.dates.count, 0)
        XCTAssertEqual(presenterSpy.invokedPresentDatesParametersList.count, 1)

        XCTAssertFalse(workerSpy.invokedFetchGenres)
        XCTAssertFalse(workerSpy.invokedFetchMovies)
        XCTAssertFalse(presenterSpy.invokedPresentGenres)
        XCTAssertFalse(presenterSpy.invokedPresentFailure)
    }

    func testFetchGenresShouldDisplayPresentGenres() throws {
        try fetchGenresRequestWithMockValues()
    }

    func testFetchGenresShouldDisplayFailure() throws {
        try fetchGenresRequestWithMockValues(isSuccess: false)
    }

    // MARK: - Private functions

    private func fetchGenresRequestWithMockValues(isSuccess: Bool = true) throws {
        let genresResponse = GenresResponse(path: JSONMocks.genresResponse.rawValue)
        workerSpy.stubbedFetchGenresCompletionResult = isSuccess ? (.success(genresResponse), ()) : (.failure(MocksHelper.Error.test), ())

        let request = Filter.FetchGenres.Request(language: Constants.MovieDefaultParameters.language)
        sut.fetchGenres(request: request)

        let workerParameters = try XCTUnwrap(workerSpy.invokedFetchGenresParameters)

        XCTAssertTrue(workerSpy.invokedFetchGenres)
        XCTAssertEqual(workerSpy.invokedFetchGenresCount, 1)
        XCTAssertEqual(workerParameters.language, Constants.MovieDefaultParameters.language)
        XCTAssertEqual(workerSpy.invokedFetchGenresParametersList.count, 1)

        if isSuccess {
            let presenterParameters = try XCTUnwrap(presenterSpy.invokedPresentGenresParameters)

            XCTAssertTrue(presenterSpy.invokedPresentGenres)
            XCTAssertEqual(presenterSpy.invokedPresentGenresCount, 1)
            XCTAssertGreaterThan(presenterParameters.response.genres.count, 0)
            XCTAssertEqual(presenterSpy.invokedPresentGenresParametersList.count, 1)
            XCTAssertFalse(presenterSpy.invokedPresentFailure)
        } else {
            XCTAssertTrue(presenterSpy.invokedPresentFailure)
            XCTAssertEqual(presenterSpy.invokedPresentFailureCount, 1)
            XCTAssertFalse(presenterSpy.invokedPresentGenres)
        }

        XCTAssertFalse(workerSpy.invokedFetchMovies)
        XCTAssertFalse(presenterSpy.invokedPresentDates)
    }
}

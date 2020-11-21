//
//  FilterPresenterTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 20/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

final class FilterPresenterTests: XCTestCase {
    private lazy var sut: FilterPresenter = {
        let presenter = FilterPresenter()
        presenter.viewController = displaySpy

        return presenter
    }()

    // MARK: - Private constants

    private let displaySpy = FilterDisplaySpy()

    // MARK: - Test functions

    func testInitialization() {
        _ = sut

        XCTAssertFalse(displaySpy.invokedOnFetchedDates)
        XCTAssertFalse(displaySpy.invokedOnFetchedGenres)
        XCTAssertFalse(displaySpy.invokedDisplayGenericError)
    }

    func testOnFetchedDatesShouldLoadDatesOnViewController() throws {
        let response = Filter.FetchDates.Response(dates: ["2020", "2019", "2018"])
        sut.onFetchedDates(response: response)

        let parameters = try XCTUnwrap(displaySpy.invokedOnFetchedDatesParameters)

        XCTAssertTrue(displaySpy.invokedOnFetchedDates)
        XCTAssertEqual(displaySpy.invokedOnFetchedDatesCount, 1)
        XCTAssertEqual(parameters.viewModel.dates, response.dates)
        XCTAssertEqual(displaySpy.invokedOnFetchedDatesParametersList.count, 1)

        XCTAssertFalse(displaySpy.invokedOnFetchedGenres)
        XCTAssertFalse(displaySpy.invokedDisplayGenericError)
    }

    func testOnFetchedGenresShouldLoadGenresOnViewController() throws {
        let response = Filter.FetchGenres.Response(genres: ["Action", "Thriller"])
        sut.onFetchedGenres(response: response)

        let parameters = try XCTUnwrap(displaySpy.invokedOnFetchedGenresParameters)

        XCTAssertTrue(displaySpy.invokedOnFetchedGenres)
        XCTAssertEqual(displaySpy.invokedOnFetchedGenresCount, 1)
        XCTAssertEqual(parameters.viewModel.genres, response.genres)
        XCTAssertEqual(displaySpy.invokedOnFetchedGenresParametersList.count, 1)

        XCTAssertFalse(displaySpy.invokedOnFetchedDates)
        XCTAssertFalse(displaySpy.invokedDisplayGenericError)
    }

    func testOnFetchedGenresFailureShouldDisplayGenericError() {
        sut.onFetchedGenresFailure()

        XCTAssertTrue(displaySpy.invokedDisplayGenericError)
        XCTAssertEqual(displaySpy.invokedDisplayGenericErrorCount, 1)

        XCTAssertFalse(displaySpy.invokedOnFetchedDates)
        XCTAssertFalse(displaySpy.invokedOnFetchedGenres)
    }
}

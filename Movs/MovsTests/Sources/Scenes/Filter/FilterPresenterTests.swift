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

        XCTAssertFalse(displaySpy.invokedDisplayDates)
        XCTAssertFalse(displaySpy.invokedDisplayGenres)
        XCTAssertFalse(displaySpy.invokedDisplayError)
    }

    func testPresentDatesShouldDisplayDates() throws {
        let dates = MocksHelper.getDates()
        let response = Filter.FetchDates.Response(dates: dates)
        sut.presentDates(response: response)

        let parameters = try XCTUnwrap(displaySpy.invokedDisplayDatesParameters)

        XCTAssertTrue(displaySpy.invokedDisplayDates)
        XCTAssertEqual(displaySpy.invokedDisplayDatesCount, 1)
        XCTAssertEqual(parameters.viewModel.dates, dates)
        XCTAssertEqual(displaySpy.invokedDisplayDatesParametersList.count, 1)

        XCTAssertFalse(displaySpy.invokedDisplayGenres)
        XCTAssertFalse(displaySpy.invokedDisplayError)
    }

    func testPresentGenresShouldDisplayGenres() throws {
        let genres = MocksHelper.getGenres()
        let response = Filter.FetchGenres.Response(genres: genres)
        sut.presentGenres(response: response)

        let parameters = try XCTUnwrap(displaySpy.invokedDisplayGenresParameters)

        XCTAssertTrue(displaySpy.invokedDisplayGenres)
        XCTAssertEqual(displaySpy.invokedDisplayGenresCount, 1)
        XCTAssertEqual(parameters.viewModel.genres, genres)
        XCTAssertEqual(displaySpy.invokedDisplayGenresParametersList.count, 1)

        XCTAssertFalse(displaySpy.invokedDisplayDates)
        XCTAssertFalse(displaySpy.invokedDisplayError)
    }

    func testPresentFailureShouldDisplayError() {
        sut.presentFailure()

        XCTAssertTrue(displaySpy.invokedDisplayError)
        XCTAssertEqual(displaySpy.invokedDisplayErrorCount, 1)

        XCTAssertFalse(displaySpy.invokedDisplayDates)
        XCTAssertFalse(displaySpy.invokedDisplayGenres)
    }
}

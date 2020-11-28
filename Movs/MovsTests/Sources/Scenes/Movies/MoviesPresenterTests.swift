//
//  MoviesPresenterTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 09/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import XCTest
@testable import Movs

final class MoviesPresenterTests: XCTestCase {
    private lazy var sut: MoviesPresenter = {
        let presenter = MoviesPresenter()
        presenter.viewController = displaySpy

        return presenter
    }()

    // MARK: - Private constants

    private let displaySpy = MoviesDisplaySpy()

    // MARK: - Test functions

    func testInitialization() {
        _ = sut

        XCTAssertFalse(displaySpy.invokedDisplayMovies)
        XCTAssertFalse(displaySpy.invokedDisplayError)
        XCTAssertFalse(displaySpy.invokedDisplaySearchedMovies)
        XCTAssertFalse(displaySpy.invokedDisplaySearchError)
    }

    func testPresentFetchedMoviesShouldDisplayMovies() throws {
        let page = 1
        let totalPage = 500
        let movies = MocksHelper.getMockedMovies()
        let response = Movies.FetchMovies.Response(page: page, totalPages: totalPage, movies: movies)
        sut.presentFetchedMovies(response: response)

        let parameters = try XCTUnwrap(displaySpy.invokedDisplayMoviesParameters)

        XCTAssertTrue(displaySpy.invokedDisplayMovies)
        XCTAssertEqual(displaySpy.invokedDisplayMoviesCount, 1)
        XCTAssertEqual(parameters.viewModel.page, page)
        XCTAssertEqual(parameters.viewModel.totalPages, totalPage)
        XCTAssertEqual(parameters.viewModel.movies, movies)
        XCTAssertEqual(displaySpy.invokedDisplayMoviesParametersList.count, 1)

        XCTAssertFalse(displaySpy.invokedDisplayError)
        XCTAssertFalse(displaySpy.invokedDisplaySearchedMovies)
        XCTAssertFalse(displaySpy.invokedDisplaySearchError)
    }

    func testPresentFailureShouldDisplayError() {
        sut.presentFailure()

        XCTAssertTrue(displaySpy.invokedDisplayError)

        XCTAssertFalse(displaySpy.invokedDisplayMovies)
        XCTAssertFalse(displaySpy.invokedDisplaySearchedMovies)
        XCTAssertFalse(displaySpy.invokedDisplaySearchError)
    }

    func testPresentSearchedMoviesShouldDisplaySearchedMovies() throws {
        let movies = MocksHelper.getMockedMovies()
        let response = Movies.FetchMoviesBySearch.Response(movies: movies)
        sut.presentSearchedMovies(response: response)

        let parameters = try XCTUnwrap(displaySpy.invokedDisplaySearchedMoviesParameters)

        XCTAssertTrue(displaySpy.invokedDisplaySearchedMovies)
        XCTAssertEqual(displaySpy.invokedDisplaySearchedMoviesCount, 1)
        XCTAssertEqual(parameters.viewModel.movies, movies)
        XCTAssertEqual(displaySpy.invokedDisplaySearchedMoviesParametersList.count, 1)

        XCTAssertFalse(displaySpy.invokedDisplayMovies)
        XCTAssertFalse(displaySpy.invokedDisplayError)
        XCTAssertFalse(displaySpy.invokedDisplaySearchError)
    }

    func testPresentSearchedFailureShouldDisplaySearchError() throws {
        let search = "aaaaaaaaaa"
        sut.presentSearchedFailure(textSearched: search)

        let parameters = try XCTUnwrap(displaySpy.invokedDisplaySearchErrorParameters)

        XCTAssertTrue(displaySpy.invokedDisplaySearchError)
        XCTAssertEqual(displaySpy.invokedDisplaySearchErrorCount, 1)
        XCTAssertEqual(parameters.searchedText, search)
        XCTAssertEqual(displaySpy.invokedDisplaySearchErrorParametersList.count, 1)

        XCTAssertFalse(displaySpy.invokedDisplayMovies)
        XCTAssertFalse(displaySpy.invokedDisplayError)
        XCTAssertFalse(displaySpy.invokedDisplaySearchedMovies)
    }
}
